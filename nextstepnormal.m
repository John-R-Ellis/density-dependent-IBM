function [Px,Py]=nextstepnormal(Px,Py,sig,P,R,Nseg,Lx,Ly)

Np=size(Px,2);

pw=1/(1-P);
ang=[0:2*pi/Nseg:pi-2*pi/Nseg -pi:2*pi/Nseg:-2*pi/Nseg];

th=rand(Np,1)*2*pi-pi;
ss=abs(randn(Np,1)*sig);

dists=pdist2([Px' Py'],[Px' Py']);
clos=dists<=R & dists~=0;


ind=find((rand(1,Np)*pw-1)>=0);    

for i=ind
     pie=zeros(1,Nseg);
    
     ind2=find(clos(i,:)==1);
     NAngles=atan2((Py(ind2)-Py(i)),(Px(ind2)-Px(i)));
     for seg=1:Nseg
        pie(seg)=sum(NAngles>ang(seg) & NAngles<=ang(seg)+2*pi/Nseg);
     end
     Segmax=find(pie==max(pie));

    if length(Segmax)==1
        dir=Segmax;
    else 
        dir=randsample(Segmax,1); 
    end

    Nb=(atan2((Py(ind2)-Py(i)),(Px(ind2)-Px(i)))>ang(dir) & atan2((Py(ind2)-Py(i)),(Px(ind2)-Px(i)))<=ang(dir)+2*pi/Nseg);

    angtotal=atan2((Py(ind2)-Py(i)),(Px(ind2)-Px(i)));

    angR=angtotal(Nb);
    angmean=mean(angR);

    if size(angmean,2)>0
        th(i)=angmean;
    end
    if sum(pie)==0
        th(i)=rand*2*pi-pi;
    end
    
end  

Delx=ss.*cos(th); %step length in x direction
Dely=ss.*sin(th); %step length in y direction 


ind2=find((Px+Delx' > Lx) | (Px+Delx' < 0) | (Py+Dely' > Ly) | (Py+Dely' < 0));    

 for i=ind2

    while (Px(i)+Delx(i) > Lx) || (Px(i)+Delx(i) < 0) || (Py(i)+Dely(i) > Ly) || (Py(i)+Dely(i) < 0)  %closed boundary
       dm2=sign(rand*pw-1);
        if any(ind==i) && dm2>=0
            th(i)=th(i);
        else
            if any(ind==i) && dm2<0
               for seg=1:Nseg
                pie(seg)=sum(((Px-Px(i)).^2+(Py-Py(i)).^2).^0.5 <=R & atan2((Py-Py(i)),(Px-Px(i)))>ang(seg) & atan2((Py-Py(i)),(Px-Px(i)))<=ang(seg)+2*pi/Nseg & (Px+Py~=Px(i)+Py(i)));
               end
                Segmax=find(pie==max(pie));       
                if length(Segmax)==1
                    dir=Segmax;
                else 
                    dir=randsample(Segmax,1); 
                end         
                Nb=(((Px-Px(i)).^2+(Py-Py(i)).^2).^0.5 <=R & atan2((Py-Py(i)),(Px-Px(i)))>ang(dir) & atan2((Py-Py(i)),(Px-Px(i)))<=ang(dir)+2*pi/Nseg & (Px+Py~=Px(i)+Py(i)));
                angtotal=atan2((Py-Py(i)),(Px-Px(i)));        
                angR=angtotal(Nb);
                angmean=circ_mean(angR');
                    if size(angmean,2)>0
                    th(i)=angmean;
                    end
                    if sum(pie)==0
                     th(i)=rand*2*pi-pi;
                      end

                ind(i)=dm2;
            else
            th(i)=rand*2*pi-pi;
            end
        end
            ss(i)=abs(randn*sig);

        Delx(i)=ss(i)*cos(th(i)); %step length in x direction
        Dely(i)=ss(i)*sin(th(i)); %step length in y direction       
    end   
    
 end
Px=Px+Delx';
Py=Py+Dely';

