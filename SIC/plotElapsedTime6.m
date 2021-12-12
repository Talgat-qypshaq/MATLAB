function [ ] = plotElapsedTime6( numberOfUEs )
    clc;
    UEs = zeros(1, numberOfUEs);
    time = zeros(numberOfUEs, 1);
    load('timeCase1.mat');
    load('timeCase2.mat');
    for UE = 1:1:numberOfUEs       
       UEs(1, numberOfUEs) = numberOfUEs;
       time(UE, 1) = timeCase1(UE, 1)+timeCase2(UE, 1);
    end        
    hold on
    p = plot(UEs, time, 'LineWidth', 2, 'markers', 12 );
    xlim([1 numberOfUEs]);
    p(1).Marker = '+';
    %p(2).Marker = 'o';
    %p(3).Marker = 'x';
%   p(4).Marker = '*';    
    xlabel('UEs')
    ylabel('Time (seconds)')
%   legend('First UE with interference', 'Last UE with interference', 'First UE without interference', 'Last UE without interference');
    legend('Correct order of UEs decode', 'Incorrect order of UEs decode', 'Sum of two computations');
end