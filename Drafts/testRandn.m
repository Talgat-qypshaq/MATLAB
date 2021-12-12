function [ output_args ] = testRandn( NumberOfUEs )
    for i=1:1:NumberOfUEs
        disp(randn);
    end
    output_args = 25;
end

