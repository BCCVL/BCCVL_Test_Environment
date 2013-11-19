visualiser:
    hostname: {% if grains['ipv4'][0] == '127.0.0.1' %}{{ grains['ipv4'][1] }}{% else %}{{ grains['ipv4'][0] }}{% endif %}
    # hostname: 118.138.241.217 # daniel B's nectar VM
