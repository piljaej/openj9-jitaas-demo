sudo docker run -it \
-v $PWD/optimizer:/root/openj9-openjdk-jdk8/omr/compiler/optimizer \
-v $PWD/build_compiler_only.sh:/root/build_compiler_only.sh \
--name openj9-jit-comp openj9-jit-compiler /bin/bash "./build_compiler_only.sh"

rm -rf ./j2sdk-image

sdk_path_docker=/root/openj9-openjdk-jdk8/build/linux-x86_64-normal-server-release/images/j2sdk-image
sudo docker cp openj9-jit-comp:$sdk_path_docker ./j2sdk-image

rm -rf ./Laptop1/server_nojit1/j2sdk-image
rm -rf ./Laptop1/server_nojit2/j2sdk-image
rm -rf ./Laptop1/server_openj9/j2sdk-image
rm -rf ./Laptop2/jitserver/j2sdk-image

cp -r ./j2sdk-image ./Laptop1/server_nojit1/
cp -r ./j2sdk-image ./Laptop1/server_nojit2/
cp -r ./j2sdk-image ./Laptop1/server_openj9/
cp -r ./j2sdk-image ./Laptop2/jitserver/

sudo docker stop openj9-jit-comp
sudo docker rm openj9-jit-comp

#sudo docker rm openj9-jit
