# Description

Ansible playbooks for deploying a Kubernetes cluster with a master node and if needed worker nodes.

# Pre-requisites

- The default user that will be used is `k8sadmin` so this user must exist on your servers (with sudo permissions).

- This project assumes that you have 3 Debian servers set up and configured with access via ssh keys and configured in your `~/.ssh/config` file. 

- Because the installation of Kubernetes requires the ability to run commands as root, you will need to be able to sudo on the servers without a password. This can be done by running the following command on each of the servers:

```
echo "<username> ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/<username>
```

You can do all the above just by running:

```
ansible-playbook -i hosts ~/kube-cluster/initial.yml
```

# Metallb configuration

- The ansible playbooks deploy metallb as the load balancer for the cluster. This requires that you have a range of IP defined in a config map. Create a file in the repository named `metallb-config.yaml` with the following contents (replacing the IP addresses):

```
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
    - 192.168.0.150-192.168.0.170
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2advertisement
  namespace: metallb-system
spec:
  ipAddressPools:
   - default
```


# Ansible setup

Your local machine will need to have Ansible installed. This can be done with the following command:

```
brew install ansible
```


# Host configuration
Assume you have 3 linux servers we will choose 1 as master node and the others as worker nodes: 

```
Host master
    HostName <master-ip>
    User debian

Host worker-1
    HostName <worker-1-ip>
    User debian
    
Host worker-2
    HostName <worker-2-ip>
    User debian
```

You will need to create a `hosts` file in the root of the project with the following contents:

```
[masters]
master ansible_host=master_ip ansible_user=root

[workers]
worker1 ansible_host=worker_1_ip ansible_user=root
worker2 ansible_host=worker_2_ip ansible_user=root

[all:vars]
ansible_python_interpreter=/usr/bin/python3
```

You can then test that Ansible can connect to the servers with the following command:

```
ansible -i hosts all -m ping
```

# Running the playbooks

The playbooks can be run with the following command:

```
ansible-playbook -i hosts install.yaml
```

Once the playbook has completed you should have a fully functional Kubernetes cluster!

# Credits

 * https://github.com/tjtharrison/kubernetes-deploy