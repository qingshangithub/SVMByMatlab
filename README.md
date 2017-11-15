# SVMByMatlab

SVM算法的matlab实现。训练了两个数据集，分别是MNIST和CIFAR，

1. 数据库下载地址：
   1. mnist ： http://yann.lecun.com/exdb/mnist/	
   2. cifar10： https://www.kaggle.com/c/cifar-10/data
2. SVM_MNIST运行环境：将MNIST四个数据集文件加入文件夹内即可运行。

   1. 在matlab2017b环境下编写测试
   2. 默认运行1000训练数据200测试数据
   3. 准确率93%
   4. 运行时间约40秒

3. SVM_CIFAR运行环境：将CIFAR七个数据集文件加入文件夹内即可运行。
   1. 在matlab2017b环境下编写测试
   2. 默认训练1000个训练数据200个测试数据
   3. 时间300秒左右
4. smo算法参考了这个<http://blog.csdn.net/zeroQiaoba/article/details/78079635?locationNum=9&fps=1> 但是这个的实现比较简略，建议再看论文实现。

