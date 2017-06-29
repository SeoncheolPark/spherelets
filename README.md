# LOCU
Main function.
Input: Data matrix $X$.
Output: the best tuning parameters, label of each data, the corresponding spheres, figure of test data, figure of projected data, figure of projected data in colors, figure of log #pieces vs log MSE.

# locquad
For each combination of tuning parameters, find the label, spherelets and MSE so that the best parameters could be obtained by cross validation.
Input:training set, test set, tuning parameters.
Output:projected data, label of test data, spheres, MSE of test data.


# fit
Fit current data by the best sphere (section 3 in the paper).
Input: data set.
Output: the best sphere, MSE.

# distance
Find the spherical divergence (definition 5 in section 4).
Input: two data sets and tuning parameters.
Output: the spherical divergence between the two sets.

# split
Split the data into clusters, where the data in one single cluster could be fit by some sphere (algorithm 1/ step 2, section 5).
Input: data, tuning parameters.
Output: label.

# mergeclusters
Merge clusters (step 3/ algorithm 2 in section 5).
Input: data, label, tuning parameters.
Output: label.

# Serror
Calculate the MSE.
Input: test data, label, spheres.
Output: MSE, labels of test data, projected data.

# nn
Find the nearest neighbor of certain point.
Input: current point, label.
Output: the nearest unlabeled point.


# splitdata
Split data set into trainig set and test set.
Input: data set X.
Output: Xtrain, Xtest.


# poscurvature
Fit the data by the best sphere.
Input: data set.
Output: the best sphere.

# zerocurvature
(Turn out to be useless)Fit the data by the best hyperplane.
Input: data set.
Output: the best hyperplane.

# negcurvature
(Turn out to be useless)Fit the data by the best hyperbolic space.
Input: data set.
Output: the best hyperbolic space.
