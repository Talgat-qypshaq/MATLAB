n = 5;
flag = 4;
%a = 1;
x = 1;
bosmushe = 0;
coefficientBosmushe (1, n)= ones;
coefficient (1, n) = ones;
flag = n-1;
for g=1:1:n
    if (g==1)
        coefficient(g) = 1;
        coefficientBosmushe(g) = 0;
    end
    if (g==2)
        coefficient(g) = 1;
        coefficientBosmushe(g) = 1;
    end
    if (g>2)
        coefficient(g) = coefficient(g-1)*2;
        coefficientBosmushe(g) = coefficientBosmushe(g-1)*2;
    end
    % decrement flag
end
bosmusheSum = sum(coefficientBosmushe);
coefficientSum = sum(coefficient);
maximumFlag = (100- bosmusheSum)./coefficientSum;
leftPower = 100-bosmusheSum;
C = fix(leftPower/coefficientSum);
disp(C);
%disp(sum(coefficient));
%disp(sum(coefficientBosmushe));
disp(coefficient);
%disp(coefficientBosmushe);