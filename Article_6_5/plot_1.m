number_of_neurons = [3 4 5 6 7 8 9];
time_spent = [0.0154 0.0153 0.0157 0.016 0.0189 0.0188 0.0181];

figure(1)
p = plot(number_of_neurons, time_spent, 'LineWidth', 2 );
p(1).LineWidth = 3;

title('Time spent for running DL framework with different number of neurons');
xlabel('number of neurons')
ylabel('running time (ms)')
%legend('DL');