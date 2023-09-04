# ansible-desktop-setup
Setting up Ubuntu Gnome desktop and apps with Ansible

```
# For Gnome desktop
ansible-playbook local.yml --extra-vars="desktop=true"

# For Gnome laptop
ansible-playbook local.yml --extra-vars="laptop=true"

# For Chromebook
ansible-playbook local.yml --extra-vars="chromebook=true"

# For server (no desktop)
ansible-playbook local.yml
```

## Encrypted ~/Private Directory
After install run `ecryptfs-setup-private`.