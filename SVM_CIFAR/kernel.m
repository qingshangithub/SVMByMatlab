function [outputArg] = kernel(inputArg1,inputArg2)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    %outputArg=dot(inputArg1,inputArg2);
    tmp=(inputArg1-inputArg2).^2;
    tmp=sum(tmp);
    outputArg = ( 10*exp(0.00000058*tmp'./(-2)))';
end

