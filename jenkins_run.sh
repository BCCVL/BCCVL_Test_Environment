#!/bin/sh

# Destroy the previously created vm (if any)
vagrant destroy nectar_bccvl_combined

echo "Sleeping for 30 seconds"
sleep 30

# Bring up the combined vm
vagrant up nectar_bccvl_combined --provider=openstack
VAGRANT_RESULT=$?
echo "VAGRANT_RESULT = $VAGRANT_RESULT"

if [ $VAGRANT_RESULT -ne 0 ]; then
	echo "Vagrant failure"
	exit -1
fi

echo "Sleeping for 30 seconds"
sleep 30

echo "Determining the IP address of the newly created VM"
IP=`vagrant ssh nectar_bccvl_combined -c "ifconfig eth0 | grep 'inet addr:' | tr -s ' ' | cut -d ' ' -f 3 | cut -d ':' -f 2" | grep -v WARNING`
echo "Determined IP address: $IP"

echo "Sleeping for 5 minutes"
sleep 5m

# Seed instance
vagrant ssh nectar_bccvl_combined -c 'sudo su plone -c "cd ~/bccvl_buildout; ./bin/instance-debug run src/org.bccvl.testsetup/src/org/bccvl/testsetup/main.py"'

echo "Sleeping for 1 minute"
sleep 1m

# Run tests
# Setup the Selenium tests
cd end_to_end_tests
virtualenv .
./bin/pip install distribute --upgrade
./bin/pip install -r requirements.txt

# Set the environment attribute URL for test
export URL="http://$IP"

# Run the test and output the results in XML
./bin/nosetests --with-xunit
TEST_RESULT=$?

exit $TEST_RESULT