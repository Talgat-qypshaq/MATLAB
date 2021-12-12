function [signal] = generateQPSK(NumberOfUsers)
signal = zeros(1, NumberOfUsers);
for i=1:1:NumberOfUsers
RealPart = randn;
ImagPart = randn;
%fprintf('R = %s ', num2str(RealPart));
%fprintf('I = %s \n', num2str(ImagPart));
if(RealPart>0)
    RealPart = 1;    
else
    RealPart = -1;
end
if(ImagPart>0)
    ImagPart = 1;
else
    ImagPart = -1;
end
signal(i) = RealPart + ImagPart*1i;
end