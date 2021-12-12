%for 2 UEs ML Regression 266 rows 2 features
%% clear
clear ; close all; clc;
%% initialize
data = load('trainingData_1.txt');

X = data(:, 1:2);
y = data(:, 3);
m = length(y);

mean_distance_1 = mean(X(:,1));
mean_distance_2 = mean(X(:,2));
%mean_data_rate_1 = mean(X(:,3));
%mean_data_rate_2 = mean(X(:,4));

mean_distance_1 = 235;
mean_distance_2 = 25;
%mean_data_rate_1 = 220.95;
%mean_data_rate_2 = 214.73;

%fprintf('min UE1: %.2f; max UE1: %.2f;\n',minUE1,minUE2);
%fprintf('min UE2: %.2f; max UE2: %.2f;\n',maxUE1,maxUE2);
%fprintf('mean of UE 1: distance: %.2f m; data rate: %.2f; Mbits/s\n', mean_distance_1, mean_data_rate_1);
%fprintf('mean of UE 2: distance: %.2f m; data rate: %.2f; Mbits/s\n', mean_distance_2, mean_data_rate_2);

fprintf('mean of UE 1: distance: %.2f m;\n', mean_distance_1);
fprintf('mean of UE 2: distance: %.2f m;\n', mean_distance_2);

[X, mu, sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];
alpha = 0.1;
num_iters = 1000;

vectorOfPrediction = [mean_distance_1 mean_distance_2];
vectorOfPrediction = (vectorOfPrediction-mu)./sigma;
vectorOfPrediction = [ones(1, 1) vectorOfPrediction];
tic
% Init Theta and Run Gradient Descent 
theta_1 = zeros(size(X,2), 1);
[theta_1, J_history] = gradientDescentMulti(X, y, theta_1, alpha, num_iters);
predicted_PAC_Gradient = vectorOfPrediction*theta_1;
timeGradient = toc;
tic
theta_2 = normalEqn(X, y);
predicted_PAC_Normal = vectorOfPrediction*theta_2;
timeNormal = toc;
fprintf('gradient:\n');
fprintf('predicted PAC for UE 1 = %.2f; time = %.3f ms;\n', predicted_PAC_Gradient, timeGradient*1000);

fprintf('normal:\n');
fprintf('predicted PAC for UE 1 = %.2f; time = %.3f ms;\n', predicted_PAC_Normal, timeNormal*1000);
