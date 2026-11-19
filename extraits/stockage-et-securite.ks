# Extrait Kickstart pour le disque système d’une VM dédiée.
selinux --enforcing
firewall --enabled --ssh

# /boot/efi — nécessaire au démarrage EFI
part /boot/efi --fstype=efi --size=600

# /boot — noyaux et initramfs
part /boot --fstype=xfs --size=1024 --fsoptions="nodev,nosuid"

# LVM pour le reste — flexibilite de redimensionnement
part pv.01 --fstype=lvmpv --size=1 --grow
volgroup vg_root pv.01

# / — racine systeme
logvol / --vgname=vg_root --name=lv_root --fstype=xfs --size=15360

# /home — donnees utilisateurs (CIS 1.1.7)
logvol /home --vgname=vg_root --name=lv_home --fstype=xfs --size=2048 --fsoptions="nodev,nosuid"

# /tmp — fichiers temporaires (CIS 1.1.2)
logvol /tmp --vgname=vg_root --name=lv_tmp --fstype=xfs --size=2048 --fsoptions="nodev,nosuid,noexec"

# /var — donnees variables (CIS 1.1.3)
logvol /var --vgname=vg_root --name=lv_var --fstype=xfs --size=10240 --fsoptions="nodev,nosuid"

# /var/tmp — temporaires variables (CIS 1.1.4)
logvol /var/tmp --vgname=vg_root --name=lv_var_tmp --fstype=xfs --size=2048 --fsoptions="nodev,nosuid,noexec"

# /var/log — logs systeme (CIS 1.1.5)
logvol /var/log --vgname=vg_root --name=lv_var_log --fstype=xfs --size=5120 --fsoptions="nodev,nosuid,noexec"

# /var/log/audit — logs audit (CIS 1.1.6)
logvol /var/log/audit --vgname=vg_root --name=lv_var_log_audit --fstype=xfs --size=2048 --fsoptions="nodev,nosuid,noexec"
