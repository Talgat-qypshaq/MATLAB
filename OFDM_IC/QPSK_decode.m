function [symbol] = QPSK_decode(R)

    if(real(R) >= 0.0 && imag(R) >= 0.0)
        symbol = [1 1];
    elseif(real(R) >= 0.0 && imag(R) < 0.0)
        symbol = [1 0];
    elseif(real(R) < 0.0 && imag(R) >= 0.0)
        symbol = [0 1];
    elseif(real(R) < 0.0 && imag(R) < 0.0)
        symbol = [0 0];
    %fprintf('input signal: real =  %.2f imag =  %.2f \n', real(R), imag(R));        
    %fprintf('decoded signal: real =  %d imag =  %d \n', real(symbol), imag(symbol)); 
    end
    %disp(real(R));      
    %disp(signal);
        
end

