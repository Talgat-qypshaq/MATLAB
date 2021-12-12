figure

%[-1,0,1,1]
%[0,-1,0,1]
R_1 = [-1,0,1,1];
R_2 = [0,-1,0,1];

rectangle('Position',[R_1(1),R_1(2),R_1(3)-R_1(1),R_1(4)-R_1(2)]);
rectangle('Position',[R_2(1),R_2(2),R_2(3)-R_2(1),R_2(4)-R_2(2)]);
axis([0 2 0 2]);

text(R_1(1),R_1(2),'A_1');
text(R_1(1),R_1(4),'B_1');
text(R_1(3),R_1(4),'C_1');
text(R_1(3),R_1(2),'D_1');

text(R_2(1),R_2(2),'A_2');
text(R_2(1),R_2(4),'B_2');
text(R_2(3),R_2(4),'C_2');
text(R_2(3),R_2(2),'D_2');