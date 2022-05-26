% ==========================
% Filename: Perceptron_XOR.m
% ==========================
% VV My comments: 
% VV I noticed that when running the program Perceptron_XOR, it performs activities such as: 
% VV Identifying the problem,  
% VV Creating a perceptron, 
% VV Get the perceptron to learn the program,
% VV Showing and testing the outcome of the perceptron 
% Throughout this script briefly my expectations after running Perceptron_XOR program was that it
% would create two separate lines however it only showed a single line and
% didn't really complete its task. Further expectations will be shown down
% below through the script. 


echo on ;
%
%
%
% ====================================================================
% The perceptron: an attempt to learn linearly non-separable functions
% ====================================================================

% ============================================================================
% Reference: Negnevitsky, M., "Artificial Intelligence: A Guide to Intelligent  
%            Systems", 3rd edn. Addison Wesley, Harlow, England, 2011.
%            Sec. 6.3 The perceptron
% ============================================================================

% ===========================================================================
% Problem: Two-input perceptron is required to perform logical operation XOR.
% ===========================================================================

% Hit any key to define four 2-element input vectors denoted by "p". 
pause 

p=[0 0 1 1;0 1 0 1]

% Hit any key to define four 1-element target vectors denoted by "t". 
pause 

t=[0 1 1 0]

% Hit any key to plot the input and target vectors.
v=[-2 3 -2 3];

plotpv(p,t,v);

% Hit any key to create the perceptron and set its initial weights to random 
% numbers in the range [0, 1]. The perceptron's threshold is set to zero.
pause

%VV Here I would expect that this part is creating the Perceptron 

net=newp([0 1;0 1],1);
w=(rands(2))';
b=[0];
net.IW{1,1}=w;
net.b{1}=b;

plotpv(p,t,v);
linehandle=plotpc(net.IW{1},net.b{1});

% Hit any key to train the perceptron for one pass and plot the classification line. 
% The training will be stoped after 10 passes.
pause

%VV Here I would expect that we are training the perceptron and I would expect
%VV that this should be different to Perceptron OR because the XOR is a for loop.
%VV i will also would expect that that it would create two separate lines 
%VV however it only showed a single line after 10 interations and did not complete the task. 

for a=1:10;
   [net,Y,E]=adapt(net,p,t);
   linehandle=plotpc(net.IW{1},net.b{1},linehandle);
   pause
end;

% Hit any key to see that the perceptron has not learned the XOR operation.
pause

%VV In this part, i would expect that once we trained it, we are testing it if it gives what we wanted to. 
%VV In the 1st test I expect that this this 1st test should be correct 1,1
%and ending up with 0 - However, it ended as 1
%VV In the 2nd test I would expect that this should be correct 0,1 to be true and returns as 1  
%VV In the 3rd test I would expect that this should be correct 1,0 to be
%true and returns as 1
%VV In the last test I would expect that this should be 0,0 to be 0 but when running it came out with 1 

p=[1;1]
a=sim(net,p)

% Hit any key to continue.
pause

p=[0;1]
a=sim(net,p)

% Hit any key to continue.
pause

p=[1;0]
a=sim(net,p)

% Hit any key to continue.
pause

p=[0;0]
a=sim(net,p)
   
echo off
disp('end of Perceptron_XOR')