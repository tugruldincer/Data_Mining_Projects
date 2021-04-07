%Suleyman_Tugrul_Dincer_2095354
%PART_I

data = readtable('Part1_Wisconsin Diagnostic Breast Cancer.xlsx');
%-----------------------------------------------------------%
% minData = min(Data(:));
% maxData = max(Data(:));
% scaled  = (Data - minData) / (maxData - minData);  % Scaled to [0, 1]
% scaled  = scaled * 2 - 1;  % Scaled to [-1, 1]
%-----------------------------------------------------------%
%shuffle and partitioning into train and validation
[m,n]=size(data); rng(3);
shdata = data(randperm(size(data,1)),:);
valid=shdata(1:(round(m*0.2)),:);
train=shdata(round(m*0.2)+1:m,:);
%----------------------------------------------------------%
yvalid=zeros(100,1); %I would be use size(valid,1) for k values, however it's already specified in the pdf.
ytrain=zeros(100,1);
for i=1:100
    Mdl = fitcknn(train,'Diagnosis','NumNeighbors',i);
    
    cmvalid = confusionmat(valid.Diagnosis,predict(Mdl,valid));
    errorvalid=(cmvalid(1,2)+cmvalid(2,1))/size(valid,1);
    yvalid(i)=errorvalid;
    
    cmtrain = confusionmat(train.Diagnosis,predict(Mdl,train));
    errortrain=(cmtrain(1,2)+cmtrain(2,1))/size(train,1);
    ytrain(i)=errortrain;
end
x=uint8(1:100);[M,I] = min(yvalid);
% plot(x,yvalid);hold on;plot(x,ytrain);
figure; hold on
a1 = plot(x,yvalid); M1 = 'Validation Curve';
a2 = plot(x,ytrain); M2 = 'Train Curve';
legend([a1;a2],M1,M2);
    
