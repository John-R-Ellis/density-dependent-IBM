function [Nc,A,pop,free]=clusterprop(Px,Py,Lx,Ly,lt,ht,Nl,Np)

Pb=zeros(Np,2);

 Pc=[Px ;Py]';
 
 
Bx=Lx/Nl:Lx/Nl:Lx; By=Ly/Nl:Ly/Nl:Ly;

 Pt(:,:)=histcounts2(Pc(:,1), Pc(:,2),0:Lx/Nl:Lx,0:Ly/Nl:Ly);

 
for i=1:Np
    for Bi=1:Nl
        for Bj=1:Nl
            if Px(i)>=Bx(Bi)-Lx/Nl && Px(i)<=Bx(Bi) &&...
                    Py(i)>=By(Bj)-Ly/Nl && Py(i)<=By(Bj)
                Pb(i,:)=[Bi Bj];
            end
        end
    end
end


[C,~,~]=patchdefIBM(lt,ht,Pt);

[Bl,L,No]=bwboundaries(C,4,'noholes');

Pcl=diag(L(Pb(:,1),Pb(:,2)));  
for c=1:No
    Clp{c}=find(Pcl==c);
    [Corn{c},area(c)]=boundary(Pc(Clp{c},:),0.2);
end
    if No~=0
    [cltotal, ~, ~, ~, ~, ~]=clusterprocessingIBM(L, C, Bl,Nl);
    free=Np-sum(cltotal);
    pop=mean(cltotal);
    A=mean(area);
    else
        free=nan;
        pop=nan;
        A=nan;
    end
    Nc=No;
    
    
    

