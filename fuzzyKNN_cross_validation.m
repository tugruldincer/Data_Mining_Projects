%Suleyman_Tugrul_Dincer_2095354
%PART_I_5-fold cross_validation
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
x=round(m*0.2);
for i=1:5
    if i~=5
        valid{i}=shdata(((i-1)*x+1):i*x,:);
        I=transpose(((i-1)*x+1):i*x);
        b=shdata;
        b(I,:)=[];
        train{i}=b;
    else
        valid{i}=shdata(((i-1)*x+1):m,:);
        I=transpose(((i-1)*x+1):m);b=shdata;b(I,:)=[];
        train{i}=b;
    end
end
error=zeros(5,1);optimal=zeros(50,1);
for knn=1:50
    for i=1:5
        validclass=valid{i};
        validclass=validclass(:,n);
        result = fuzzyknn(train{i},valid{i},knn,n);
        cm=confusionmat(result,validclass);
        e=(cm(2,1)+cm(1,2))/size(result,1);        
        error(i)=e;        
    end
    optimal(knn)=mean(error);
end
plot(1:50,optimal);
[Y,I]=min(optimal);
hold on
plot(I,optimal(I),'r*');xlabel('K-Nearest Neighbour');ylabel('Error Rate');
title('K-value vs Error Rate');

%----------------------------------------------------------------------%
% clear all
% data = readtable('Part1_Wisconsin Diagnostic Breast Cancer.xlsx');
% data=table2array(data);
% [m,n]=size(data);
% for x=1:n-1
%     minData = min(data(:,x));
%     maxData = max(data(:,x));
%     data(:,x)  = (data(:,x)-minData) / (maxData - minData);  % Scaled to [0, 1]
% end
% rng(10);
% shdata = data(randperm(size(data,1)),:);
% x=round(m*0.2);
% for i=1:5
%     if i~=5
%         valid{i}=shdata(((i-1)*x+1):i*x,:);
%         I=transpose(((i-1)*x+1):i*x);
%         b=shdata;
%         b(I,:)=[];
%         train{i}=b;
%     else
%         valid{i}=shdata(((i-1)*x+1):m,:);
%         I=transpose(((i-1)*x+1):m);b=shdata;b(I,:)=[];
%         train{i}=b;
%     end
% end
% error1=zeros(50,1);error2=zeros(50,1);
% optimal=zeros(5,2);
% for i=1:5
%     validclass=valid{i};
%     validclass=validclass(:,n);
%     for knn=1:50
%         result = fuzzyknn(train{i},valid{i},knn,n);
%         cm=confusionmat(result,validclass);
%         error1(knn)=(cm(2,1)+cm(1,2))/size(result,1);
%     end
%     [Y,I]=min(error1);
%     optimal(i,1)=Y;optimal(i,2)=I;
%     subplot(5,1,i);
%     plot(1:50,error1);
%     hold on
%     plot(I,error1(I),'r*');
%     title(sprintf('%i-th fold',i));
% end

