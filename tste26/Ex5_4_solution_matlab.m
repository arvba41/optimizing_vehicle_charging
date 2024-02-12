Xkm = 0.376;
Rkm = 0.037;
Bkm = 4.5e-6;

% Line lengths [km]
L12 = 150;
L13 = 200;
L23 = 150;

% Line impedance [Ohm]
Z12 = (Rkm + 1j * Xkm) * L12;
Z13 = (Rkm + 1j * Xkm) * L13;
Z23 = (Rkm + 1j * Xkm) * L23;
% Line susceptance [Mho]
B12 = Bkm * L12;
B13 = Bkm * L13;
B23 = Bkm * L23;

% Base data for pu calc
Sbase = 100e6;
Vbase = 345e3;
Zbase = Vbase^2 / Sbase;
Ybase = 1 / Zbase;

% Surge impedance
Zc = sqrt(Xkm/Bkm);
SIL = Vbase^2/Zc;

% pu line impedance
z12=Z12/Zbase;
z13=Z13/Zbase;
z23=Z23/Zbase;
% pu line admittance
y12=1j*B12/Ybase;
y13=1j*B13/Ybase;
y23=1j*B23/Ybase;

% Admittance matrix
y(1,1)=(y12+y13)/2+1/z12+1/z13;
y(1,2)=-1/z12;
y(1,3)=-1/z13;
y(2,1)=-1/z12;
y(2,2)=(y12+y23)/2+1/z12+1/z23;
y(2,3)=-1/z23;
y(3,1)=-1/z13;
y(3,2)=-1/z23;
y(3,3)=(y13+y23)/2+1/z13+1/z23;

% target references
v1=1; % angle=0
v2=1.05;
p2_ref=2;
p3_ref=-5;
q3_ref=-1;

vref=[v1,v2,0];
pqref=[0,p2_ref,p3_ref+1j*q3_ref];

% Initial value for [v2_angle, v3_magnitude, v3_angle]
x0=[0 1 0];
% Solve system equations
x=fsolve(@PFsolve,x0,[],y,vref,pqref);
% Calculate P, Q, V and I at the solution point defined by x
[ dpq,pq,vk,ik ] = PFsolve( x,y,vref,pqref );
