function [label,ncls,centers,innprod,consts,RegMSEs,MSE,epsilon,lambda,errors,npieces]=LOCU(X)
% normalize X 
[n,m] = size(X);
X = X-ones(n, 1)*mean(X, 1);
X = X/norm(X, Inf);

errors=[];
npieces=[];
% hyperparameters
par1 = [0.01, 0.001, 0.0001, 0.00001];
par2 = [0.05, 0.1, 0.15];
k = length(par1);
l = length(par2);
RegMSEs = zeros(k, l);

% crossvalidation to find the best hyperparameter
[Xtest,Xtrain] = splitdata(X, 1, 2);
for i = 1:k
    for j = 1:l
        %for p=1:5
            [label, ncls, centers, innprod, consts, MSE,RegMSE,Xhat,labelhat] = locquad(Xtrain, Xtest, par1(i), par2(j), par1(i), par2(j));
            RegMSE
            errors = [errors ; MSE];
            npieces = [npieces ; ncls];
            RegMSEs(i, j) = RegMSEs(i, j) + RegMSE ;
        %end
        %RegMSEs(i, j) = RegMSEs(i, j)/5;
    end
end
vecind = min(find(errors == min(errors(:)))); 
j = floor((vecind-1)/k)+1;
i = mod(vecind-1, k)+1;
epsilon1 = par1(i);
epsilon2 = par2(j);
epsilon = epsilon1;
epsilon3 = epsilon1;
lambda = epsilon2;
[label, ncls, centers, innprod, consts, MSE,RegMSE,Xhat,labelhat] = locquad(Xtrain, Xtest, epsilon1, epsilon2, epsilon3, lambda);
vs=[log10(npieces),log10(errors)];
vs=sortrows(vs,[1,-2]);

%view(3);
figure
subplot(1,4,1)       % draw test data
%plot3(Xtest(:, 1), Xtest(:, 2), Xtest(:, 3),'*','Color','blue');
plot(Xtest(:, 1), Xtest(:, 2),'*','Color','blue');
title('test data')


subplot(1,4,2)       % draw data projected to the manifold
%plot3(Xhat(:, 1), Xhat(:, 2), Xhat(:, 3),'*','Color','red');     
plot(Xhat(:, 1), Xhat(:, 2),'*','Color','red');
title('projected data')


subplot(1,4,3) % clustered data
hold on
for i = 1:ncls
    plot(Xhat(find(labelhat==i),1),Xhat(find(labelhat==i),2),'*');
    %plot3(Xhat(find(labelhat == i), 1), Xhat(find(labelhat == i), 2), Xhat(find(labelhat == i), 3), '*');
end 
title('projected data in clusters')



subplot(1,4,4)      % draw the plot of MSE vs npieces in log 10 scale
plot(vs(:,1),vs(:,2));
title('log10(MSE) vs log10(npieces)');
return
 