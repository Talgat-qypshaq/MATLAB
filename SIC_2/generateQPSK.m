function [signalQPSK] = generateQPSK(numberOfGroups, numberOfUsers)
    signalQPSK = zeros(numberOfGroups, numberOfUsers);
    for i=1:1:numberOfGroups
        for j=1:1:numberOfUsers
            RealPart = randn;
            ImagPart = randn;

            %fprintf('R = %s ', num2str(RealPart));            
            %fprintf('I = %s \n', num2str(ImagPart));
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
            signalQPSK(i, j) = RealPart + ImagPart*1i;
            %rr = real(signalQPSK(i, j));            
            %ii = imag(signalQPSK(i, j));
            %fprintf('Real = %s ', num2str(rr));
            %fprintf('Imag = %s \n', num2str(ii));
        end
    end       
end