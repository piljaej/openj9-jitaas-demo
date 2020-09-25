sudo rm -rf openj9_vm

sudo docker run -d --name openj9-jit openj9-jitserver-build
sudo docker cp openj9-jit:/root/openj9-openjdk-jdk8/openj9/runtime/vm ./openj9_vm
sudo docker commit openj9-jit openj9-vm-builder

sudo docker stop openj9-jit
sudo docker rm openj9-jit
