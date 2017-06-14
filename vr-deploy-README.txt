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
