
Plone Requirements:
    pkg.installed:
      - pkgs:
        - git
        - subversion
        - mercurial
        - zlib-devel
        - libjpeg-turbo-devel
        - freetype-devel
        - libtiff-devel
        - python27-devel
      - require:
        - pkgrepo: erpel

Compute Requirements:
  pkg.installed:
    - pkgs:
      - R-devel
      - gcc
      - make
      - gdal-devel
      - proj-devel
      - proj-epsg
      - proj-nad
    - require:
      - pkg: Install Elgis Repository

plone:
  user.present:
    - fullname: Plone
    - shell: /bin/bash
    - createhome: true
    - gid_from_name: true

BCCVL Buildout Clone:
  git.latest:
    - name: https://github.com/BCCVL/bccvl_buildout.git
    - target: /home/plone/bccvl_buildout
    - runas: plone
    - require:
      - user: plone
      - pkg: Plone Requirements

BCCVL Buildout Config:
  file.managed:
    - name: /home/plone/bccvl_buildout/buildout.cfg
    - source:
      - salt://bccvl/buildout.cfg
    - user: plone
    - group: plone
    - mode: 640
    - template: jinja
    - defaults:
      admin_user: {{ pillar['plone']['admin'] }}
      admin_password: {{ pillar['plone']['password'] }}
      site_hostname: {{ pillar['plone']['hostname'] }}
    - require:
      - git: BCCVL Buildout Clone

BCCVL Bootstrap Buildout:
  cmd.run:
    - cwd: /home/plone/bccvl_buildout
    - user: plone
    - group: plone
    - name: python2.7 bootstrap.py
    - unless: test -x /home/plone/bccvl_buildout/bin/buildout
    - require:
      - file: BCCVL Buildout Config
      - pkg: Plone Requirements
      - pkg: Compute Requirements

BCCVL Buildout:
  cmd.wait:
    - cwd: /home/plone/bccvl_buildout
    - user: plone
    - group: plone
    - name: /home/plone/bccvl_buildout/bin/buildout
    - require:
      - cmd: BCCVL Bootstrap Buildout
      - service: 4store
    - watch:
      - git: BCCVL Buildout Clone

/etc/httpd/conf.d/bccvl.conf:
  file.symlink:
    - target: /home/plone/bccvl_buildout/etc/apache.conf
    - require:
      - pkg: httpd
      - cmd: BCCVL Buildout
    - watch:
      - cmd: BCCVL Buildout
    - watch_in:
      - service: httpd

/mnt/work:
  file.directory:
    - user: plone
    - group: plone
    - dir_mode: 750
    - recurse:
      - user
    - require:
      - user: plone

/etc/supervisord.d/bccvl.ini:
  file.symlink:
    - target: /home/plone/bccvl_buildout/parts/supervisor/supervisord.conf
    - require:
      - pkg: supervisor
    - watch_in:
      - service: supervisord

