# archlinux-steamlink
---
Running Arch Linux ARM on the Steam Link.  
Yes, *running* - no puny chroot.  

The Steam Link has ~256MiB of RAM (unlike what Wikipedia says),  
and a Marvell ARMv7 CPU (1 Core, 1 Thread) (`MV88DE3108`).  

## Requirements
- Ethernet connectivity to the Steam Link
- A USB Stick

## Working
- Full userspace replacement
- Handoff to systemd

## Todo
- Disable kernel watchdog timer
- Figure out a way to load a custom kernel
  - kexec fails
