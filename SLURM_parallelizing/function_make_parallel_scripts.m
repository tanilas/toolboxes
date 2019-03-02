function jobind=function_make_parallel_scripts(scriptToRun,noruns,stind)

%delete logs/*
%delete jobs/*

mkdir jobs
mkdir logs


jobind=stind;
display('Making jobs ...')

for repsi=1:noruns
    jobind=jobind+1;
    
    
    %fid = fopen(['./jobs/run_movies_' mm_vec{mmi} '_tp' num2str(tpi) '.sh'],'w');
    fid = fopen(['./jobs/job_' num2str(jobind) '.sh'],'w');
    
    fprintf(fid,'#!/bin/bash\n\n');
    
    fprintf(fid,'#SBATCH -p batch\n');
    %fprintf(fid,'#SBATCH -t 1:59:59\n');
    fprintf(fid,'#SBATCH -t 0:59:59\n');
    fprintf(fid,['#SBATCH -o "' './logs/log_' num2str(jobind) '"\n']);
    %fprintf(fid,['#SBATCH -o "' './logs/log_' num2str(tpi) '"\n']);
    fprintf(fid,'#SBATCH --qos=normal\n\n');
    fprintf(fid,'#SBATCH --mem-per-cpu=3000\n\n');
    %fprintf(fid,'module load matlab\n');
    
    %fprintf(fid,['matlab -nojvm -r "cd ' pwd '/;rng(' num2str(randi(100000)) ');addpath(genpath(''/m/nbe/scratch/braindata/gostopa1/projects2/lrp-toolbox/''));runallR;exit;"']); % for 32mm
    
    %fprintf(fid,['python ' scriptToRun]); % If it is a python script
    
    
    fprintf(fid,['matlab -nojvm -r "cd ' pwd '/;rng(' num2str(randi(100000)) ');' scriptToRun ';exit;"']); % for 32mm
    
    fclose(fid);
    
    
    
end

display('Done making jobs!')

end