# ansible-desktop-setup
Setting up Ubuntu Gnome desktop and apps with Ansible

```
# For Gnome desktop
ansible-playbook local.yml --extra-vars="@vars.yml"

# For server (no desktop)
ansible-playbook local.yml --extra-vars="@vars-server.yml"
```

## Encrypted ~/Private Directory
After install run `ecryptfs-setup-private`.