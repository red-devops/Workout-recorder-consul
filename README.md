# Workout-recorder - HashiCorp Consul

The content of this project is part of the post on blog https://red-devops.pl/<br>
The repository contains HashiCorp Terraform code, thanks to which we can automatically create an infrastruture for the workoutrecorder apps.
This is the next step in which we add the HashiCorp Consul cluster to our infrastructure.<br> 
Post provisioning of the Consul is done using Ansible playbook in the repository:
https://github.com/red-devops/Consul-server-ansible <br>

After executing the HashCorp Terraform code from the last step, folder <code>/Workout-recorder-consul/100-app-infra/180-instances</code>, download the "fabio_public_ip" output address and use in the Frontend App repository ( link: https://github.com/red-devops/workoutrecorder-frontend ) to release a new version of the application. Then deploy it and also Backend App ( link: https://github.com/red-devops/workoutrecorder-backend ) to the given environment.

## Workout-recorder - Fabio load balancer
Once all the applications are correctly registered in the HashCorp Consul cluster. The whole system will be ready and the Frontend App will be served on the Fabio public ip address on port 9999. On port 9998 it is possible to check Fabio's mapping which uses Consul service discovery to redirect traffic to healthy instances.<br>
Manual Fabio deploy: https://github.com/red-devops/workoutrecorder-fabio

## Workout-recorder - Self hosted runner
In the implementation we use a self hosted runner was built automatically using this repository: <br>
https://github.com/red-devops/Packer-guide

## Workout-recorder - Old Version
An older version of the application running on docker compose:<br>
https://github.com/red-devops/Workout-recorder <br>

