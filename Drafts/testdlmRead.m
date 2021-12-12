numberOfUsers = 10;
alpha = dlmread('data/OPA.txt', ' ', [numberOfUsers-5 0 numberOfUsers-5 numberOfUsers-1]);
disp(alpha);