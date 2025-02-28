#!/bin/bash
sudo apt-get update -y
sudo apt-get install phyton3 phyton3-pip -y
git clone git@github.com:mashru020/python-mysql-db-proj-1.git

sleep 20

cd python-mysql-db-proj-1
sudo pip3 install -r requirements.txt
echo "Waiting for 30 seconds before running the app"
setsid python3 -u app.py &
sleep 30