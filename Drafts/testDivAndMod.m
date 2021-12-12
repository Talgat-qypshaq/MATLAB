numberOfUsers = 13;
a = 13;
b = 13;
c = mod(a,b);
%disp(c);
set = 1;
cell = set*numberOfUsers;

alpha = dlmread('data/OPA.txt', ' ', [numberOfUsers-5 0 numberOfUsers-5 numberOfUsers-1]);
%disp(alpha);
for i=1:1:cell
    order = mod(i, numberOfUsers);      
    if(order == 0 )
        order = 13;
    end
    %disp(order);  
    PC = alpha(order);
    disp(PC);        
end