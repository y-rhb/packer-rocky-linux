# Extrait du builder. Les paramètres vSphere et le Kickstart complet sont fournis par le projet.
source "vsphere-iso" "rocky9" {
  iso_paths = [var.iso_path]

  # --- Kickstart via OEMDRV ---
  # Packer cree un mini ISO avec le kickstart et le monte comme CD supplementaire.
  # Le label OEMDRV declenche la detection automatique par Anaconda.
  cd_files = ["./http/ks.cfg"]
  cd_label = "OEMDRV"

  # --- Boot command (EFI / GRUB2) ---
  # Approche GRUB edit : on edite l'entree existante pour ajouter inst.text
  # Le kickstart est detecte automatiquement via le label OEMDRV du CD.
  # Methode confirmee par le repo de reference VMware (packer-examples-for-vsphere).
  boot_wait = "5s"
  boot_command = [
    "<up>",
    "e",
    "<down><down><end>",
    " inst.text",
    "<leftCtrlOn>x<leftCtrlOff>"
  ]

  convert_to_template = true
  remove_cdrom        = true
}
