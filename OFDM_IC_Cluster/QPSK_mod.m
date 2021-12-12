function Modulated_signal = QPSK_mod(source1, source2)

if source1 > 0.5
    Modulated_signal = 1;
else
    Modulated_signal = -1;
end

if source2 > 0.5
    Modulated_signal = Modulated_signal+1i;
else
    Modulated_signal = Modulated_signal+(-1)*1i;
end