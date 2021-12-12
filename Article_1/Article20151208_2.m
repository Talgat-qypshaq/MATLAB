%load from file into an array
%M1 = csvread('power2.dat', ' ');
%M2 = dlmread('power2.txt',' ');

%interference
% numberOfUsers = 5;
% ch = ones(1, numberOfUsers);
% channelOfNotFirstUser = 1;    
% for currentUser = 2:1:NumberOfUsers
%    channelOfNotFirstUser = channelOfNotFirstUser*10;  %increase channel 10 times for the rest users
%    ch(1, currentUser) = channelOfNotFirstUser;        %allocate channel as described above
% end
% disp(ch);

%jain's equations