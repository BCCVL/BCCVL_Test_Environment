
Data Mover Requirements:
    pkg.installed:
      - pkgs:
        - git
        - readline-devel
        - patch
        - zlib-devel
        - bzip2-devel
        - openssl-devel
        - ncurses-devel
        - tk-devel
        - python27-devel
        - wget
      - require:
        - pkgrepo: erpel

# Create data_mover user
data_mover:
  user.present:
    - fullname: Data Mover
    - shell: /bin/bash
    - createhome: true
    - gid_from_name: true
  postgres_user.present:
    - runas: postgres
    - password: pillar['data_mover']['postgres_password']
    - require:
      - cmd: Init postgresql-9.3
      - service: postgresql-9.3

/home/data_mover/tmp:
  file.directory:
    - user: data_mover
    - group: data_mover
    - makedirs: True

# Clone Data Mover repo
Data Mover Clone:
  git.latest:
    - name: https://github.com/BCCVL/bccvl_data_mover.git
    - rev: convert_to_buildout
    - target: /home/data_mover/bccvl_data_mover
    - runas: data_mover
    - require:
      - user: data_mover
      - pkg: Data Mover Requirements

Data Mover Get Virtual Env:
  cmd.run:
    - name: wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-{{ pillar['virtualenv']['version'] }}.tar.gz {{ pillar['python']['wget_flags'] }}
    - user: data_mover
    - group: data_mover
    - cwd: /home/data_mover/tmp/
    - require:
      - user: data_mover
      - pkg: Data Mover Requirements
      - file: /home/data_mover/tmp
    - unless: test -d /home/data_mover/bccvl_data_mover/data_mover/env

Data Mover Extract Virtual Env:
  cmd.wait:
    - name: tar xvfz virtualenv-{{ pillar['virtualenv']['version'] }}.tar.gz
    - cwd: /home/data_mover/tmp/
    - user: data_mover
    - group: data_mover
    - watch:
      - cmd: Data Mover Get Virtual Env

Install Data Mover Virtual Env:
  cmd.wait:
    - name: python2.7 /home/data_mover/tmp/virtualenv-{{ pillar['virtualenv']['version'] }}/virtualenv.py env
    - cwd: /home/data_mover/bccvl_data_mover/data_mover/
    - user: data_mover
    - group: data_mover
    - require:
      - git: Data Mover Clone
    - watch:
      - cmd: Data Mover Extract Virtual Env

Data Mover Bootstrap Buildout:
  cmd.run:
    - cwd: /home/data_mover/bccvl_data_mover/data_mover/
    - user: data_mover
    - group: data_mover
    - name: ./env/bin/python bootstrap.py
    - require:
      - cmd: Data Mover Extract Virtual Env
      - cmd: Source PostgreSQL into PATH
      - cmd: Install Data Mover Virtual Env
    - watch:
      - git: Data Mover Clone

Data Mover Buildout:
  cmd.run:
    - cwd: /home/data_mover/bccvl_data_mover/data_mover/
    - user: data_mover
    - group: data_mover
    - name: ./bin/buildout
    - require:
      - cmd: Data Mover Bootstrap Buildout
      - git: Data Mover Clone

include:
  - bccvl.tools
  - bccvl.users
  - bccvl.base
  - bccvl.postgresql

extend:
  Source PostgreSQL into PATH:
    cmd:
      - user: data_mover
      - group: data_mover
