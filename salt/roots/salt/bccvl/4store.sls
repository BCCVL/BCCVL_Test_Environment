

4store:
  service:
    - running
    - enable: True
    - require:
      - pkg: Erpel Packages
    - watch:
      - file: /etc/4store.conf
      - file: /etc/sysconfig/4store

create bccvl 4store:
  cmd.run:
    - unless: 4s-admin list-stores | grep bccvl
    - name: 4s-admin create-store --segments 4 bccvl
    - require:
      - service: 4store

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

