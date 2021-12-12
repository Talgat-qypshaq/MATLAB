%% Initialization
clear ; close all; clc
%% call prediction
data = load('data/trainingData_2.txt');

Theta1 = data(:, 1:2);
meanUE1 = mean(Theta1(:,1));
meanUE2 = mean(Theta1(:,2));

minUE1 = min(Theta1(:,1));
minUE2 = min(Theta1(:,2));
maxUE1 = max(Theta1(:,1));
maxUE2 = max(Theta1(:,2));
X = [meanUE1 meanUE2];
fprintf('min UE1: %.2f; max UE1: %.2f;\n',minUE1,minUE2);
fprintf('min UE2: %.2f; max UE2: %.2f;\n',maxUE1,maxUE2);
fprintf('mean UE2: %.2f; mean UE2: %.2f;\n',meanUE1,meanUE2);
Theta2 = data(:, 3);
pred = predict_1(Theta1, Theta2, X);
fprintf('\nNeural Network Prediction: %.2f \n', pred);
%fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));