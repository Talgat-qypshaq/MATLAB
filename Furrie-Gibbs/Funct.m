clear all;
close all;
clc;
L=10;
N=1024;
dx=L/(N-1);
x= 0:dx:L;
f=zeros(size(x));
f(256:768)=1;
A0 = sum(f.*ones(size(x)))*dx*2/L;
fFS=A0/2;
for k=1:5
    Ak=sum(f.*cos(2*pi*k*x/L))*dx*2/L;
    Bk=sum(f.*sin(2*pi*k*x/L))*dx*2/L;
    fFS=fFS+Ak*cos(2*pi*k*x/L)+Bk*sin(2*pi*k*x/L);
end
plot(x,f,'k','Linewidth',4),hold on
plot(x, fFS, 'c-','Linewidth',3)
%set(gcf,'Position',[1500 200 2500 1500])