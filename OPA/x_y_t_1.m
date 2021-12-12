clear; clc;
location = load('data/x_y.txt');
time = load('data/t.txt');
m = length(location);
%disp(location);
n = length(time);
x = zeros(m,n);
y = zeros(m,n);
for a=1:1:m    
    for b=1:1:n*2
        if(mod(b,2)~=0)
            x(a,fix(b/2)+1) = location(a, b);
        else
            y(a,fix(b/2)) = location(a, b);                           
        end             
    end
end

mu = mean(x);
sigma = std(x);
rows = size(x, 1);
mu_matrix = ones(rows, 1) * mu;
sigma_matrix = ones(rows, 1) * sigma;
x_norm = (x-mu_matrix)./sigma_matrix;

X = [ones(m, 1) x];

alpha = 0.01;
num_iters = 400;
theta = zeros(n, 1);
%[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

for iter = 1:num_iters
    % ====================== YOUR CODE HERE ======================
    % Instructions: Perform a single gradient step on the parameter vector
    %               theta. 
    %
    % Hint: While debugging, it can be useful to print out the values
    %       of the cost function (computeCostMulti) and gradient here.
    %
    h = X*theta;
    error_vector = h-y;
    gradient = (alpha/m)*(X')*error_vector;
    theta = theta - gradient;
    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCostMulti(X, y, theta);

end



% for a=1:1:m
%     fprintf('%d. ',a);
%     for b=1:1:n
%         fprintf('%.1f,%.1f; ',x(a,b),y(a,b));  
%     end
%     fprintf('\n');
% end

%plot(x, time, 'rx', 'MarkerSize', 10, 'LineStyle', 'none' );
%xlabel('x coordinate');
%ylabel('time');

%plot(y, time, 'rx', 'MarkerSize', 10, 'LineStyle', 'none' );
%xlabel('y coordinate');
%ylabel('time');