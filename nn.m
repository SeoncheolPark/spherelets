function [nbhdind,nd]=nn(X,i,label)
% find the nearest neighbour of X(i,:)
n=size(X,1);
dist=zeros(n,1);
currcls=X(find(label==i),:);
currn=size(currcls,1);
for j=1:n
    if label(j)>0 
        dist(j)=Inf;
    else
        withindist=zeros(currn,1);
        for k=1:currn
            withindist(k)=norm(X(j,:)-currcls(k,:));
        end
        dist(j)=min(withindist);
    end
end
nbhdind=min(find(dist==min(dist)));
nd=min(dist);
return