1. Download the script
2. Place it in the /root directory of the Linux machine
3. Provide execute permissions for the script
chmod a+x vr_deploy.sh
4. Mount the VR ISO to the Linux VM using vSphere / Web Client
5. Execute the script 
./vr_deploy.sh

The script tests for network connectivity.
if successful, then it will download the 4.2 version of ovftool and install it and then prompt the user for details

if unsucessful, then the script will exit and the ovftool has to be installed manually on the linux, or use windows method to deploy.


Changelog:
If you do not have OVF tool on linux and you also do not have internet access from Linux, then download OVF tool 4.2 manually from VMware website (.bundle file for Linux)
Put this file in /root directory of the Linux machine. 
Install the OVF tool using:
sudo /bin/sh VMware-ovftool-4.2.0-4586971-lin.x86_64.bundle

Once installed, then run the script. The script then checks if OVF tool is present. If present, it will continue further. 
This is updated as some of the Linux boxes will not have ovf tool.
