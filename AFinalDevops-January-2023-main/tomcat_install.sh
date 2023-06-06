#!/bin/bash
echo "-------------------------- Update Ubuntu --------------------------"
sudo apt update 
echo "-------------------------- Installing openjdk-11 --------------------------"
sudo apt install -y openjdk-11-jdk
echo "-------------------------- Installing Tomcat9 --------------------------"
sudo apt install -y tomcat9 tomcat9-admin
echo "------------------------------------------------------------------------"
