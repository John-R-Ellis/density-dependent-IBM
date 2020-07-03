function [cltotal, clnumber, claverage, clarea, cldensity, Cdensity, bl]=clusterprocessing(L, C, Bl, N)
    
L(:,:,2)=C;
L(1:N,:,:)=L(N:-1:1,:,:);
for k=1:max(max(L(:,:,1)))
    cltotal(k)=0;
    clnumber(k)=0;
    for i=1:N
        for j=1:N
            if L(i,j,1)==k;
                cltotal(k)=cltotal(k)+L(i,j,2);
                clnumber(k)=clnumber(k)+1;
                claverage(k)=cltotal(k)/clnumber(k);
            end
        end
    end
end
if max(max(L(:,:,1)))==0
    clnumber=0;
    cltotal=0;
    claverage=0;
end
clarea=clnumber.*(10/N)^2;

for i=1:length(Bl)
    bl{i}=(Bl{i}-1)./(N-1);
    bl{i}(:,1)=1-bl{i}(:,1);
    bl{i}(:,[1 2]) = bl{i}(:,[2 1])*10;
%     clarea(i)=polyarea(bl{i}(:,1),bl{i}(:,2));
end

cldensity=cltotal./clarea; %count/no. of traps - area to be used in future
Cdensity=sum(sum(C(2:N-1,2:N-1)))*144/100;%./N^2;
end
