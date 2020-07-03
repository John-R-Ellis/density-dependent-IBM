function [Fp,Fb,Rt]=patchdefIBM(lt,ht,F)
N=size(F,1);

Ft=ones(N,N);  
indices = find(F<lt);
Ft(indices) = 0;

Fb=zeros(N,N); 
indices = find(F>=ht);
Fb(indices) = 1;

for k=1:N
        if Ft(1,1)==1 && (Fb(2,1)==1 || Fb(1,2)==1)
           Fb(1,1)=1;
        end
        if Ft(1,N)==1 && (Fb(1,N-1)==1 || Fb(2,N)==1)
           Fb(1,N)=1;
        end
        if Ft(N,1)==1 && (Fb(N-1,1)==1 || Fb(N,2)==1)
           Fb(N,1)=1;
        end
        if Ft(N,N)==1 && (Fb(N-1,N)==1 || Fb(N,N-1)==1)
           Fb(N,N)=1;
        end
    for j=2:N-1
        if Ft(1,j)==1 && (Fb(2,j)==1 || Fb(1,j-1)==1 || Fb(1,j+1)==1)
           Fb(1,j)=1;
        end
        if Ft(N,j)==1 && (Fb(N-1,j)==1 || Fb(N,j-1)==1 || Fb(N,j+1)==1)
           Fb(N,j)=1;
        end
    end
    
    for i=2:N-1
        if Ft(i,1)==1 && (Fb(i-1,1)==1 || Fb(i+1,1)==1 || Fb(i,2)==1)
           Fb(i,1)=1;
        end
        if Ft(i,N)==1 && (Fb(i-1,N)==1 || Fb(i+1,N)==1 || Fb(i,N-1)==1)
           Fb(i,N)=1;
        end
        
        for j=2:N-1
            if Ft(i,j)==1 && (Fb(i-1,j)==1 || Fb(i+1,j)==1 || Fb(i,j-1)==1 || Fb(i,j+1)==1)
               Fb(i,j)=1;
            end
        end
        
    end
end

Fp=Fb.*F;
Rt=ones(N,N);  
indices = find(Fb==1);
Rt(indices) = NaN;

end