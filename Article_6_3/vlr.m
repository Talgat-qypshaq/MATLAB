%% Initialization
clear ; close all; clc
%% call prediction
num_labels = 3;
data = load('data/trainingData_2.txt');
%training data
X = data(:, 1:2);
y = data(:, 3);
meanUE1 = mean(X(:,1));
meanUE2 = mean(X(:,2));
minUE1 = min(X(:,1));
minUE2 = min(X(:,2));
maxUE1 = max(X(:,1));
maxUE2 = max(X(:,2));
testData = [meanUE1 meanUE2];
fprintf('min UE1: %.2f; max UE1: %.2f;\n',minUE1,minUE2);
fprintf('min UE2: %.2f; max UE2: %.2f;\n',maxUE1,maxUE2);
fprintf('mean UE2: %.2f; mean UE2: %.2f;\n',meanUE1,meanUE2);
%train
lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);
%predict
pred = predictOneVsAll(all_theta, testData);
fprintf('predicted: %.2f',pred);