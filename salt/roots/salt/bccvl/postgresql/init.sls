Install PostgreSQL Packages:
  pkg.installed:
    - pkgs:
      - postgresql-devel
      - postgresql-server

Init postgresql:
  cmd.wait:
    - name: service postgresql initdb
    - user: root
    - watch:
      - pkg: Install PostgreSQL Packages
    - watch_in:
      - service: postgresql

postgresql:
  service:
    - running
    - enable: True

# Change postgresql to allow md5 authentication
/var/lib/pgsql/data/pg_hba.conf:
  file.managed:
    - source:
      - salt://bccvl/postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - cmd: Init postgresql
    - watch_in:
      - service: postgresql

/etc/profile.d/postgresql_path.sh:
  file.managed:
    - source:
      - salt://bccvl/postgresql/postgresql_path.sh
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: Install PostgreSQL Packages

Source PostgreSQL into PATH:
  cmd.run:
    - name: source /etc/profile.d/postgresql_path.sh
    - require:
      - file: /etc/profile.d/postgresql_path.sh
