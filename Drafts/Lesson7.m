x = 25;
class(x);
%fprintf('%s', 125);
a = 'MATLAB';
b = a(end:-1:1);
%a==b;
clc;
message = 'I love you';
code = double(message);
disp(message);
disp(code);
secretMessage = char(code+7);
disp(secretMessage);
decodedMessage = char(secretMessage-7);
disp(decodedMessage);
ss = sprintf('%s', decodedMessage);
%structs start
structName.fieldName = 1989;
sf = sprintf('%d', structName.fieldName);
class(sf);
disp(sf);
disp(class(structName));
disp(class(structName.fieldName));
structName.fieldName2 = 'was born in that year';
structName.subStructName.status = 'married';
disp(structName);

hobby = struct('Education','Coursera','Sport','BJJ','Other','Not Yet');
disp(hobby);

%COMMENT cells and pointers
disp('cells start');
line{1} = 'Tiger, tiger burning bright';
line{2} = 'In the forests of the night';
line{3} = pi;

disp(class(line));
disp(class(line{1}));

for lines = 1:length(line)
    disp(line(lines));
end
