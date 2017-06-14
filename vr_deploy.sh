#!/bin/bash

# Header

clear

echo -e "***************************************************************\n"
echo -e "           This Script Is Written By Suhas G Savkoor           \n"
echo -e "                       gsuhas@vmware.com                       \n"
echo -e "***************************************************************\n"

# Check for root user

RunUser=root
currentUser=$(whoami)

if [ "$RunUser" != "$currentUser" ]
then
        printf "Run the Script as Root user. Exiting now\n"
else

# Downloading OVF tool from repository

        cd /root

        if ping -q -c 1 -W 1 8.8.8.8 &> /dev/null;
        then
        printf "Downloading OVF Tool\n"
        wget https://www.dropbox.com/s/wihvc41gzfl7ca8/VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle?dl=0 -O /root/VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle -q
                echo
        else
        printf "No network connection. Download OVF tool manually and install it on this appliance"
        exit 1
        fi

# Install OVF tool
        printf "Installing OVF Tool\n\n"
        echo -ne '\n' | sudo /bin/sh VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle --eulas-agreed

# Mounting vSphere Replication ISO
        printf "\n\nCreating Mount Point for ISO\n"
        mkdir /mnt/iso &> /dev/null
        mount /dev/cdrom /mnt/iso &> /dev/null

# Input parameters
        printf "\nGathering Environment Details\n\n"

        read -p "Enter the name of the datastore where this appliance should reside: " datastore_name
        echo #New Line
        read -p "Enter the inventory display name for the replication appliance: " display_name
        echo #New Line
        read -p "Enter the network port-group name where replication appliance must reside: " network_group
        echo #New Line
        read -p "Enter the root password for the replication appliance: " root_password
        echo #New Line
        read -p "Enter the NTP server IP address: " ntp_address
        echo #New Line
        read -p "Enter the replication server management IP address: " replication_address
        echo #New Line
        read -p "Enter the IP of the vCenter Server in which the appliance should be deployed: " vcenter_address
        echo #New Line
		read -p "Enter the IP of the ESXi host where this appliance should run on: "  esxi_address
		echo #New Line
        read -p "Enter the SSO username for the vCenter server this vR will be deployed on: " sso_user
        echo #New Line
        read -p "Enter the password for this SSO user: " sso_password
        echo #New Line


# Actual execution

        printf "\nPerforming Deployment\n\n"
        ovftool --acceptAllEulas -ds="$datastore_name" -n="$display_name" --net:"Management Network"="$network_group" --prop:"password"=$root_password --prop:"ntpserver"="$ntp_address" --prop:"vami.ip0.vSphere_Replication_Appliance"="$replication_address" --vService:installation=com.vmware.vim.vsm:extension_vservice /mnt/iso/bin/vSphere_Replication_OVF10.ovf vi://"$sso_user":$sso_password@$vcenter_address/?ip=$esxi_address
		
		printf "\n\nDeployment Complete\nExiting Script\n\n"
fi


