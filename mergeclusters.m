function label=mergeclusters(X,label,epsilon3,lambda)
ncls=max(label);
flag=1;
while flag==1&& ncls>1
    % distance matrix, dist(i,j) is the distance between cluster i and cluster j
    dist=zeros(ncls,ncls); 
    dist(ncls,ncls)=Inf;
    for i=1:ncls-1
        dist(i,i)=Inf;
        for j=i+1:ncls
            dist(i,j)=max(distance(X(find(label==i),:),X(find(label==j),:),lambda),0);
            dist(j,i)=dist(i,j);
        end
    end
    min(dist(:));
    % if the closest two clusters are close enough, emerge them
    if min(dist(:))>epsilon3
        flag=0;
    else
        % dist is vectorized, recover i j from the index in the new vector
        vecind=min(find(dist==min(dist(:)))); 
        r=floor((vecind-1)/ncls)+1;
        c=mod(vecind-1,ncls)+1;
        label(find(label==r))=c;
    end
    count=0;
    % renumerate labels so that they are consecutive
    for i=1:max(label)
        l=length(find(label==i));
        if l>0
        	count=count+1;
            label(find(label==i))=count*ones(l,1);
        end
    end
end
return