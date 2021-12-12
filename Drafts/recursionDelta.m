function [] = recursionDelta(n)
    beta_1 = 2;
    beta_2 = 3;
    recursionDelta = ones(1, 2);
    for k = 1:1:n
        if(k==1)
            recursionDelta(k) = 1.8333;
        else
            for i = 1:1:k
                a = (1/k+1);
                b = i*recursionTheta(beta_1, beta_2, i);
                c = recursionDelta(k+1-i);
                fprintf('i = %d; k = %d; delta = %.3f ', i, k, recursionDelta(k) )
                fprintf('a = %.3f; b = %.3f; c = %.3f;\n', a, b, c);                
                recursionDelta(k+1) = a*b*c;                
            end
            fprintf('delta = %.3f;', recursionDelta(k) );   
        end        
    end
    disp(recursionDelta(2));
end