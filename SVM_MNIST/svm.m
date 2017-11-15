clc
trainImages=loadMNISTImages('train-images.idx3-ubyte'); 
trainLabels=loadMNISTLabels('train-labels.idx1-ubyte');
testImages = loadMNISTImages('t10k-images.idx3-ubyte');  
testLabels = loadMNISTLabels('t10k-labels.idx1-ubyte');
trainnum=1000;
trainImages=trainImages(:,1:trainnum);
trainImages=trainImages';
trainLabels=trainLabels+1;
trainLabels=trainLabels(1:trainnum);
testLabels=testLabels+1;
testImages =testImages';
N=200;
errornum=0;
labelResult=zeros(1,N);

%binarization
 %trainImages(trainImages>0)=1;
 %testImages(testImages>0)=1;
C = 100;tol = 0.001;
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
        [alpha(i,:),bias(i)] = smo(trainPoints, xx, C, tol);
end
toc
tmp=zeros(1,10);
for k=1:N
    for i=1:10
             hhh=(repmat(testImages(k,:),[trainnum,1]))';
             hh=kernel(trainPoints',hhh);
%             tmp=(pointLabels'.*hh)*alpha+bias;
            x1=alpha(i,:);
            x2=pointLabels(i,:);
            x3=bias(i);
            tmp(1,i)=hh*(x1.*x2)'+x3;
    end
    [maxValue,labelResult(k)]=max(tmp);
    if labelResult(k)~=testLabels(k)
        errornum=errornum+1;
    end
end
accuracy=1-errornum/N;
disp(accuracy);

