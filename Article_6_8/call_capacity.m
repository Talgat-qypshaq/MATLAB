clc; clear;

distances = dlmread('Article_6_8/data/mean_distances.txt',' ');

UEs = [2 3 4 5 6 7 8 9 10 11 12];
%UEs = [3];
sum_capacity_es = zeros(1, length(UEs));
sum_capacity_gradient = zeros(1, length(UEs));
sum_capacity_norm = zeros(1, length(UEs));
sum_capacity_dl = zeros(1, length(UEs));

%for a = 1:1:length(UEs)
%    file_es_coefficients = strcat('Article_6_8/data/ES_coefficients_', num2str(UEs(a)));
%    file_es_coefficients = strcat(file_es_coefficients,'.txt');
%    coefficients_ES = dlmread(file_es_coefficients);
%    sum_capacity_es(a) = sumCapacity(distances, coefficients_ES, UEs(a), 'ES');
%end

%for b = 1:1:length(UEs)
%    file_ml_gradient_coefficients = strcat('Article_6_8/data/gradient_coefficients_', num2str(UEs(b)));
%    file_ml_gradient_coefficients = strcat(file_ml_gradient_coefficients,'.txt');
%    coefficients_gradient = dlmread(file_ml_gradient_coefficients);
%    sum_capacity_gradient(b) = sumCapacity(distances, coefficients_gradient, UEs(b), 'GRADIENT');    
%end

for c = 1:1:length(UEs)
    file_ml_normal_coefficients = strcat('Article_6_8/data/normal_coefficients_', num2str(UEs(c)));
    file_ml_normal_coefficients = strcat(file_ml_normal_coefficients,'.txt');
    coefficients_normal = dlmread(file_ml_normal_coefficients);
    sum_capacity_norm(c) = sumCapacity(distances, coefficients_normal, UEs(c), 'Normal');
end

%for d = 1:1:length(UEs)
%    file_dl_coefficients = strcat('Article_6_8/data/DL_coefficients_', num2str(UEs(d)));
%    file_dl_coefficients = strcat(file_dl_coefficients,'.txt');
%    coefficients_dl = dlmread(file_dl_coefficients);
%    sum_capacity_dl(d) = sumCapacity(distances, coefficients_dl, UEs(d), 'DL');
%end

%file_sum_capacity_ES = 'Article_6_8/results/capacity_ES.txt';
%file_sum_capacity_gradient = 'Article_6_8/results/capacity_gradient.txt';
file_sum_capacity_normal = 'Article_6_8/results/capacity_normal.txt';
%file_sum_capacity_DL = 'Article_6_8/results/capacity_dl.txt';

%writematrix(sum_capacity_es, file_sum_capacity_ES, 'Delimiter',' ');
%writematrix(sum_capacity_gradient, file_sum_capacity_gradient, 'Delimiter',' ');
writematrix(sum_capacity_norm, file_sum_capacity_normal, 'Delimiter',' ');
%writematrix(sum_capacity_dl, file_sum_capacity_DL, 'Delimiter',' ');