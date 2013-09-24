Install PostgreSQL Repository:
  pkg.installed:
    - sources:
      - pgdg-centos93: http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm

Install PostgreSQL Packages:
  pkg.installed:
    - pkgs:
      - postgresql93-devel
      - postgresql93-server
    - require:
      - pkg: Install PostgreSQL Repository

Init postgresql-9.3:
  cmd.wait:
    - name: service postgresql-9.3 initdb
    - watch:
      - pkg: Install PostgreSQL Packages
    - watch_in:
      - service: postgresql-9.3

postgresql-9.3:
  service:
    - running
    - enable: True

# Change postgresql to allow md5 authentication
/var/lib/pgsql/9.3/data/pg_hba.conf:
  file.managed:
    - source:
      - salt://bccvl/postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 600
    - require:
      - cmd: Init postgresql-9.3
    - watch_in:
      - service: postgresql-9.3

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
