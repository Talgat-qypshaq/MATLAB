function [ capacity ] = testFormula()
A = 2;
B = 3;
C = 4;
D = 5;
E = 6;
F = 7;
%capacity = A*log2(1 + B*C*D /(E*A + F));
%fprintf('%s \n', num2str(capacity, '%.9f'));
%1. 
capacity = (E*A + F);
fprintf('%s \n', num2str(capacity, '%.9f'));
end

