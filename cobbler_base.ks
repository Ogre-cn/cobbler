# kickstart template for cobbler.
# snippet dir:/var/lib/cobbler/snippets
# applicable to version CentOS7

#platform=x86, AMD64, or Intel EM64T
# System authorization information
auth  --useshadow  --enablemd5
# System bootloader configuration
bootloader --location=mbr
# Partition clearing information
#clearpart --all --initlabel
# Use text mode install
text
# Firewall configuration
firewall --disabled
# Run the Setup Agent on first boot
firstboot --disable
# System keyboard
keyboard us
# System language
lang en_US
# Use network installation
url --url=$tree
# If any cobbler repo definitions were referenced in the kickstart profile, include them here.
$yum_repo_stanza
# Network information
$SNIPPET('cobbler_network_config')
# Reboot after installation
halt

#Root password
rootpw --iscPKc.LWGl$Vd3wCmzyUC3wYTdvpjICv1CmzyUC3wYTdvpjLWGl$Vd3
# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
# System timezone
timezone Asia/Shanghai
# Install OS instead of upgrade
install
# Clear the Master Boot Record
zerombr
# Allow anaconda to partition the system as needed
%pre
$SNIPPET('cobbler_partition')
%end
%include /tmp/partition.ks

#%packages
%packages
$SNIPPET('cobbler_pre_packages')
%end

%post
#### repo setup ###
$SNIPPET('cobbler_post_repo_config')
### Sync Time ###
$SNIPPET('cobbler_post_sync_time')
### Start final steps ###
$SNIPPET('cobbler_ssh_key')
### other steps ###
$SNIPPET('cobbler_other_step')
%end
