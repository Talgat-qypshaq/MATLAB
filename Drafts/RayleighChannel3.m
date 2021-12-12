function [ channel ] = RayleighChannel3(powerCoefficientRatio, R, I)
%Rayleigh channel
if (R<0) 
    R = (-1)*R;
end

if (I<0) 
    I = (-1)*I;
end

h1Real = R;
h1Image = I;

channel = powerCoefficientRatio*sqrt(0.5)*(h1Real+1i*h1Image);    
end

