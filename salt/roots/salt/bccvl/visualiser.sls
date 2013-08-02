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

Visualiser Bootstrap Buildout:
  cmd.run:
    - cwd: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser
    - user: visualiser
    - group: visualiser
    - name: python2.7 bootstrap.py
    - unless: test -x /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/bin/buildout
    - require:
      - git: Visualiser Clone
      - pkg: Visualiser Requirements

Visualiser Buildout:
  cmd.wait:
    - cwd: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser
    - user: visualiser
    - group: visualiser
    - name: /home/visualiser/BCCVL_Visualiser/BCCVL_Visualiser/bin/buildout
    - require:
      - cmd: Visualiser Bootstrap Buildout
    - watch:
      - git: Visualiser Clone
