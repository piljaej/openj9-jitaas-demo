#For first
#Download original optimizer source code
sudo rm -rf optimizer

sudo docker run -d --name openj9-jit openj9-jitserver-build
sudo docker cp openj9-jit:/root/openj9-openjdk-jdk8/omr/compiler/optimizer ./optimizer
sudo docker stop openj9-jit
sudo docker rm openj9-jit
