function [ arrayOfChannels ] = RayleighChannel(arrayOfPowerCoefficients)
%Rayleigh channel
R = randn;
if (R<0)
    R = (-1)*R;
end

I = randn;
if (I<0)
    I = (-1)*I;
end

numberOfUEs = size(arrayOfPowerCoefficients, 2);

h1Real = R;
h1Image = I;
arrayOfChannels = zeros(1,numberOfUEs);

for i=1:1:numberOfUEs    
    arrayOfChannels(i) = arrayOfPowerCoefficients(i)*10*sqrt(0.5)*(h1Real+1i*h1Image);    
end

end

