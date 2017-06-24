function [MSE,RegMSE,Xhat,labelhat]=Serror(X,label,ncls,centers,innprod,consts)
% input: X=data
%           label=labels of data
%           centers=centers of each piece
%           innprod=indices of each piece
%           consts=corresponding constants of each piece
[n,m]=size(X);
MSE=0;
Xhat=zeros(n,m);
labelhat=zeros(n,1);
for i=1:n
    dist=zeros(ncls,1);
    for j=1:ncls
        if innprod(j)==-1
            dist(j)=(norm(X(i,:)-centers(j,:))-consts(j))^2;
        end
        if innprod(j)==0
            dist(j)=norm(X(i,:)-X(i,:)*consts(j)*consts(j).')^2;   
        end
    end
    ind=min(find(dist==min(dist)));
    labelhat(i)=ind;
    Xhat(i,:)=centers(ind,:)+(consts(ind)/norm(X(i,:)-(centers(ind,:))))*(X(i,:)-centers(ind,:));
    MSE=MSE+min(dist);
end
MSE=MSE/n;
RegMSE=log(ncls+1)*MSE;
return