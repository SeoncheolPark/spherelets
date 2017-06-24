function [Xtrain,Xtest] = splitdata(X,i,folds)
%
% [X, Y, Xtest, Ytest] = splitdata(D,i,folds)
%
% This function partitions a dataset D to a training input matrix X,
% a training response vector Y, a test input matrix Xtest, and
% a test response vector Y. folds is the number of subsets, and the i-th
% set is chosen. 
%
% Input:
% D    - a dataset  where the last column is the response column
% i    - the i-th subset is chosen
% folds- D is divided into folds parts
%
% Outputs:
% X     - training input matrix
% Y     - training response vector
% Xtest - test input matrix
% Ytest - test response vector
%

% the size of one fold
[n,m]=size(X);
P = randperm(n);
X = X(P(1:floor(n/folds)*folds), :);
onefoldSize =floor(n/folds);

% ... partition the data matrix D
if i==1
    Xtrain = X(onefoldSize+1:end, :);
end
if i==folds
        Xtrain=X(1:onefoldSize*(folds-1), :);
end
if i<folds && i>1
        Xtrain = X(1:onefoldSize*(i-1), :);
        Xtrain=[Xtrain;X(onefoldSize*i+1:end, :)];
end
Xtest = X(onefoldSize*(i-1)+1:onefoldSize*i, :);

% ... create the desired matrices
%X = trainingSet(:, 1:n-1);
%Y = trainingSet(:, n);
%Y = 2*Y-1;
%Xtest = testSet(:, 1:n-1);
%Ytest = testSet(:, n);
%Ytest = 2*Ytest-1;

return
