#!/bin/bash -f
#
# Copyright (c) 2017, 2018 IBM Corp. and others
#
# This program and the accompanying materials are made available under
# the terms of the Eclipse Public License 2.0 which accompanies this
# distribution and is available at https://www.eclipse.org/legal/epl-2.0/
# or the Apache License, Version 2.0 which accompanies this distribution and
# is available at https://www.apache.org/licenses/LICENSE-2.0.
#
# This Source Code may also be made available under the following
# Secondary Licenses when the conditions for such availability set
# forth in the Eclipse Public License, v. 2.0 are satisfied: GNU
# General Public License, version 2 with the GNU Classpath
# Exception [1] and GNU General Public License, version 2 with the
# OpenJDK Assembly Exception [2].
#
# [1] https://www.gnu.org/software/classpath/license.html
# [2] http://openjdk.java.net/legal/assembly-exception.html
#
# SPDX-License-Identifier: EPL-2.0 OR Apache-2.0

# Usage:
#  $ build_openj9.sh [--fetch-repos] [--noclean]
#    --fetch-repos    downloads all repositories from scratch, WILL ERASE EXISTING openj9-openjdk-jdk8 directory
#    --noclean        do not run "make clean" before building OpenJDK8 with OpenJ9
#

rm -rf openj9
git clone https://github.com/piljaej/openj9.git

cd ./openj9
#git checkout jitaas -> not work
git checkout master

cd ./buildenv/docker
bash mkdocker.sh --build --dist=ubuntu --tag=openj9 --version=18

cd ./jdk8/x86_64/ubuntu18/jitserver/build
docker build -f Dockerfile -t=openj9-jitserver-build .

cd ../../../../../../../../

echo $PWD

sudo docker run -d --name openj9-jit openj9-jitserver-build
sudo docker cp openj9-jit:/root/j2sdk-image ./j2sdk-image
sudo docker stop openj9-jit
sudo docker rm openj9-jit
