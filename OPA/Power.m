function [] = Power(numberOfUsers)
    if (numberOfUsers < 2) 
        error('error : try num > 1 ');
    end
    clc;
    next = init(numberOfUsers);
    if fit(next)
        flag = 1;
        prev = next;
        while flag == 1
            %disp(next);
            dlmwrite('power5_N.txt', next ,'delimiter',' ', '-append')
            next = increaseUser(prev);
            if (next == prev)
               flag = 0;
            end
            prev = next;            
        end
    else
        disp('user array is not monotonous, try lower n')
    end
end
%
function [a] = init(N)
    a = zeros(1,N);
    a(1) = .01;
    for i = 2:1:N-1
        a(i) = sum(a) + .01;
    end
    a(N) = 1. - sum(a); 
end 
%
function [next] = increaseUser(prev)    
    n    = length(prev);
    flag = 0;
    for i = n-1:-1:1
        next = change(prev, i);
        if (fit(next) == 1)
            flag = 1;
            break
        end
    end
    if (flag == 0) 
        next = prev;
    end
end
%
function[prev] = change(prev, m)
    prev(m) = prev(m) + .01;
    n = length(prev);
    for i = m+1:1:n
        prev(i) = 0;
    end
    for i = m+1:1:n-1
        prev(i) = sum(prev) + .01;
    end 
    prev(n) = 0;
    prev(n) = 1. - sum(prev);
end
%
function [result] = fit(array)
    result = 1;
    n = length(array);
    if(sum(array)>1.) % chnaged here 
        result = 0;
    else
        for i = 2:1:n
            if (array(i)<=array(i-1))
                result = 0;
            end
        end
    end
end