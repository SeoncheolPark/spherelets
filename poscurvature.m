function [c,r,SS]=poscurvature(X)
% fit the best sphere with positive curvature
% input: X=data matrix
% output: c=center
%              r=radius
%              SS=mean square error
[n,m]=size(X);
if (n>m)
    l=zeros(n,1);
    Xbar=zeros(m,1);
    for i=1:n
        l(i)=norm(X(i,:))^2;
        Xbar=Xbar+X(i,:).';
    end
    lbar=mean(l);
    Xbar=Xbar/n;
    H=zeros(m);
    f=zeros(m,1);
    for i=1:n
        H=H+(Xbar-X(i,:).')*(Xbar-X(i,:).').';
        f=f+(l(i)-lbar)*(Xbar-X(i,:).');
    end
    H=2*H;
    f=f;
    %c=-inv(H)*f;
    options = optimset('Display', 'off');
    c=quadprog(H,f,[],[],[],[],[],[],[],options);
    d=zeros(n,1);
    for i=1:n
        d(i)=norm(c-X(i,:).');
    end
    r=mean(d);
    sqd=d.^2;
    SS=var(d);
else
    SS=0;
    c=mean(X,1);
    r=norm(X(1,:)-c);
end
return
