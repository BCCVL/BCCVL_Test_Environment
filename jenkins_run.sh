#!/bin/sh

# Destroy the previously created vm (if any)
vagrant destroy nectar_bccvl_combined

echo "Sleeping for 30 seconds"
sleep 30

# Bring up the combined vm
vagrant up nectar_bccvl_combined --provider=openstack

echo "Sleeping for 30 seconds"
sleep 30

echo "Determining the IP address of the newly created VM"
IP=`vagrant ssh nectar_bccvl_combined -c "ifconfig eth0 | grep 'inet addr:' | tr -s ' ' | cut -d ' ' -f 3 | cut -d ':' -f 2" | grep -v WARNING`
echo "Determined IP address: $IP"

# Restart the combined vm (a workaround to the 4store dependency issue)
#echo "Restarting the combined VM"
#vagrant reload nectar_bccvl_combined --provider=openstack


# Run tests
