function [y] = cellxor(x)
    th = [0.5 0.5];
    theta = 2; %sum(x>=th)
    if sum(x>=th)>theta
        y=sum(x>=th)>theta;
        fprintf('condition 1');
    else
        y=sum(x>=th);
        fprintf('condition 2\n');
    end
    fprintf('y = %d', y);
    y(y>1) = 0;
end