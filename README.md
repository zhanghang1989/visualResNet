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
### Examples

<div style="text-align:center">
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/1.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/2.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/3.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/4.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/5.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/6.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/7.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/8.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/9.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/10.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/11.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/12.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/13.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/14.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/15.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/16.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/17.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/18.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/19.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/20.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/21.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/22.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/23.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/24.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/25.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/26.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/27.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/28.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/29.png" width="420" />
<img src ="https://github.com/zhanghang1989/visualResNet/raw/master/images/30.png" width="420" />
</div>
