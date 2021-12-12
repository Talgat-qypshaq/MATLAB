clear all; close all; clc;
phase = 4800;
iterations = 1;
%x = 1:1:phase*iterations;
f = zeros(phase);
dx=phase/(phase-1);
for a=1:1:iterations    
    %x = 1:1:(a*phase);
    f(phase*(a-1)+1:phase*(a-1)+(phase/2)) = 1;
    
    fprintf('f = %d\n', size(f,2));
    %fprintf('x = %d\n', size(x,2));
    fprintf('phase = %d\n', size(phase,2));
    
    size(f,2)
    %size(x,1)

%     A0 = sum(f.*ones(size(x)))*dx*2/phase;
%     fFS=A0/2;
%     fprintf('cos(2*pi*k*x/phase) = %d\n', size(cos(2*pi*x/phase),2));
%     for k=1:5
%         Ak=sum(f.*cos(2*pi*k*x/phase))*dx*2/phase;
%         Bk=sum(f.*sin(2*pi*k*x/phase))*dx*2/phase;
%         fFS=fFS+Ak*cos(2*pi*k*x/phase)+Bk*sin(2*pi*k*x/phase);
%     end

end
plot(f,'k','Linewidth', 4);
ylim([-0.2 1.2])
%hold on
%plot(x, fFS, 'c-','Linewidth',3)