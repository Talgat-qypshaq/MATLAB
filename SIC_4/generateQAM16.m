function [signalQAM16] = generateQAM16(numberOfUsers)
signalQAM16 = zeros(1, numberOfUsers);

for i=1:1:numberOfUsers
    RealPart = randn;
    ImagPart = randn;
    
    %fprintf('R = %s ', num2str(RealPart));
    %fprintf('I = %s \n', num2str(ImagPart));
    
    if RealPart < 0.25
        RealPart = 1;
    elseif RealPart >= 0.25 && RealPart < 0.5
        RealPart = -1;
    elseif RealPart >= 0.5 && RealPart < 0.75
        RealPart = 3;
    elseif RealPart >= 0.75  
        RealPart = -3;
    end

    if ImagPart < 0.25
        ImagPart = 1;
    elseif ImagPart >= 0.25 && ImagPart < 0.5
        ImagPart = -1;
    elseif ImagPart >= 0.5 && ImagPart < 0.75
        ImagPart = 3;
    elseif ImagPart >= 0.75 
        ImagPart = -3;
    end

    signalQAM16(i) = RealPart+ImagPart*i;
end




