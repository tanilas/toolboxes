function jobind=function_make_script_array(scriptToRun,noruns,stind)


%delete logs/*
%delete jobs/*

mkdir jobs
mkdir logs
%addpath(genpath('/triton/becs/scratch/braindata/gostopa1/MATLAB_scripts/nnctps/'))

jobind=stind;
display('Making jobs ...')

jobind=jobind+1;
fid = fopen(['./jobs/job_' num2str(jobind) '.sh'],'w');

fprintf(fid,'#!/bin/bash\n\n');

fprintf(fid,'#SBATCH -p batch\n');
%fprintf(fid,'#SBATCH -t 25:59:59\n');
fprintf(fid,'#SBATCH -t 1:59:59\n');
fprintf(fid,['#SBATCH --array=1-' num2str(noruns) '\n\n']);
fprintf(fid,['#SBATCH -o ' './logs/log_' num2str(jobind) '_%%a\n']);
fprintf(fid,'#SBATCH --qos=normal\n\n');
fprintf(fid,'#SBATCH --mem-per-cpu=50000\n\n');

%fprintf(fid,'module load matlab\n');
fprintf(fid,'sleep .$[( $RANDOM %% 10 ) ]s\n\n'); % Sleep for a random amount of time, so that the rng will give different seed
fprintf(fid,['matlab -nojvm -r "cd ' pwd '/;rng(''shuffle'');' scriptToRun ';exit;"']); % for 32mm

%fprintf(fid,['python ' scriptToRun]); % If it is a python script



fclose(fid);





display('Done making jobs!')

end
