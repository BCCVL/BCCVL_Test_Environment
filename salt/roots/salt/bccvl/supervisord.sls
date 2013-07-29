

supervisor:
  pkg.installed:
    - require:
      - pkg: Install Epel Repository

supervisord:
  service.enabled:
    - require:
      - pkg: supervisor

