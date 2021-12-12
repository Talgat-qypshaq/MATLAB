function [RealPart, ImagPart] = decodeQAM(RealPart , ImagPart)
    
    if RealPart >= 0  && RealPart < 2
        RealPart = 1;
    elseif RealPart >= 2 
        RealPart = 3;
        
    elseif RealPart < 0  && RealPart > -2
        RealPart = -1;
    elseif RealPart <= -2
        RealPart = -3;
    end

    if ImagPart >= 0  && ImagPart < 2
        ImagPart = 1;
    elseif ImagPart >= 2
        ImagPart = 3;
        
    elseif ImagPart < 0  && ImagPart > -2
        ImagPart = -1;
    elseif ImagPart <= -2
        ImagPart = -3;
    end
    
end