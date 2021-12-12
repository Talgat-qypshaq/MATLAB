clc;
Size = 4;
A = [9 16 25 36];
B = [1 2 3 4 5];
D = 2;
C = zeros(4, 5);
for i=1:Size
    C(i,:) = A(i)*B;
end
%summC = sum(C);
disp(C);
%disp(summC);