clc;

train_loss = dlmread('train_loss.txt',' ');
test_loss = dlmread('test_loss.txt',' ');

epochs = 1:50;
loss = zeros(2, length(epochs));

for a = 1:1:length(epochs)    
    loss(1, :) = train_loss(:,2);
    loss(2, :) = test_loss(:,2);
end

a = plot(epochs, loss, 'LineWidth', 2 );
ay = ancestor(a, 'axes');
ax = gca;
ax.YAxis.Exponent = 0;
legend('train loss', 'test loss');
xlabel('number of epochs'), ylabel('Loss (MSE)')

%a(1).Marker = 'x';
%a(1).Marker = 'o';