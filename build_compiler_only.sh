EXTENSIONS_DIR=/root/openj9-openjdk-jdk8
JAVA_BASE=$EXTENSIONS_DIR/build/linux-x86_64-normal-server-release

# Go to top level directory
cd $EXTENSIONS_DIR/..

# Set up directory structure
ln -s $EXTENSIONS_DIR/openj9/runtime/compiler
ln -s $EXTENSIONS_DIR/omr

# Set up env vars
export TRHOME=$PWD
export J9SRC=$JAVA_BASE/vm
export PATH=$J9SRC:$PATH

# If using a clean openj9/omr repo, regenerate the tracegen files
pushd .
cd $TRHOME/compiler/env
tracegen -treatWarningAsError -generatecfiles -threshold 1 -file j9jit.tdf
echo ""
popd



# Compiler Makefile variables
export JIT_SRCBASE=$TRHOME
export JIT_OBJBASE=$TRHOME/objs
export JIT_DLL_DIR=$TRHOME
export J9VM_OPT_JITSERVER=1

#echo $PWD

make -C $TRHOME/compiler -f compiler.mk BUILD_CONFIG=prod -j 4 J9_VERSION=29

#echo $PWD

cp libj9jit29.so $JAVA_BASE/images/j2sdk-image/jre/lib/amd64/compressedrefs/

rm -rf $JIT_OBJBASE