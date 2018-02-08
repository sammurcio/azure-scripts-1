#
# Script to be run on VMs post ASR failover.  
# Use Post-Failover tasks to add custom script extension to VMs
# This script must be available publically
#

ipconfig /flushdns
ipconfig /registerdns
ipconfig /displaydns