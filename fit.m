function [center,ind,const,SS]=fit(X)
% find the best space form
% input: X=data matrix
% output: center=center of the space form
%              ind=which kind of space form: -1 for sphere, 0 for plane,
%              positive values for index of Lorentz inner product
%              const=constant in the equation of space form
%              SS=variance of radius
    [n,m]=size(X);
    % try three possible kinds of space forms
    [cpos,rpos,SSpos]=poscurvature(X);
    %[cneg,indneg,rneg,SSneg]=negcurvature(X);
    SSneg=Inf;
    %[czero,Vzero,SSzero]=zerocurvature(X);
    SSzero=Inf;
    % find the best one from the three
    if SSpos==min(min(SSpos,SSneg),SSzero)
        center=cpos;
        ind=-1;
        const=rpos;
        SS=SSpos;
    else if SSneg<SSzero
        center=cneg;
        ind=indneg;
        const=rneg;
        SS=SSneg;
        else
            center=czero;
            ind=0;
            const=Vzero;
            SS=SSzero;
        end
    end
return