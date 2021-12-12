clear
close all
clc

%june 2020
Ri=0.007;
qavg = 2*(1/60000); %to convert from l/min to m3/s
sinpsi=0.25;
etag= 10^11; %Pa
k = 0.250e-12; %m2
kp= 1.3*k
phi=0.35
phip=0.4
T= 2*sin(63.4*pi/180)/(1-sin(63.4*pi/180));
sinalfa=sin(63.4*pi/180)
gammap=0.6
ucs=800000 %Pa
ucsp=750000 %Pa
tp=600; %stabilization time
Ro = 0.15; %outer radius, m
L = 0.214;
niu = 0.45; %Poisson's ratio
eta = 0.1; %poroelastic stress coefficient 0 - 0.5
miu = 0.001; %Pa*s, fluid viscosity

tanalfa = tan(63*pi/180); % failure angle, degrees
S0 = 250000; %Pa
sigc= 2*S0*tanalfa
t= tanalfa^2-1;
pw = 0; %fluid pressure at borehole, Pa 
po = 1850000; %Pa;
sigmav = 5000000; %Pa
sigmah = 1960000;
sigmaH = sigmah;
sigi=pw-pw;
drd = po-pw;

drdi=drd*1
a= miu*(T+gammap-0.5*gammap/(log(Ro/Ri)))/(2*pi*kp*phip*(1-phip)*2*pi*Ri^2(phip-phi))
b= (ucsp-k*phi*drdi/(kp*phip*log(Ro/Ri)))(1+0.5*T)/(2*pi*Ri^2(phip-phi))
c= -(po-0.3*po)/tp*(1-0.5*gammap+0.25*gammap/log(Ro/Ri))

syms qs real 
qs1 = double(solve(a*qs^2+b*qs+c,qs)); %m2/s
Z0=qs1(qs1>=0)
qsi=Z0*1500*L*60*1000; %to convert to g/min

%rr=[Ri];
sigInfm=[];
r2=[Ri];
qsm=[qsi];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for R=Ri:0.000005:1.3*Ri
       
syms qs2 sigRatR real

%eqn1= sigRatR-((ucsp+T*sigi-miu/(2*pi*kp*phip)(qavg-qs2/(1-phip)))/T((R/Ri)^T-1)+sigi)==0;
eqn1= sigRatR-(     (ucsp+T*sigi-miu/(2*pi*kp*phip)(qavg-qs2/(1-phip)))/T((R/Ri)^T-1)+sigi+2*etag*qs2/((1-sinpsi*sinalfa)2*pi(1-phip)Ri^2)((R/Ri)^T-(Ri/R)^(2/(1-sinpsi))) )==0;
gpni = miu*qavg/(2*pi*k*phi);
sigInf= sigRatR-(1-0.5*gammap)*gpni*log(Ro/R)+0.5*ucs+0.5*T*sigRatR-0.25*gammap*gpni;
sigInfm=[sigInfm sigInf];
diff= miu/(2*pi)*(log(R/Ri))/(kp*phip)+log(Ro/R)/(k*phi);
A= drd/diff;
B= miu*log(R/Ri)/(2*pi*kp*phip*(1-phip))/diff;
D= 1/phip*(B-1/(1-phip));
E= 1/T*(ucsp+T*0-miu*A/(2*pi*kp*phip))(1+0.5*T)(R/Ri-1)-miu*A/(2*pi*k*phi)*((1-0.5*gammap)*log(Ro/R)+0.25*gammap)+0.5*ucs;
F= miu*D/(2*pi*kp*T)(1+0.5*T)(R/Ri-1)+miu*B/(2*pi*k*phi)*((1-0.5*gammap)*log(Ro/R)+0.25*gammap);   
eqn2= qs2-(E-sigInf)/F==0;
 [qs2, sigRatR] = solve(eqn1, eqn2, [qs2, sigRatR]);

qsm = [qsm double(qs2)*1500*L*60*1000];
r2=[r2 R]
end

figure (1)
plot(r2,qsm);
xlabel('radius');
ylabel('sand rate');


%kavg = qavg*miu*(log(Ro/Ri))/(drd*2*pi*L)
%p1 = pw + qavg*miu*log(R/Ri)/(2*pi*L*kavg);
%kp = kavg*k*log(R/Ri)/(k*log(Ro/Ri)-kavg*log(Ro/R));
% a1=a+(1+0.5*T)/(2*pi*R^2*(phip-phi))(2/(1-sinalfa*sinpsi))*eta/(2*pi*Ri^2(1-phip))*(T+2/(1-sinpsi));
% b1= (ucsp-k*phi*drd/(kp*phip*log(Ro/Ri)))(1+0.5*T)/(2*pi*R^2(phip-phi));

% syms qs2 real
% qqs2 = double(solve(a1*qs2^2+b1*qs2+c,qs2)); %m2/s
% B1=qqs2(qqs2>=0)
% qsm=[qsm B1*1500*L*60*1000];