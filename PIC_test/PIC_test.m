clc;
clear;
    modulation = 4;
    iterations = 5000;
tic
    parfor i=1:iterations
        if(modulation == 4)
            result(1,i) = modulation*i;
        elseif(modulation == 16)
            result(1,i) = 2*modulation*i;
        end
    end
time_1 = toc; 


tic
    for i=1:1:iterations
        if(modulation == 4)
            result(1,i) = modulation*i;
        elseif(modulation == 16)
            result(1,i) = 2*modulation*i;
        end
    end
time_2 = toc; 

fprintf('time Parallel =  %.9f;\n', time_1);
fprintf('time Serial   =  %.9f;', time_2);
fprintf('\n');