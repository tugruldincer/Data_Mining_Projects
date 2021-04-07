function result=fuzzyknn(a, b, knn,n)

result=zeros(size(b,1),1);
for i=1:size(b,1)
    distances=zeros(size(a,1),1);
    class=zeros(knn,2);
    for j=1:size(a,1)
        euc=0;
        for k=1:(n-1)
            x=((b(i,k))-(a(j,k)))^2;
            euc=euc+x;
        end
        dist=sqrt(euc); %euclidean distances
        distances(j)=dist; %distances of validation point to all train points
    end
    [Y,I] = sort(distances); %find the indexes of closest points
    class=[a(I(1:knn),n),Y(1:knn)];
    nom=zeros(1,2);
    for t= 0:1
        pay=0;
        for m=1:knn
            if class(m,1)==t
                pay=1/(class(m,2)^2)+pay;
                if pay==Inf
                    pay=1;
                end
            end
        end
        nom(t+1)=pay;
    end
    denom=0;
    for t=1:knn
        denom=1/(class(t,2)^2)+denom;
        if denom==Inf
            denom=1;
        end
    end
    nom=nom/denom;
    [Y,I]=sort(nom);
    result(i)=I(length(unique(a(:,n))))-1;
end