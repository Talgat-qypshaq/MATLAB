distancesMatrix = [];
for c = 1:1:2
    a = 500;
    b = 25;

    step = 25;
    d1 = a;
    for i = 1:1:( (d1/step)+1)
        if(i>1)
            d1 = (d1 - step);
        end
        d2 = b;
        for j = 1:1:( ((d1/step))*(2/3) )
            if(j>1)
                if( (d2/d1 <= 2/3) )        
                    d2 = (d2 + step);
                end
            end
            if(c == 1)
                fprintf('d1 = %d; d2 = %d;\n',d1, d2);
                newrow = [d1 d2];
                distancesMatrix = [distancesMatrix; newrow];
                writematrix(distancesMatrix,'data/distances_1.txt','Delimiter',' ');
            end
            if(c == 2)
                fprintf('d1 = %d; d2 = %d;\n', d2, d1);
                newrow = [d2 d1];
                distancesMatrix = [distancesMatrix; newrow];
                writematrix(distancesMatrix,'data/distances_1.txt','Delimiter',' ');
            end
        end    
    end
end