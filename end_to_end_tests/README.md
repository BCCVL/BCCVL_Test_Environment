Install Instructions
=========================

From this directory run:

	virtualenv .
	./bin/pip install distribute --upgrade
	./bin/pip install -r requirements.txt

##Setup Headless Testing (Ubuntu)##

	sudo apt-get install xvfb
	sudo apt-get install xserver-xephyr
	sudo apt-get install tightvncserver

Run Tests
===============

From this directory run:

	./bin/python -m nose
