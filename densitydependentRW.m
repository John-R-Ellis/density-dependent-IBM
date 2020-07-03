%%Input variables
Lx=10; %horizontal length of cell
Ly=10; %vertical length of cell

Nseg=6; %number of segments

Np=10000; %no. of particles
Nt=1000; %Days*24*60/Timestep; %time steps

lt=0.0025*Np; ht=0.005*Np; %Upper and lower thresholds for cluster identification
Nl=20; %Number of bins in each dimension

sig=0.02;
P=0.6;
R=1;

gamma=2;
k1=(1.16*(2*sig^2)^0.5)/(10^(1/(gamma-1))-1); 


%%initial position
Px=rand(1,Np)*Lx; 
Py=rand(1,Np)*Ly; 

  
%% Random Walk

for j=1:Nt
j
    %Choose either a normal or power law distribution for the dispersal kernel
%     [Px,Py]=nextstepnormal(Px,Py,sig,P,R,Nseg,Lx,Ly);
    [Px,Py]=nextsteppl(Px,Py,gamma,k1,P,R,Nseg,Lx,Ly);


    [Nc(j),A(j),Pop(j),Free(j)]=clusterprop(Px,Py,Lx,Ly,lt,ht,Nl,Np);

end
