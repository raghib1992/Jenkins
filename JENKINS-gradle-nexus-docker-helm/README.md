# CICD
## Ref https://www.youtube.com/watch?v=adG0vq5boL8
## Tools used in our CICD pipeline
```
Jenkins (docker, kubectl, helm, datree.io)
github
sonar (using docker)
nexus registry
kubernetes
helm
```
ref 
To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.47.126:6443 --token 9cqram.g4fng12boo47a1vi \
        --discovery-token-ca-cert-hash sha256:213c89f39f076bb519f7ff1c0ce642354598f38a1c5060a6923ef4a5a18e4419