function [RealPart, ImagPart] = decodeQPSK(RealPart, ImagPart)

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
    
end