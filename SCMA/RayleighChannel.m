function [ channel ] = RayleighChannel(NumberOfUsers)
    channel = zeros(1, NumberOfUsers);
    for i=1:1:NumberOfUsers
        %Rayleigh channel
        R = randn;
        I = randn;
        if (R<0) 
            R = (-1)*R;
        end
        if (I<0) 
            I = (-1)*I;
        end
        %channel = powerCoefficientRatio*sqrt(0.5)*(h1Real+1i*h1Image);
        channel(i) = R+1i*I;
    end
end

