running_time = [5.96 8.610 1.229 0.221];
algorithm_names = categorical({'OPA','Gradient','Normal','DL'});
algorithm_names = reordercats(algorithm_names,{'OPA','Gradient','Normal','DL'});
figure(1)
bar(algorithm_names, running_time);
%set(gca,'xticklabel', algorithm_names);
title('Running time of algorithms to obtain power allocation');
xlabel('Algorithm names')
ylabel('Time (ms)')