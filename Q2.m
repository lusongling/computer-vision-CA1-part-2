clear;
clc;
imgA=im2double(imread('texture2\A.png'));
imgB=im2double(imread('texture2\B.png'));
w=input('w=');
[img]=patchmatch(imgA,imgB,w);