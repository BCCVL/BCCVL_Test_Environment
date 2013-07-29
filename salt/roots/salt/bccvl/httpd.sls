
httpd:
  pkg.installed:
    - pkgs:
      - httpd
      - mod_ssl
  service:
    - running
    - enable: True
    - require:
      - pkg: httpd

iptables 80:
  module.run:
    - name: iptables.insert
    - table: filter
    - chain: INPUT
    - position: 3
    - rule: -p tcp --dport 80 -j ACCEPT

iptables 443:
  module.run:
    - name: iptables.insert
    - table: filter
    - chain: INPUT
    - position: 3
    - rule: -p tcp --dport 443 -j ACCEPT

save iptables:
  module.run:
    - name: iptables.save
    - filename: /etc/sysconfig/iptables
    - require:
      - module: iptables 80
      - module: iptables 443

