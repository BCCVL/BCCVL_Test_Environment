varnish:
  pkg.installed:
    - require:
      - pkg: Install Varnish Repository
  service:
    - running
    - enable: True
    - require:
      - pkg: varnish
