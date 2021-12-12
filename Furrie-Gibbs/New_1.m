clear
close all
clc
%13apr 2020
a = 0; %rotation around z' axis
i = pi*0/180; %rotation around y axis

Ro = 0.15; %outer radius, m
niu = 0.45; %Poisson's ratio
eta = 0.1; %poroelastic stress coefficient 0 - 0.5
theta = 0*pi/180; % angle around borehole
L = 0.214;

S0 = 250000; %Pa
tanalfa = tan(63*3.14/180); % failure angle, degrees
gamma = sqrt(tanalfa^4-2*niu*tanalfa^2+1);
t = tanalfa^2-1;
V = tanalfa^4+1-niu*(tanalfa^2+1)^2;
miu = 0.001; %Pa*s, fluid viscosity

k = 0.250e-12; %m2
pw = 0; %fluid pressure at borehole, Pa 

po = 910000; %Pa;
qavg = 2.2*(1/60000); %to convert from l/min to m3/s


sigmav = 4000000; %Pa
sigmah = 1510000;
sigmaH = sigmah;
drd = po-pw;
Ri = 0.007019; %hole radius, m

NNRi=[];
NNrc = [];
NNkp = [];
tt = [];
q22 = [];
rr = [];
kavgg = [];
kpp = [];
q33=[];
s=[];
qqf=[];
drdd=[];
NN= [];
Nkavgg =[];
porfinn =[];
    
Runtime= 4800; %seconds
for N= 1:1:2 % number of shut-in runs
    NN=[NN N];
  NRi= Ri*(1+(0.044*log(N)+0.001));
  NNRi= [NNRi NRi];
    
  Nqavg=qavg*(1-(0.0132*N+0.0141));
    Nkavg = Nqavg*miu*(log(Ro/NRi))/(drd*2*pi*L); %m2
    Nkavgg= [Nkavgg Nkavg]

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    syms rc kp real

    eqn1 = kp - (Nkavg*k*log(rc/NRi)/(k*log(Ro/NRi)-Nkavg*log(Ro/rc))) == 0;

    p1 = pw + Nqavg*miu*log(rc/NRi)/(2*pi*L*kp);
    p2 = po - Nqavg*miu*log(Ro/rc)/(2*pi*L*k);

    sigma3p = pw+miu*qavg*log(rc/NRi)/(2*pi*L*kp)+1/t*(2*S0*tanalfa-miu*qavg/(2*pi*L*kp))*((rc/NRi)^t-1)-p1;
    sigma1e = sigmah+(sigmah-pw)NRi^2(1+Ro^2/rc^2)/(Ro^2-NRi^2)-drd*eta*(NRi^2*(1+Ro^2/rc^2)/(Ro^2-NRi^2)+(log(Ro/rc)-1)/log(Ro/NRi))- p2;
              
    eqn2 = sigma1e - 2*S0*tanalfa-sigma3p*tanalfa^2 == 0;
    [rc, kp] = solve(eqn1, eqn2, [rc, kp])

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    NNrc= [NNrc double(rc)]
    NNkp= [NNkp double(kp)]
       
 
    for time = ((N-1)*Runtime+1):50:N*Runtime %for 80 minutes
        
    tt = [tt time];
    
    ff= time*pi/(Runtime/2)-3;
    FS = (1-(sin(ff) + sin(3*ff)/3 + sin(5*ff)/5 + sin(7*ff)/7 + sin(9*ff)/9 + sin(11*ff)/11+sin(13*ff)/13)+sin(15*ff)/15+sin(17*ff)/17+sin(19*ff)/19)/2;
    drd2 = (drd*(1-1/(2^(time/16))))*FS;
        drdd = [drdd drd2];
    q2 = (Nqavg*(1-1/(2^(time/16))))*FS;
        q22 =[q22 q2*60000]; %convert to l/min   
    
        syms rrc kkp real
        eqn3 = kkp - (Nkavg*k*log(rrc/NRi)/(k*log(Ro/NRi)-Nkavg*log(Ro/rrc))) == 0;
        pp1 = pw + q2*miu*log(rrc/NRi)/(2*pi*L*kkp);
        pp2 = po - q2*miu*log(Ro/rrc)/(2*pi*L*k);

        sigma33p = pw+miu*q2*log(rrc/NRi)/(2*pi*L*kkp)+1/t*(2*S0*tanalfa-miu*q2/(2*pi*L*kkp))*((rrc/NRi)^t-1)-pp1;
        sigma11e = sigmah+(sigmah-pw)Ri^2(1+Ro^2/rrc^2)/(Ro^2-Ri^2)-drd2*eta*(Ri^2*(1+Ro^2/rrc^2)/(Ro^2-Ri^2)+(log(Ro/rrc)-1)/log(Ro/Ri))- pp2;
    eqn4 = sigma11e - 2*S0*tanalfa-sigma33p*tanalfa^2 == 0;
    [rrc, kkp] = solve(eqn3, eqn4, [rrc, kkp]);
    
   kpp =[kpp kkp];
   [rr] = [rr rrc];
   
coeff = 14.5*10^-13; %Kozeny-carman  coeff

syms p0 real %initial porosity
porinit = double(solve(p0^3*coeff/(1-p0)^2-k,p0)); 

%KK = min(kpp)
%syms p1 real %minimal porosity in the yielded zone
%pormin = double(solve(p1^3*coeff/(1-p1)^2-KK,p1))

syms p2 real %porosity at plastic zone boundary
porfin = double(solve(p2^3*coeff/(1-p2)^2-kkp,p2));
[porfinn]= [porfinn porfin];

   %qf=q3;
   qqf=[qqf q2*60000]; %in l/min
   
   syms qs real
eqn5 = q2-(2*pi*L*kkp*porfin*drd2/miu + qs/(1-porfin)*log(rrc/Ri))/(log(rrc/Ri)+(kkp*porfin)/(k*porinit)*log(Ro/rrc))== 0;
       qqs= solve(eqn5, qs);
   
s = [s double(qqs)*1.500*1000*60000];


end
end
    
figure(1)
plot(tt,q22);
xlabel('time');
ylabel('flowrate, l/min');

figure(2)
plot(tt,rr);
xlabel('time');
ylabel('plastic zone radius, m');

figure(4)
plot(tt,kpp);
xlabel('time');
ylabel('plastic zone permeability, mD');

figure (5)
plot(tt,s);
xlabel('time');
ylabel('sand rate');

figure (6)
plot(NN, NNrc);
xlabel('shut-in run number');
ylabel ('yielded zone radius');

figure (7)
plot (NN, Nkavgg);
xlabel('shut-in run number');
ylabel ('average permeability');

figure (8)
plot (tt, porfinn);
xlabel('time');
ylabel ('instant porosity');