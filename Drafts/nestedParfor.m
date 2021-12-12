function cap = nestedParfor(i)
    parfor  u = 1:1:NumberOfUsers
        interf_Power = 0;    
        for u_interf = (u-1):-1:1        
            interf_Power = interf_Power + powers(u_interf)*Pt*loss(u);
        end
        cap(i,u) = B*log2(1 + powers(u)*Pt*loss(u) / (N0*B + interf_Power));                     
    end
end
