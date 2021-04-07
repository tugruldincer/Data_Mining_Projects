# KNN Algorithms Approaches
Different KNN algorithms are designed for data mining course.

There is a dataset which is related to patients’ cancer situation with 10 different features, and class part for diagnosis. ‘1’ is used for diagnosing the disease, and ‘0’ is used for vice versa. Through the homework, I used the seed function as rng(3).

**fitcknn**

A build-in function as fitcknn of Matlab is used. Steps of the code is as follows:*
a)	Dataset is shuffled by using randperm function, then it is separated into two groups as train and validation data. The partition is in the form of 80% for train set and 20% for validation set.

b)	For the distance measure Euclidean distance is used.

c)	There is no cross-validation for this assignment.

d)	To predict validation classes, 100 different knn values are used from 1 to 100.

e)	By using plot function we can observe how error differentiate values by changing knn values.

f)  Optimal knn=41 and error rate is chosen as 0.0614

**fuzzyknn, r_radius_neighbour implementation**

I came up with my own KNN function as fuzzyknn and rnearest knn.
a) I implemented fuzzy algorithm with Euclidean distance. I coded fuzzyknn function in another script, then called it to the main script to see the results of different knn value.
b) After classifying validation and train dataset, error rates are coming up with following plot. In that plot, Minimum error rate for validation data is 0.0351, and the optimal knn value for that error rate is 23.
c) When r-Radius Neighbours KNN Algorithm is implemented, optimal r value is chosen as 0.4, and the corresponding error rate is as 7%. For this purpose, I coded rnearest function in another script and called it to the main script to see the results of different knn values.
