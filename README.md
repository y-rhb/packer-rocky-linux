# Image Rocky Linux 9 pour vSphere

Dans le projet d’équipe SLLYM, les machines virtuelles devaient partir du même système avant d’être configurées par Terraform et Ansible. Packer prépare une image Rocky Linux 9 sur vSphere. Kickstart décrit l’installation et sa configuration de départ.

- [Démarrage et fabrication de l’image](extraits/vsphere-iso.pkr.hcl) — Packer monte un second média portant le label \`OEMDRV\`. Anaconda y lit le Kickstart, ce qui évite de faire récupérer le fichier par la VM sur un serveur HTTP. Le builder convertit ensuite la VM en modèle. [Builder vSphere ISO](https://developer.hashicorp.com/packer/integrations/vmware/vsphere/latest/components/builder/vsphere-iso)
- [Stockage et sécurité](extraits/stockage-et-securite.ks) — l’installation active SELinux en mode enforcing et le pare-feu. Elle sépare les journaux et les fichiers temporaires en volumes logiques, avec des restrictions de montage adaptées à chaque usage.
- [Audit des changements sensibles](extraits/surveillance-fichiers.rules) — auditd surveille les écritures et changements d’attributs sur les fichiers d’identité et de configuration de sudo et SSH.

Le dépôt présente des extraits du projet d’équipe. Une construction complète demande les paramètres propres à vSphere, l’ISO Rocky Linux et le Kickstart complet. Les exemples documentent les mécanismes retenus pour l’installation et le durcissement.
