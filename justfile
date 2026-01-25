infisical-init:
  @infisical init

[working-directory: './tofu']
tofu-plan:
  @infisical run --env prod --path /tofu -- tofu plan


[working-directory: './tofu']
tofu-apply:
  @infisical run --env prod --path /tofu -- tofu apply

[working-directory: './tofu']
tofu-destroy:
  @infisical run --env prod --path /tofu -- tofu destroy


[working-directory: './ansible']
install-k3s:
  @ansible-galaxy install -r requirements.yml
  @ansible-playbook -i inventories/k3s.yml k3s.orchestration.site

[working-directory: './ansible']
post-k3s-setup:
  @ansible-galaxy install -r requirements.yml
  @infisical run --env prod --path /k3s -- ansible-playbook -i inventories/k3s.yml playbooks/setup-k3s-post-install.yml
