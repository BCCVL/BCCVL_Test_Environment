include:
  - bccvl.iptables
  - bccvl.supervisord
  - bccvl.httpd

stop supervisord:
  service:
    - dead
    - require:
      - pkg: supervisor

Visualiser Requirements:
    pkg.installed:
      - pkgs:
        - git
        - readline-devel
        - libpng-devel
        - gd-devel
        - giflib-devel
        - patch
        - zlib-devel
        - bzip2-devel
        - openssl-devel
        - ncurses-devel
        - tk-devel
        - libjpeg-turbo-devel
        - lapack-devel
        - python27-devel
      - require:
        - pkgrepo: erpel
        - service: stop supervisord

visualiser:
  user.present:
    - fullname: Visualiser
    - shell: /bin/bash
    - createhome: true
    - gid_from_name: true

Visualiser Clone:
  git.latest:
    - name: https://github.com/BCCVL/BCCVL_Visualiser.git
    - target: /home/visualiser/BCCVL_Visualiser
    - runas: visualiser
    - require:
      - user: visualiser
      - pkg: Visualiser Requirements

Get Virtual Env:
  cmd.run:
    - name: wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-{{ pillar['virtualenv']['version'] }}.tar.gz {{ pillar['python']['wget_flags'] }}
    - user: visualiser
    - group: visualiser
    - cwd: /tmp/

Extract Virtual Env:
  cmd.wait:
    - name: tar xvfz virtualenv-{{ pillar['virtualenv']['version'] }}.tar.gz
    - cwd: /tmp/
    - user: visualiser
    - group: visualiser
    - watch:
      - cmd: Get Virtual Env

Install Visualiser Virtual Env:
  cmd.wait:
    - name: python2.7 /tmp/virtualenv-{{ pillar['virtualenv']['version'] }}/virtualenv.py env
    - cwd: /home/visualiser/BCCVL_Visualiser/
    - user: visualiser
    - group: visualiser
    - watch:
      - cmd: Extract Virtual Env

Install numpy:
  pip.installed:
    - name: numpy
    - bin_env: /home/visualiser/BCCVL_Visualiser/env/bin/pip
    - user: visualiser
    - require:
      - cmd: Install Visualiser Virtual Env

Visualiser Buildout Config:
  file.managed:
    - name: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/buildout.cfg
    - source:
      - salt://bccvl/buildout_visualiser.cfg
    - user: visualiser
    - group: visualiser
    - mode: 640
    - template: jinja
    - defaults:
      site_hostname: {{ pillar['visualiser']['hostname'] }}
    - require:
      - git: Visualiser Clone

Visualiser Bootstrap Buildout:
  cmd.run:
    - cwd: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser
    - user: visualiser
    - group: visualiser
    - name: ../env/bin/python bootstrap.py
    - unless: test -x /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/bin/buildout
    - require:
      - git: Visualiser Clone
      - pkg: Visualiser Requirements
      - cmd: Install Visualiser Virtual Env
      - pip: Install numpy
      - file: Visualiser Buildout Config

Visualiser Buildout:
  cmd.run:
    - cwd: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser
    - user: visualiser
    - group: visualiser
    - name: ./bin/buildout
    - require:
      - cmd: Visualiser Bootstrap Buildout
      - git: Visualiser Clone

/etc/supervisord.d/visualiser.ini:
  file.symlink:
    - target: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/etc/supervisor.conf
    - require:
      - pkg: supervisor
    - watch:
      - cmd: Visualiser Buildout
    - watch_in:
      - service: supervisord

/home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/var/log:
  file.directory:
    - user: visualiser
    - group: visualiser
    - makedirs: True

# Only link up the apache conf if we are building JUST the visualiser
{% if grains['id'] == 'visualiser' %}

/etc/httpd/conf.d/bccvl_visualiser.conf:
  file.symlink:
    - target: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/etc/apache.conf
    - require:
      - pkg: httpd
    - watch:
      - cmd: Visualiser Buildout
    - watch_in:
      - service: httpd

{% else %}
# Else, ensure the symlink is missing

/etc/httpd/conf.d/bccvl_visualiser.conf:
  file.absent

{% endif %}
