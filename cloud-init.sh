#!/bin/sh
# jependencies: libguestfs-tools 
cloudinitISO="${cloudinitISO:=focal-server-cloudimg-amd64.img}"
templateName="${templateName:=ubuntu-cloud}"
templateID="${templateID:=8000}"
storage="${storage:=main}"

# Download Ubuntu (replace with the url of the one you chose from above)
curl -LO "$cloudinitISO" https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

# Customize cloud-image
virt-customize -a "$cloudinitISO" --install qemu-guest-agent
virt-customize -a "$cloudinitISO" --install nfs-common

# Create a new virtual machine
qm create "$templateID" --memory 4096 --core 2 --name "$templateName" --net0 virtio,bridge=vmbr0

# Import the downloaded Ubuntu disk to local-lvm storage
qm importdisk "$templateID" "$cloudinitISO" "$storage"

# Attach the new disk to the vm as a scsi drive on the scsi controller
qm set "$templateID" --scsihw virtio-scsi-pci --scsi0 "$storage":vm-"$templateID"-disk-0

# Add cloud init drive
qm set "$templateID" --ide2 "$storage":cloudinit

# Make the cloud init drive bootable and restrict BIOS to boot from disk only
qm set "$templateID" --boot c --bootdisk scsi0

# Resize disk
qm resize "$templateID" scsi0 +48G

# Add serial console
qm set "$templateID" --serial0 socket --vga serial0

# Enable guest agent by default
qm set "$templateID" --agent enabled=1

# Create template
qm template "$templateID"

# Cleanup
echo "Finished Template, cleaning..."
rm "$cloudinitISO"

# # Clone vm 3 times
# qm clone "$templateID" 300 --name node1 --full --storage "$storage" --start
# qm clone "$templateID" 301 --name node2 --full --storage "$storage" --start
# qm clone "$templateID" 302 --name node3 --full --storage "$storage" --start
