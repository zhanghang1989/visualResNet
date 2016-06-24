## visualResNet
Curious about where is the ResNet looking at? This repo visualizes the class specific saliency map or discriminative location. 
It is MatConvNet re-implementation of [Learning Deep Features for Discriminative Localization, Bolei Zhou et. al.](http://arxiv.org/abs/1512.04150), 
but without modifying the network or re-training. We look directly through the ResNet to see the world.


### Get Started

- The code relies on [vlfeat](http://www.vlfeat.org/), and [matconvnet](http://www.vlfeat.org/matconvnet/), which should be downloaded and built before running the experiments. You can use the following commend to download them.
```sh
git clone --recurse-submodules https://github.com/zhanghang1989/visualResNet.git
```
If you have problem with compiling, please refer to the [link](http://zhanghang1989.github.io/ResNet/#compiling-vlfeat-and-matconvnet).	

- Run the progrem form Matlab:
```matlab
demo
```
