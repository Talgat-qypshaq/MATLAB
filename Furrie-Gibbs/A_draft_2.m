t = linspace(0,3*4800)';
x = square(t);

%plot(t/pi,x,'.-',t/pi,1.15*sin(2*t))
plot(t/pi, x, '.-')
%xlabel('t / \pi')
ylim([-0.2 1.2])
grid on