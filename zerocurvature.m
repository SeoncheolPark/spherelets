function [c,V,SS]=zerocurvature(X)
% fit the best plane with zero curvature
% input: X=data matrix
% output: c=center
%              V=basis that spans the plane
%              SS=mean of square error
d=2;
[n,m]=size(X);
if (n>m)
    c=mean(X);
    newX=X-ones(n,1)*mean(X);
    [COEFF,SCORE,latent]=princomp(X);
    V=COEFF(:,1:d);
    dist=zeros(n,1);
    Xhat=ones(n,1)*mean(X)+newX*V*V.';
    for i=1:n
        dist(i)=norm(X(i,:)-Xhat(i,:))^2;
    end
    SS=mean(dist);
else
    c=zeros(m,d);
    V=zeros(n,d);
    SS=0;
end
return