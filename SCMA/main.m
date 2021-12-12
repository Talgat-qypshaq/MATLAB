%%% implement sparse code multiple access on non-orthogonal multiple access
function [] = main()
    clc;
    %set cell size and the length of code
    cellSize = 4;    
    length = 6;
    %set power allocation coefficients    
    alpha = [0.05 0.05 0.45 0.45];
    %scma codebook
    spreadFactor = 2;
    codeBook = [1 1 0 0 0 0; 0 0 0 0 1 1; 0 0 1 1 0 0; 1 0 0 0 0 1];
    codedMessage = zeros(cellSize, length);
    %PrintCodeBook(CB,cellSize,spreadFactor);
    %set Rayleighchannel array
    h = RayleighChannel(cellSize);
    %transmitted signal
    x = generateQPSK(cellSize);
    for i=1:1:cellSize
        fprintf('initial signal: %d + %di \n', real(x(1,i)), imag(x(1,i)) );
    end
    %PrintSignal(x, cellSize);
    %received signal by each UE
    y = zeros(cellSize, length);
    %set noise (temporary noise is zero)
    n = zeros(cellSize, length);        
    %transmitted signal with power coefficient
    signalWithPowerCoefficient = zeros(1, cellSize);    
    for i=1:1:cellSize
        sqrtNvar = sqrt(0.5/(10^(i/10)));
        n(1, i) = randn*sqrtNvar+1i*randn*sqrtNvar;
        %set transmitted signal with power coefficient
        signalWithPowerCoefficient(1, i) = x(1, i)*sqrt(alpha(1, i));
        %need to multiply by code book
        for j = 1:1:length
            codedMessage(i, j) = signalWithPowerCoefficient(1, i)*codeBook(i,j);
        end
    end
    %disp(codedMessage);
    %set received signal of ith user
    for i=1:1:cellSize   
        for j = 1:1:length
            y(i,j) = codedMessage(i, j)*h(1, i)+n(1, i);
        end
    end
    y_sum = sum(y);    
    %disp(y_sum);
    %call SCMA function
    
    tic
        decodedSymbols = SCMA(alpha, h, codeBook, y_sum, cellSize, length);    
    elapsedTime = toc;
    fprintf('\n');
    for i=1:1:cellSize
        fprintf('decoded signal: %d + %di \n', real(decodedSymbols(1,i)), imag(decodedSymbols(1,i)) );
    end
    error = 0;
    for i=1:1:cellSize       
        if(real(decodedSymbols(1,i)) ~= real(x(1,i)))
            error = error+1;
        end
        if(imag(decodedSymbols(1,i)) ~= imag(x(1,i)))
            error = error+1;
        end
    end
    fprintf('There are %d errors out of %d.\n', error, cellSize*2 );
    fprintf('overall SCMA time: %.9f seconds \n', elapsedTime); 
end