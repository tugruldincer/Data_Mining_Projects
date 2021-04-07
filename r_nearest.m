function result=rnearest(a,b,r,n)

result=zeros(size(b,1),1);
for i=1:size(b,1)
    zero=0;first=0;
    distances=zeros(size(a,1),1);
    for j=1:size(a,1)
        euc=0;
        for k=1:(n-1)
            x=((b(i,k))-(a(j,k)))^2;
            euc=euc+x;
        end
        dist=sqrt(euc); %euclidean distances
        distances(j)=dist;
    end
    for j=1:size(a,1)
        if r>=distances(j)
            if a(j,n)==0
                zero=zero+1;
            else
                first=first+1;
            end
        end
    end
    if first==0 && zero==0
        if sum(a(:,n)==1)>=sum(a(:,n)==0)
            result(i)=1;
        else
            result(i)=0;
        end
    elseif zero>first
        result(i)=0;
    elseif first>=zero && first~=0
        result(i)=1;
    end
end
end