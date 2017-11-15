clc
testData =load('test_batch.mat');
trainData1=load('data_batch_1.mat');
trainData2=load('data_batch_2.mat');
trainData3=load('data_batch_3.mat');
trainData4=load('data_batch_4.mat');
trainData5=load('data_batch_5.mat');
trainImages=double([trainData1.data;trainData2.data;trainData3.data;trainData4.data;trainData5.data]');
trainLabels=double([trainData1.labels;trainData2.labels;trainData3.labels;trainData4.labels;trainData5.labels]);
testImages=double(testData.data');
testLabels=double(testData.labels);
threshhold=119;
%trainImages(trainImages<=threshhold) = 0;
%trainImages(trainImages>threshhold) = 1;
%label +1 
trainLabels = trainLabels+1;
testLabels= testLabels+1;
%testImages(testImages<=threshhold) = 0;
%testImages(testImages>threshhold) = 1;
trainnum=1000;
trainImages=trainImages(:,1:trainnum);
trainImages=trainImages';
trainLabels=trainLabels(1:trainnum);
testImages =testImages';
N=200;
errornum=0;
labelResult=zeros(1,N);

%binarization
% trainImages=trainImages>0;
% testImages=testImages>0;
C = 10;tol = 0.001;
tic
bias=zeros(1,10);
idxx=zeros(10);
for w=1:10
    idxx(w)=length(find(trainLabels==w));
end
alpha=zeros(10,trainnum);
pointLabels=zeros(10,trainnum);
for i=1:10
        idxi=find(trainLabels==i);
        pointLabels(i,idxi(:))=1;
        idxj=find(trainLabels~=i);
        pointLabels(i,idxj(:))=-1;
        trainPoints=trainImages;
        xx=pointLabels(i,:)';
        [alpha(i,:),bias(i)] = smo(trainPoints, xx, C,10, tol);
end
toc
tmp=zeros(1,10);
for k=1:N
    for i=1:10
             hhh=(repmat(testImages(k,:),[trainnum,1]))';
             hh=kernel(trainPoints',hhh);
            x1=alpha(i,:);
            x2=pointLabels(i,:);
            x3=bias(i);
            x4=(x1.*x2)';
            tmp(1,i)=hh*(x1.*x2)'+x3;
    end
    [maxValue,labelResult(k)]=max(tmp);
    if labelResult(k)~=testLabels(k)
        errornum=errornum+1;
    end
end
accuracy=1-errornum/N;
disp(accuracy);

