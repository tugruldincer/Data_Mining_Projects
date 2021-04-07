%Suleyman_Tugrul_Dincer_2095354
%PART_II_FuzzyKNN
clear all
data = readtable('Part1_Wisconsin Diagnostic Breast Cancer.xlsx');
data=table2array(data);
[m,n]=size(data);
for x=1:n-1
    minData = min(data(:,x));
    maxData = max(data(:,x));
    data(:,x)  = (data(:,x)-minData) / (maxData - minData);  % Scaled to [0, 1]
end
rng(10);
shdata = data(randperm(size(data,1)),:);
valid=shdata(1:(round(m*0.2)),:);
train=shdata(round(m*0.2)+1:m,:);
error1=zeros(50,1);error2=zeros(50,1);
validclass=valid(:,n);
trainclass=train(:,n);

for knn=1:50
    result = fuzzyknn(train,valid,knn,n);
        cm=confusionmat(result,validclass);
        error1(knn)=(cm(2,1)+cm(1,2))/size(result,1);
end

for knn=1:50
    result = fuzzyknn(train,train,knn,n);
    cm=confusionmat(result,trainclass);
    error2(knn)=(cm(2,1)+cm(1,2))/size(result,1);
end
[Y,I]=min(error1);
figure; hold on
a1 = plot(1:50,error1); M1 = 'Validation Curve';
a2 = plot(1:50,error2); M2 = 'Train Curve';
legend([a1;a2],M1,M2);