#!/bin/bash

# --- Configuration Variables ---
VM_NAME="Kali Linux"
RAM="4G"
CPU="2"
IMAGE_FILE="kali-linux-2025.3-qemu-amd64.qcow2"

# --- Check if Image Exists ---
if [ ! -f "$IMAGE_FILE" ]; then
    echo "Error: Image file '$IMAGE_FILE' not found in the current directory."
    exit 1
fi

echo "Starting $VM_NAME with $RAM RAM and $CPU Cores..."

# --- The Launch Command ---
qemu-system-x86_64 \
  -name "$VM_NAME" \
  -m $RAM \
  -smp $CPU \
  -enable-kvm \
  -drive file="$IMAGE_FILE",if=virtio,format=qcow2 \
  -net nic,model=virtio -net user \
  -vga virtio \
  -display default
