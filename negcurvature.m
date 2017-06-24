function [c,ind,r,SS]=negcurvature(X)
% fit the best hyperbolic space with negative curvature
% input: X=data matrix
% output: c=center
%              ind=index of the Lorentz inner product
%              r=radius
%              SS=mean of square error
[n,m]=size(X);
if (n>m)
    l=zeros(n,1);
    Xbar=zeros(m,1);
    Xbar=Xbar/n;
    objValue=zeros(m,1);
    centers=zeros(m,1);
    const=zeros(m,1);
    SSs=zeros(m,1);
    for k=1:m
        M=eye(m);
        M(k,k)=-1;
        for i=1:n
            l(i)=X(i,:)*M*X(i,:).';
            Xbar=Xbar+X(i,:).';
        end
        lbar=mean(l);
        H=zeros(m);
        f=zeros(m,1);
        for i=1:n
            H=H+(Xbar-X(i,:).')*(Xbar-X(i,:).').';
            f=f+(l(i)-lbar)*(Xbar-X(i,:).');
        end
        H=2*H;
        f=M*f;
        c=-inv(H)*f;
        %options = optimset('Display', 'off');
        %c=quadprog(H,f,[],[],[],[],[],[],[],options);
        centers(:,k)=c;
        objValue(k)=abs(1/2*c.'*H*c+f.'*c);
        dist=zeros(n,1);
        for j=1:n
            dist(j)=(X(j,:).'-c).'*M*(X(j,:).'-c);
        end
        const(k)=mean(dist);
        SSs(k)=var(dist);
    end
    ind=min(find(objValue==min(objValue)));
    c=centers(:,ind);
    r=const(ind);
    SS=SSs(ind);
else
    SS=0;
    c=zeros(m,1);
    ind=-2;
    r=0;
end
return
