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

## Technical explanation
Two scripts - `init-trampoline` and `handoff` - work together to replace
the running userspace (including PID 1) with a different one.  
- `handoff`:
  - creates a copy of `/sbin/init` in a tmpfs
  - masks `/sbin/init`, overlaying `init-trampoline`
  - calls the previously-copied `init` binary as `telinit u` to reexec init
    - this causes PID 1 to exec `init-trampoline`
- `init-trampoline`:
  - `pivot_root`s to the new userspace rootfs
  - `chroot`s to the new userspace rootfs to work around an issue causing the caller to still have their cwd in the old rootfs
  - creates necessary system mountpoints
  - execs `lib/systemd/systemd` to hand off PID 1 to systemd

## Todo
- Disable kernel watchdog timer
- Figure out a way to load a custom kernel
  - kexec fails
