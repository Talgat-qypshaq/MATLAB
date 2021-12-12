function [] = PowerOptimization4(numberOfUsers)
    clc;
    next = zeros(1, numberOfUsers);
    for i = 1:1:numberOfUsers
        next(i) = i;
    end
    next(numberOfUsers) = 0;
    next(numberOfUsers) = 1000-sum(next);
    flag = 1;
    previous = next;
    %save to file start
    formatSpec = '';
    oneDigitWithSpace = '%.3f ';
    oneDigitWithoutSpace = '%.3f';
    
    fileName = strcat('data5/power', num2str(numberOfUsers));
    fileName = strcat(fileName,'.txt');
    fileID = fopen(fileName,'w');
    for column=1:1:numberOfUsers
        if(column~=numberOfUsers)
            formatSpec = [formatSpec, oneDigitWithSpace];
        else
            formatSpec = [formatSpec, oneDigitWithoutSpace];
        end
    end    
    formatSpec = [formatSpec, '\r\n'];
    %save to file end
    while flag == 1;
        %disp(next);
        percentValue = next/1000;
        fprintf(fileID, formatSpec, percentValue);
        next = increaseUser(previous);
        if (next == previous)
           flag = 0;
        end
        previous = next;
    end
    fclose(fileID);
end

function next = increaseUser(previous)    
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
end

function[previous] = change(previous, m)
    previous(m) = previous(m)+1;
    n = size(previous, 2);
    for i=m+1:1:n
        previous(i) = previous(i-1)+1;       
    end
    previous(n) = 0;
    previous(n) = 1000 - sum(previous);
end

function [result] = fit(array)
    result = 1;
    n = size(array, 2);
    if(sum(array)>1000)
        result = 0;
    else
        for i=2:1:n
            if(array(i)<=array(i-1))
            result = 0;
            end                        
        end
    end
end