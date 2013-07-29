
4store:
  service:
    - running
    - enable: True
    - require:
      - pkg: Erpel Packages
      - file: /etc/4store.conf
      - file: /etc/sysconfig/4store
      - cmd: create bccvl 4store

create bccvl 4store:
  cmd.run:
    - name: 4s-backend-setup --segments 2 bccvl
    - user: fourstore
    - group: fourstore
    - unless: test -d /var/lib/4store/bccvl
    - require:
      - pkg: Erpel Packages

/etc/4store.conf:
  file.append:
    - text: |
        [bccvl]
        port = 6801
        soft-lmit = 0
    - require:
      - pkg: Erpel Packages

/etc/sysconfig/4store:
  file.managed:
    - source: salt://bccvl/4store.sysconfig
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: Erpel Packages

