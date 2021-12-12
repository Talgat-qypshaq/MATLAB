function [signalQAM64] = generateQAM64(numberOfGroups, numberOfUsers)
signalQAM64 = zeros(numberOfGroups, numberOfUsers);

for i=1:1:numberOfGroups
    for j=1:1:numberOfUsers
        RealPart = randn;
        ImagPart = randn;

        %fprintf('R = %s ', num2str(RealPart));
        %fprintf('I = %s \n', num2str(ImagPart));

        if RealPart < 0.03125
            RealPart = 7;
        elseif RealPart >= 0.03125 && RealPart < 0.0625
            RealPart = 5;
        elseif RealPart >= 0.0625 && RealPart < 0.75
            RealPart = 3;
        elseif RealPart >= 0.75 && RealPart < 0.09375
            RealPart = 1;
        elseif RealPart >= 0.09375 && RealPart < 0.125
            RealPart = -1;
        elseif RealPart >= 0.125 && RealPart < 0.15625
            RealPart = -3;
        elseif RealPart >= 0.15625 && RealPart < 0.1875
            RealPart = -5;
        elseif RealPart >= 0.1875
            RealPart = -7;
        end

        if ImagPart < 0.03125
            ImagPart = 7;
        elseif ImagPart >= 0.03125 && ImagPart < 0.0625
            ImagPart = 5;
        elseif ImagPart >= 0.0625 && ImagPart < 0.75
            ImagPart = 3;
        elseif ImagPart >= 0.75 && ImagPart < 0.09375
            ImagPart = 1;
        elseif ImagPart >= 0.09375 && ImagPart < 0.125
            ImagPart = -1;
        elseif ImagPart >= 0.125 && ImagPart < 0.15625
            ImagPart = -3;
        elseif ImagPart >= 0.15625 && ImagPart < 0.1875
            ImagPart = -5;
        elseif ImagPart >= 0.1875
            ImagPart = -7;
        end
        
        signalQAM64(i,j) = RealPart+ImagPart*i;
    end
end