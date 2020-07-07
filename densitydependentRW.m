%%Input variables
Lx=10; %horizontal length of cell
Ly=10; %vertical length of cell

Nseg=6; %number of segments

Np=10000; %no. of particles
Nt=1000;  %time steps

lt=0.0025*Np; ht=0.005*Np; %Upper and lower thresholds for cluster identification
Nl=20; %Number of bins in each dimension

sig=0.02; %standard deviation of the step size for Brownian walkers
P=0.6; % Probability of density-dependent movement
R=1; % Perception radius

gamma=2; % gamma value in the power law distribution for Levy walkers
k1=(1.16*(2*sig^2)^0.5)/(10^(1/(gamma-1))-1); % k value calculated from sigma to compare to Brownian walkers


%%initial position
Px=rand(1,Np)*Lx; % x coordinate
Py=rand(1,Np)*Ly; % y coordinate

  
%% Random Walk

for j=1:Nt
j
    %Choose either a normal or power law distribution for the dispersal kernel
     [Px,Py]=nextstepnormal(Px,Py,sig,P,R,Nseg,Lx,Ly);
%    [Px,Py]=nextsteppl(Px,Py,gamma,k1,P,R,Nseg,Lx,Ly);


    [Nc(j),A(j),Pop(j),Free(j)]=clusterprop(Px,Py,Lx,Ly,lt,ht,Nl,Np); % Number of clusters, mean cluster area, mean cluster population, mean number of free individuals

end
