function dist=distance(X,Y,lambda)
% find the distance between two sets of points
% input: X=data matrix
%           Y=another data matrix
% output: dist=distance between X and Y

[nX,mX]=size(X);
[nY,mY]=size(Y);

% fit X
if nX<=mX+1
    SSXpos=0;
    SSXneg=0;
    SSXzero=0;
else
    [cXpos,rXpos,SSXpos]=poscurvature(X);
    %[cXneg,indXneg,rXneg,SSXneg]=negcurvature(X);
    SSXneg=Inf;
    %[cXzero,VXzero,SSXzero]=zerocurvature(X);
    SSXzero=Inf;
    
end

% fit Y
if nY<=mY+1
    SSYpos=0;
    SSYneg=0;
    SSYzero=0;
else
    [cYpos,rYpos,SSYpos]=poscurvature(Y);
    %[cYneg,indYneg,rYneg,SSYneg]=negcurvature(Y);
    SSYneg=Inf;
    %[cYzero,VYzerp,SSYzero]=zerocurvature(Y);
    SSYzero=Inf;
end

% bind X and Y together
Z=[X;Y];
[nZ,mZ]=size(Z);
% fit Z
if nZ<=mZ+1
    SSZpos=0;
    SSZneg=0;
    SSZzero=0;
else
    [cZpos,rZpos,SSZpos]=poscurvature(Z);
    %[cZneg,indZneg,rZneg,SSZneg]=negcurvature(Z);
    SSZneg=Inf;
    %[cZzero,VZzerp,SSZzero]=zerocurvature(Z);
    SSZzero=Inf;
end

% find the distance based on the best approximation of Z
if SSZpos==min(min(SSZneg,SSZpos),SSZzero)
    Riemdist=SSZpos;%-SSXpos-SSYpos;
else if SSZneg<SSZzero
    Riemdist=SSZneg;%-SSXneg-SSYneg;
    else
        Riemdist=SSZzero;%-SSXzero-SSYzero;
    end
end
Eucdist=Inf;
for i=1:size(X,1)
    for j=1:size(Y,1)
        currdist=norm(X(i,:)-Y(j,:));
        if currdist<Eucdist
            Eucdist=currdist;
        end
    end
end
dist=Riemdist+double(Eucdist>lambda);
return