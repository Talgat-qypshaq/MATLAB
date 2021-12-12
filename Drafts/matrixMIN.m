a = [1 2 3; 4 5 1; 7 8 10];
row = sum(a, i);
fprintf('Row %d \n', row);
[Min, Index] = min(a(:));
[I_row, I_col] = ind2sub(size(a),Index);
fprintf('Row index %d \n', I_row);
fprintf('Column index %d \n', I_col);

min_sum = 100;
for i = 1:1:length(a)            
    if(sum(a(i,:)) < min_sum)
        min_sum = sum(cap(i,:));
        min_sum_index = i;
    end      
end