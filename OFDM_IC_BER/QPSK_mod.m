function [modulatedSignal] = QPSK_mod(R)
    modulatedSignal = 0+0*1j;    
    
    if(real(R)>0.5 && imag(R) > 0.5)
        modulatedSignal = 1+1j;
    elseif(real(R)>0.5 && imag(R) < 0.5)
        modulatedSignal = 1-1j;
    elseif(real(R)<0.5 && imag(R) > 0.5)
        modulatedSignal = -1+1j;
    elseif(real(R)<0.5 && imag(R) < 0.5)
        modulatedSignal = -1-1j;
    end        
end