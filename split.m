function label=split(X,epsilon1,epsilon2)
% split data into pieces that are fitted well by space forms
% input: X=data matrix
%           epsilon=error boundary
[n,m]=size(X);
label=zeros(n,1);
count=0;
while (length(find(label==0))>0)
    count=count+1;
    upi=find(label==0);
    temp=randperm(length(upi));
    label(upi(temp(1)))=count;
    flag=1;
    while flag==1 && length(find(label==0))>0
        curr=X(find(label==count),:);
        [augind,nd]=nn(X,count,label);
        if nd<epsilon2
            %[center,ind,const,SS]=fit(curr);
            augcurr=[curr;X(augind,:)];
            [center,ind,const,SS]=fit(augcurr);
            if SS<epsilon1
                label(augind)=count;
            else
                flag=0;
            end
        else
            flag=0;
        end
    end
    if length(find(label==count))<2*m+1
        label(find(label==count))=-1;
       count=count-1;
    end
end
return
