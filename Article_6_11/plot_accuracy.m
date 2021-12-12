clc;

train_accuracy = dlmread('train_accuracy.txt',' ');
test_accuracy = dlmread('test_accuracy.txt',' ');

epochs = 1:50;
accuracy = zeros(2, length(epochs));

for a = 1:1:length(epochs)
    accuracy(1, :) = train_accuracy(:,2);
    accuracy(2, :) = test_accuracy(:,2);
end

a = plot(epochs, accuracy, 'LineWidth', 2 );
%ay = ancestor(a, 'axes');
%ax = gca;
%ax.YAxis.Exponent = 0;
legend('train accuracy', 'test accuracy');
xlabel('number of epochs'), ylabel('Accuracy (MAE)')