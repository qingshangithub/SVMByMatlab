function [outputArg] = kernel(inputArg1,inputArg2)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    %outputArg=dot(inputArg1,inputArg2);
    tmp=(inputArg1-inputArg2).^2;
    tmp=sum(tmp);
    outputArg = (10 * exp(0.1*tmp'./(-2)))';
end

