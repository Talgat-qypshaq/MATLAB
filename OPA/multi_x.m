clear; clc;
data = load('data/multi_x_y.txt');
m = length(data);
n = size(data,2)-1;

X = data(:, 1:3);
x_coord = data(:, 4);
y_coord = data(:, 5);

mu = mean(X);
sigma = std(X);
rows = size(X, 1);
mu_matrix = ones(rows, 1) * mu;
sigma_matrix = ones(rows, 1) * sigma;
x_norm = (X-mu_matrix)./sigma_matrix;
x_norm = [ones(m, 1) x_norm];

num_iters = 400;

alpha_x = 0.1;
alpha_y = 0.002;

alpha_1 = 0.05;
alpha_2 = 0.000009;
alpha_3 = 0.000009;

theta_x = zeros(n, 1);
theta_y = zeros(n, 1);

theta_1 = zeros(n, 1);
theta_2 = zeros(n, 1);
theta_3 = zeros(n, 1);

J_x = zeros(num_iters, 1);
J_y = zeros(num_iters, 1);

J_1 = zeros(num_iters, 1);
J_2 = zeros(num_iters, 1);
J_3 = zeros(num_iters, 1);

for iter = 1:num_iters
    h_x = x_norm*theta_x;
    h_y = x_norm*theta_y;
    
    h_1 = x_norm*theta_1;
    h_2 = x_norm*theta_2;
    h_3 = x_norm*theta_3;
    
    error_vector_x = h_x-x_coord;
    error_vector_y = h_y-y_coord;
    
    error_vector_1 = h_1-y_coord;
    error_vector_2 = h_2-y_coord;
    error_vector_3 = h_3-y_coord;
    
    gradient_x = (alpha_x/m)*(x_norm')*error_vector_x;
    gradient_y = (alpha_y/m)*(x_norm')*error_vector_y;
    
    gradient_1 = (alpha_1/m)*(x_norm')*error_vector_1;
    gradient_2 = (alpha_2/m)*(x_norm')*error_vector_2;
    gradient_3 = (alpha_3/m)*(x_norm')*error_vector_3;
    
    theta_x = theta_x - gradient_x;
    theta_y = theta_y - gradient_y;
    
    theta_1 = theta_1 - gradient_1;
    theta_2 = theta_2 - gradient_2;
    theta_3 = theta_3 - gradient_3;
    
    J_x(iter) = (1/(2*m))*sum(power(h_x(:,1)-x_coord(:,1),2));
    J_y(iter) = (1/(2*m))*sum(power(h_y(:,1)-x_coord(:,1),2));
    
    J_1(iter) = (1/(2*m))*sum(power(h_1(:,1)-x_coord(:,1),2));
    J_2(iter) = (1/(2*m))*sum(power(h_2(:,1)-x_coord(:,1),2));
    J_3(iter) = (1/(2*m))*sum(power(h_3(:,1)-x_coord(:,1),2));    
end

%fprintf('J = %.5f\n',J);
%Plot the convergence graph
figure;
%plot(1:numel(J_x), J_x, '-b', 'LineWidth', 2);
% plot(1:50, J_x(1:50), '-b', 'LineWidth', 2);
% xlabel('Number of iterations');
% ylabel('Cost J_x');
%hold on;
plot(1:50, J_y(1:50), '-r', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J_y');

%plot(1:numel(J_1), J_1, 'b');
%hold on;
%plot(1:numel(J_2), J_2, 'r');
%plot(1:numel(J_3), J_3, 'k');

% Display gradient descent's result
%fprintf('Theta computed from gradient descent: \n');
%fprintf(' %f \n', theta);
%fprintf('\n');

vectorOfPrediction = [29 4 3];
vectorOfPrediction = (vectorOfPrediction-mu)./sigma;
vectorOfPrediction = [ones(1, 1) vectorOfPrediction];
predicted_x = vectorOfPrediction*theta_x;
predicted_y = vectorOfPrediction*theta_y;

fprintf('approximate coordinates: (%.2f:%.2f);\n',predicted_x,predicted_y);