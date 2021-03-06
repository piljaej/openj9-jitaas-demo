# Copyright (c) 2018, 2018 IBM Corp. and others
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
#

# Pull docker containers that are needed

sudo docker pull telegraf			# used to collect memory/CPU metrics from docker containers
sudo docker pull open-liberty:webProfile7	# OpenLiberty server
sudo docker pull adoptopenjdk/openjdk8		# used to run OpenJDK8 with Hotspot JVM

# download all openjdk, openj9, and omr repos
pushd ../openj9

./build_openj9.sh
cd ../hotspot && ./get_hotspot.sh

popd

# Build each of the OpenLiberty server containers
cd server_openj9	&& ./build_server_openj9_newCache.sh	&& cd ..
cd server_nojit1	&& ./build_server_nojit1_newCache.sh	&& cd ..

sudo docker network create my-net
