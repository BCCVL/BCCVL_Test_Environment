{# TODO: could add my own grain to detect deployment env and decide for ext interface or try to discover real hostname #}
{% if grains['productname'] == 'VirtualBox' %}
{% set hostname = grains['ip_interfaces']['eth1'][0] %}
{% elif grains['os'] == 'CentOs' %}
{% set hostname = grains['ip_interfaces']['eth0'][0] %}
{% else %}
{% set hostname = grains['ipv4'][1] if grains['ipv4'][0] == '127.0.0.1' else grains['ip4v'][0] %}
{% endif %}

visualiser:
    # set external if correctly for environment
    # replace servername with real seprvername for final deployment
    hostname: {{ hostname }}
    # hostname: 118.138.241.217 # daniel B's nectar VM
    host: 127.0.0.1
    port: 10600
