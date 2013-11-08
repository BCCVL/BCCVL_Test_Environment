#!/bin/sh

# Destroy the previously created vm (if any)
vagrant destroy nectar_bccvl_combined

echo "Sleeping for 30 seconds"
sleep 30

# Bring up the combined vm
vagrant up nectar_bccvl_combined --provider=openstack

echo "Sleeping for 30 seconds"
sleep 30

# Restart the combined vm (a workaround to the 4store dependency issue)
#echo "Restarting the combined VM"
#vagrant reload nectar_bccvl_combined --provider=openstack


# Run tests
