function symbol = QPSK_decode(R)

if(real(R)>0.0 && imag(R) > 0.0)
    symbol = [0 0];
elseif(real(R)>0.0 && imag(R) < 0.0)
    symbol = [1 0];

elseif(real(R)<0.0 && imag(R) > 0.0)
    symbol = [0 1];

elseif(real(R)<0.0 && imag(R) < 0.0)
    symbol = [1 1];

end

