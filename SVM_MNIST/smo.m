function [alpha,bias] = smo(training,trainlabel,C,maxIter,tol)
% init
[num,~]=size(training);
alpha=zeros(num,1);
bias=0;
iteratorTimes=0;
%making kernal
K = zeros (num);
for i = 1:num
    for j = i:num
        K(i, j) = kernel(training(i,:), training(j,:));
    end
end
while iteratorTimes<maxIter
    alphaPairsChanged=0;
    % find alpha1
    for i=1:num
        g1=(alpha.*trainlabel)'*K(:,i)+bias;
        E1=g1-trainlabel(i,1);
       % choose i: avoid KKT conditions
       if(((E1*trainlabel(i,1)<-tol)&&alpha(i,1)<C)||((E1*trainlabel(i,1)>tol)&&alpha(i,1)>0))
           % choose j: different from i 
           j=i;
           while j==i
                j=randi(num);
           end

            alpha1=i;
            alpha2=j;
            % update alpha1 and alpha2
            alpha1Old=alpha(alpha1,1);
            alpha2Old=alpha(alpha2,1);
            y1=trainlabel(alpha1,1);
            y2=trainlabel(alpha2,1);

            g2=(alpha.*trainlabel)'*K(:,j)+bias;
            E2=g2-trainlabel(j,1);

            if y1~=y2
                L=max(0,alpha2Old-alpha1Old);
                H=min(C,C+alpha2Old-alpha1Old);
            else
                L=max(0,alpha2Old+alpha1Old-C);
                H=min(C,alpha2Old+alpha1Old);
            end

            if L==H
                %fprintf('H==L\n');
                continue;
            end

            parameter=K(alpha1,alpha1)+K(alpha2,alpha2)-2*K(alpha1,alpha2);

            if parameter<=0
               % fprintf('parameter<=0\n');
                continue;
            end

            alpha2New=alpha2Old+y2*(E1-E2)/parameter;

            if alpha2New>H
                alpha2New=H;
            end

            if alpha2New<L
                alpha2New=L;
            end

            if abs(alpha2New-alpha2Old)<=0.0001
                %fprintf('change small\n');
                continue;
            end

            alpha1New=alpha1Old+y1*y2*(alpha2Old-alpha2New);

            % updata bias
            bias1=-E1-y1*K(alpha1,alpha1)*(alpha1New-alpha1Old)-y2*K(alpha2,alpha1)*(alpha2New-alpha2Old)+bias;
            bias2=-E2-y1*K(alpha1,alpha2)*(alpha1New-alpha1Old)-y2*K(alpha2,alpha2)*(alpha2New-alpha2Old)+bias;

            if alpha1New>0&&alpha1New<C
                bias=bias1;
            elseif alpha2New>0&&alpha2New<C
                bias=bias2;
            else
                bias=(bias2+bias1)/2;
            end

            alpha(alpha1,1)=alpha1New;
            alpha(alpha2,1)=alpha2New;
            alphaPairsChanged=alphaPairsChanged+1;
       end  
    end

    if alphaPairsChanged~=0
        iteratorTimes=iteratorTimes+1;
   
    end
    %fprintf('iteratorTimes=%d\n',iteratorTimes);

end