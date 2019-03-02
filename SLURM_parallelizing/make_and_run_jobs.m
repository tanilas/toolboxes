ind=1000;
nojobs=220;

%function_make_parallel_scripts('test_classify_tps',nojobs,ind)

delete jobs/*
delete logs/*

ind=function_make_script_array(['perm=0;mms=''32mm'';test_classify_tps2'],nojobs,ind)
ind=function_make_script_array(['perm=1;mms=''32mm'';test_classify_tps2'],nojobs,ind)

%ind=function_make_parallel_scripts('perm=0;test_classify_tps',nojobs,ind)
%ind=function_make_parallel_scripts('perm=1;test_classify_tps',nojobs,ind)
make_slurm_run_jobs

system('./slurm_run_jobs_auto.sh ')