function [] = PowerAllocation2( numberOfUsers )
    next = zeros(1, numberOfUsers);
    for i = 1:1:numberOfUsers
        next(i) = i;
    end
    next(numberOfUsers) = 0;
    next(numberOfUsers) = 100-sum(next);
    %disp(next);
    flag = 1;
    previous = next;   
    %disp(previous);
    while flag == 1;
        next = increaseUser(previous);
        if (next == previous)
           flag = 0;
        end
        previous = next;
    end
end

function next = increaseUser(previous)
    %disp(previous);
    n = size(previous, 2);
    flag = 0;
    for i=n-1:-1:1
        next = change(previous, i);
        if(fit(next)== 1)
            flag = 1;
            break
        end
    end
    if (flag==0) 
        next=previous;
    end
    %disp(next);
end

function[previous] = change(previous, m)
    disp(previous(m));
    disp(previous(m+1));
    previous(m) = previous(m)+1;
    n = size(previous, 2);
    for i=m+1:1:n
        previous(i) = previous(i-1)+1;       
    end
    previous(n) = 0;
    previous(n) = 100 - sum(previous);
end

function [result] = fit(array)
    result = 1;
    n = size(array, 2);
    if(sum(array)>100)
        result = 0;
    else
        for i=2:1:n
            if(array(i)<=array(i-1))
                result = 0;
            end                        
        end
    end
end