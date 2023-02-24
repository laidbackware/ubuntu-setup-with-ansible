alias k='kubectl'
alias ka='kubectl apply -f'
alias kc='kubectl create'
alias kd='kubectl describe'
alias kg='kubectl get'
alias kgp='kubectl get pod'

alias gb='git branch'
alias gc='git checkout'
alias gs="git status"
alias gp="git push"

alias tree="tree -a -I '.git'"
alias ssh-fix='eval `ssh-agent` ; ssh-add ~/.ssh/git_key'

alias kns=kubens
alias kx=kubectx

alias harold='ssh matt@192.168.0.5'

alias pssh="parallel-ssh  -h hosts -i"

alias obe='eval "$(om bosh-env)"'

alias ll='ls -la'

alias tkgs-nsxt='ansible-playbook /home/matt/workspace/projects/vmware-lab-builder/deploy.yml --extra-vars "@./var-examples/tanzu/vsphere-nsxt/opinionated-1host.yml"'
alias tkgs-avi='ansible-playbook /home/matt/workspace/projects/vmware-lab-builder/deploy.yml --extra-vars "@./var-examples/tanzu/vsphere-vds-alb/opinionated-1host.yml"'
alias tkgm='ansible-playbook /home/matt/workspace/projects/vmware-lab-builder/deploy.yml --extra-vars "@./var-examples/tanzu/multi-cloud/opinionated-1host.yml"'