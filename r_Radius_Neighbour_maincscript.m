data = readtable('Part1_Wisconsin Diagnostic Breast Cancer.xlsx');
%----------------------------------------------------------------%
data=table2array(data);
[m,n]=size(data);
for x=1:n-1
    minData = min(data(:,x));
    maxData = max(data(:,x));
    data(:,x)  = (data(:,x)-minData) / (maxData - minData);  % Scaled to [0, 1]
end
%----------------------------------------------------------------%
rng(3);
shdata = data(randperm(size(data,1)),:);
valid=shdata(1:(round(m*0.2)),:);
train=shdata(round(m*0.2)+1:m,:);
a=train; b=valid;t=1;
error1=zeros(20,1);error2=zeros(20,1);
validclass=valid(:,n);
trainclass=train(:,n);
correct=0;wrong=0;
for r=0.1:0.1:2
    result=rnearest(a,b,r,n);
    for i=1:length(validclass)
        if result(i)==validclass(i)
            correct=correct+1;
        else
            wrong=wrong+1;
        end
    end
    error1(t)=wrong/size(valid,1);
    correct=0;wrong=0;t=t+1;
end
t=1;
for r=0.1:0.1:2
    result = rnearest(a,a,r,n);
    for i=1:length(trainclass)
        if result(i)==trainclass(i)
            correct=correct+1;
        else
            wrong=wrong+1;
        end
    end
    error2(t)=wrong/size(train,1);
    correct=0;wrong=0;t=t+1;
end
x=0.1:0.1:2; [M,I]=min(error1);
% plot(x,error1);hold on;plot(x,error2);
figure; hold on
a1 = plot(x,error1); M1 = 'Validation Curve';
a2 = plot(x,error2); M2 = 'Train Curve';
legend([a1;a2],M1,M2);

