clear;
clc;
% signal to transmit
x1 = 1 + 1i;
x2 = 1 - 1i;

alpha1 = 0.25;
alpha2 = 0.75;

n1 = 0;
n2 = 0;

%Rayleigh channel
R = randn;
if (R<0) 
    R = (-1)*R;
end

I = randn;
if (I<0) 
    I = (-1)*I;
end

h1Real = R;
h1Image = I;

h1 = 3*sqrt(0.5)*(h1Real+1i*h1Image);
h2 =   sqrt(0.5)*(h1Real+1i*h1Image);

x = x1*alpha1 + x2*alpha2;
fprintf('x_1 = %s \n', num2str(x1));
fprintf('x_2 = %s \n', num2str(x2));
fprintf('x = %s \n', num2str(x));

%received signal by user 1
y1 = x*h1 + n1;
y1_1 = x1*alpha1*h1+x2*alpha2*h1+n1;

%received signal by user 2
y2 = x*h2 + n2;
y2_1 = x1*alpha1*h2+x2*alpha2*h2+n2;

%UE1 steps:
%STEP 1. decode the stronger signal
if(alpha2>alpha1)
    x2_d = y1_1/(h1*alpha2);
end

RealPart = real(x2_d);
ImagPart = imag(x2_d);
%STEP 2. decision
[RealPart, ImagPart] = DecodeRealAndImage(RealPart, ImagPart);
x2d = RealPart+ImagPart*1i;
fprintf('x2_decoded = %s \n', num2str(x2d));
%STEP 3. decode the weaker signal (implement SIC)
x1_d = (y1_1 - x2d*alpha2*h1)/(alpha1*h1);
RealPart = real(x1_d);
ImagPart = imag(x1_d);
[RealPart, ImagPart] = DecodeRealAndImage(RealPart, ImagPart);
x1d = RealPart+ImagPart*1i;
fprintf('x1_decoded = %s \n', num2str(x1d));
%UE2 steps:
%STEP 1. decode the stronger signal
if(alpha2>alpha1)
    x2_d = y1_1/h2*alpha2;
end

RealPart = real(x2_d);
ImagPart = imag(x2_d);
%STEP 2. decision
[RealPart, ImagPart] = DecodeRealAndImage(RealPart, ImagPart);
x2d = RealPart+ImagPart*1i;
fprintf('x2_decoded = %s \n', num2str(x2d));