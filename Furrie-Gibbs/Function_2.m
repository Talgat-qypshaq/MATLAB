clear all; close all; clc;
max_iter = 5;
for a=1:1:max_iter

    L=4800;
    N=4800;

    dx=L/(N-1);
    x=0:dx:L*a;

    f=zeros(size(x));
    
    if(a==max_iter)
        for b=1:max_iter-1
            f(b+N*(b-1) : ( (b-1)*N )+ N/2 ) = 1;
        end
        b=max_iter;
        f(b+N*(b-1) : (b-1)*N+N/2-4) = 1;
    end
    
    fprintf('f = %d\n', size(f,2));
    fprintf('x = %d\n', size(x,2));
    
    A0=sum(f.*ones(size(x)))/a*dx*2/L;
    fFS=A0/2;

    for k=1:5
       Ak=sum(f.*cos(2*pi*k*x/L))/a*dx*2/L;
       Bk=sum(f.*sin(2*pi*k*x/L))/a*dx*2/L;
       fFS=fFS+Ak*cos(2*pi*k*x/L)+Bk*sin(2*pi*k*x/L);
    end
    
%     A0=sum(f.*ones(size(x)))*dx*2/L;
%     fFS=A0/2;
% 
%     for k=1:5
%        Ak=sum(f.*cos(2*pi*k*x/L))*dx*2/L;
%        Bk=sum(f.*sin(2*pi*k*x/L))*dx*2/L;
%        fFS=fFS+Ak*cos(2*pi*k*x/L)+Bk*sin(2*pi*k*x/L);
%     end
    
end

plot(x, f,'k','Linewidth',4),hold on
plot(x, fFS, 'c-','Linewidth',3)

%set(gcf,'Position',[1500 200 2500 1500])
ylim([-0.2 1.2]);