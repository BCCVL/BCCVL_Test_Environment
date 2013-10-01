TEST_OUTPUT_DIR=~/bccvl_test_env_outputs
SLEEP_TIME_AFTER_UP=600

# Make sure our test outputs dir exists
mkdir -p "$TEST_OUTPUT_DIR"
# Remove the old test directory
rm -rf /tmp/test_env

pushd /tmp
    git clone https://github.com/BCCVL/BCCVL_Test_Environment.git test_env
    pushd test_env
        # start the test environment VMs
        vagrant up

        # give the VMs some time to get their business in order
        sleep "$SLEEP_TIME_AFTER_UP"

        # TODO - Add the code to seed the VM

        # step into the end-to-end test dir
        pushd end_to_end_tests
            virtualenv .
            ./bin/pip install setuptools --upgrade
            ./bin/pip install -r requirements.txt

            ./bin/python -m nose &> "$TEST_OUTPUT_DIR/`date +%d_%m_%Y-%H_%M_%S`"
        popd

        # kill the vms
        # vagrant destroy

    popd
popd
