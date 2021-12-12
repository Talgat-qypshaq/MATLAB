function [decodedSignal] = QPSK_decode(R)    
    decodedSignal = 0+0*1j;
    
    if(real(R)>0.0 && imag(R) > 0.0)
        decodedSignal = 1+1j;
    elseif(real(R)>0.0 && imag(R) < 0.0)
        decodedSignal = 1-1j;
    elseif(real(R)<0.0 && imag(R) > 0.0)
        decodedSignal = -1+1j;
    elseif(real(R)<0.0 && imag(R) < 0.0)
        decodedSignal = -1-1j;
    end
end