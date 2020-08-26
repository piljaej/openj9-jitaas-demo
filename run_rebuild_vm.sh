sudo docker run -it \
-v $PWD/omr_compiler:/root/openj9-openjdk-jdk8/omr/compiler \
-v $PWD/openj9_compiler:/root/openj9-openjdk-jdk8/openj9/runtime/compiler \
-v $PWD/openj9_vm:/root/openj9-openjdk-jdk8/openj9/runtime/vm \
-v $PWD/build_vm.sh:/root/build_vm.sh \
--name openj9-vm openj9-vm-builder /bin/bash "./build_vm.sh"

rm -rf ./j2sdk-image
rm -rf ../../j2sdk-image

sdk_path_docker=/root/openj9-openjdk-jdk8/build/linux-x86_64-normal-server-release/images/j2sdk-image
sudo docker cp openj9-vm:$sdk_path_docker ./j2sdk-image
sudo docker cp openj9-vm:$sdk_path_docker ../../j2sdk-image
sudo docker commit openj9-vm openj9-vm-builder

rm -rf ./Laptop1/server_nojit1/j2sdk-image
rm -rf ./Laptop1/server_nojit2/j2sdk-image
rm -rf ./Laptop1/server_openj9/j2sdk-image
rm -rf ./Laptop2/jitserver/j2sdk-image

cp -r ./j2sdk-image ./Laptop1/server_nojit1/
cp -r ./j2sdk-image ./Laptop1/server_nojit2/
cp -r ./j2sdk-image ./Laptop1/server_openj9/openj9-jit-comp
cp -r ./j2sdk-image ./Laptop2/jitserver/

sudo docker stop openj9-vm
sudo docker rm openj9-vm