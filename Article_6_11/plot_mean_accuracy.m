clc;

validation_accuracy = dlmread('mean_accuracy.txt',' ');

epochs = 1:5;

validation = zeros(1, length(epochs));

for a = 1:1:length(epochs)
    validation(1, :) = validation_accuracy(:,1);
end

a = plot(epochs*10, validation, 'LineWidth', 2 );

a(1).Marker = 'o';

legend('Accuracy');
xlabel('number of epochs'), ylabel('accuracy')