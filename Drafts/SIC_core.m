function [ result] = SIC_core( n )
if(n == 1)
    result = 1;
else
    result = n*SIC_core(n-1);
end
end

