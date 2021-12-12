function [decodedSymbols] = SCMA(alpha, h, codeBook, y, cellSize, length)
    
    estimatedSignal = zeros(cellSize, length);
    estimatedMessage = zeros(cellSize, length);
    decodedSignals = zeros(1, cellSize);
    decodedSymbols = zeros(1,cellSize);
    for i=1:1:cellSize
        for j = 1:1:length
            estimatedSignal(i,j) = y(1, j)/( h(1,i)*alpha(1,i)*codeBook(i, j));
            %fprintf('estimated signal 1 %.4f + %.4fi \n', real(estimatedSignal(i,j)), imag(estimatedSignal(i,j)) );
            if(isinf(real(estimatedSignal(i,j))) == 0 && isinf(imag(estimatedSignal(i,j)))== 0 )
                %fprintf('estimated signal %.4f + %.4fi \n', real(estimatedSignal(i,j)), imag(estimatedSignal(i,j)) );
                decodedSignals(1,i) = decodeQPSK(real(estimatedSignal(i,j)), imag(estimatedSignal(i,j)));
                %fprintf('decoded signal 1 %d + %di \n', real(decodedSignals(1,i)), imag(decodedSignals(1,i)) );
            end            
        end
    end

    sumDecoded = sum(decodedSignals);
    sumChannel = sum(h);
    sumPower = (alpha);
    
    for j=1:1:cellSize
        estimatedMessage(1,j) = ( (y(1,1)/(sumChannel(1,1)*sumPower(1,1)) ) - sumDecoded(1,1)+decodedSignals(1,j));
        %fprintf('estimated message 2 %.4f + %.4fi \n', real(estimatedMessage(1,j)), imag(estimatedMessage(1,j)) );
        %decodeQPSK( real(estimatedMessage(1,j)), imag(estimatedMessage(1,j)) );
        decodedSymbols(1, j) = decodeQPSK( real(estimatedMessage(1,j)), imag(estimatedMessage(1,j)) );
        %fprintf('decoded signal 2 %d + %di \n', real(decodedSymbols(1,i)), imag(decodedSymbols(1,i)) );
    end

end