function [ dpq,pq,vk,ik ] = PFsolve( x,y,vref,pqref )
%PFsolve Summary of this function goes here
%   x: variables for solution
%   y: admittance matrix
%   vref: voltage references for slack-bus or PV-busses.
%       Complex value if angle is defined for slack-bus.
%   pqref: p-references for PV-busses and p+jq for PQ-busses.

% Node voltages
vk(1,1)=vref(1);
vk(2,1)=vref(2)*exp(1j*x(1));
vk(3,1)=x(2)*exp(1j*x(3));

% Injected currents into nodes
ik=y*vk;

% Injected power into nodes
pq=vk.*conj(ik);

% Equations to solve for zero through variables in x
dpq(1)=real(pqref(2)-pq(2));
dpq(2)=real(pqref(3)-pq(3));
dpq(3)=imag(pqref(3)-pq(3));
end

