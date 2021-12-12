%% clear
clear ; close all; clc;
%% initialize
data = load('data/trainingData.txt');
X = data(:, 1:4);
y = data(:, 5);
m = length(y);

mean_distance_1 = mean(X(:,1));
mean_distance_2 = mean(X(:,2));
mean_data_rate_1 = mean(X(:,3));
mean_data_rate_2 = mean(X(:,4));
%minUE1 = min(X(:,1));
%minUE2 = min(X(:,2));

%maxUE1 = max(X(:,1));
%maxUE2 = max(X(:,2));

%fprintf('min UE1: %.2f; max UE1: %.2f;\n',minUE1,minUE2);
%fprintf('min UE2: %.2f; max UE2: %.2f;\n',maxUE1,maxUE2);
fprintf('mean of UE 1: distance: %.2f; data rate: %.2f;\n',mean_distance_1,mean_data_rate_1);
fprintf('mean of UE 2: distance: %.2f; data rate: %.2f;\n',mean_distance_2,mean_data_rate_2);

[X, mu, sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(size(X,2), 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

vectorOfPrediction = [mean_distance_1 mean_distance_2 mean_data_rate_1 mean_data_rate_2];
vectorOfPrediction = (vectorOfPrediction-mu)./sigma;
vectorOfPrediction = [ones(1, 1) vectorOfPrediction];
predicted_PAC = vectorOfPrediction*theta;
fprintf('predicted power allocation coefficient for UE 1 = %.2f;\n',predicted_PAC);
