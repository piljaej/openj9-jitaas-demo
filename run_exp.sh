./run_modification.sh
sudo cp -r ./mypack ./j2sdk-image/bin/
cd ./j2sdk-image/bin/
./javac ./mypack/Pattern.java
cp ./mypack/Pattern.class ./
mkdir -p ../../exp

#./java -Xnoaot '-Xjit:verbose={compileStart|compileEnd|inlining},vlog=../../exp/vlog,disableSuffixLogs,{*Pattern.main([Ljava/lang/String;)V*}(traceFull,log=../../exp/log_method_main)' Pattern 1000000
#./java Pattern 1000000
#./java Pattern 1000000
./java '-Xjit:verbose={compilePerformance},vlog=../../exp/vlog,disableSuffixLogs,{*loop_test(*}(traceFull,log=../../exp/log_method_main)' Pattern 58000000 58000000
