clc
clear all
close all
warning off
Fs=8000;
ch=1;
datatype='uint8';
nbits=16;
Nseconds=5;

recorder=audiorecorder(Fs,nbits,ch);
disp('start speaking..')

recordblocking(recorder,Nseconds);
disp('end of recording');

x=getaudiodata(recorder,datatype);

audiowrite('test.wav',x,Fs);