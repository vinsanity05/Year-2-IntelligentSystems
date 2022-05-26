% ==========================
% Filename: Perceptron_XOR_VV.m
% ==========================
%
% Two witnesses that I Vince Verdadero (id 19009246) considered, ran and examined the output of the code.  
%   Demonstrated to Lean Bernardo (student id 18017803) Tuesday 23rd February 2021 
%   Demonstrated to George Gao (student id 18043234) Tuesday 23rd February
%   2021
%
%   My comments:
%   Throughout this program, we can not show a correct output in a 2D
%   perceptron without using a MLP or a 3d perceptron. 
%   What i did was, I decided to create 3D vectors to show the two separate lines.
%   For instance, I changed p=[0 0 1 1;0 1 0 1] to p=[0 0 1 1;0 1 0 1;0 0 0 1]
%   Also i changed the  plot the input and target vectors.
%   For example I changed v=[-2 3 -2 3]; to v=[-2 3 -2 3 -2 3];
%   Aswell, I also created a perceptron that works with the 3D.
%   For example: net=newp([0 1;0 1],1); turns into net=newp([0 1;0 1;0 1],1);
%   Furthermore, I changed the random seed to 3. This is because we are working on a 3D
%   plane.
%   As well the for loop has changed to a while loop.
%   Finally, I decided to change the testing if it gives what we wanted
%   to.
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
echo on;
%
%
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

%p=[0 0 1 1;0 1 0 1]
p=[0 0 1 1;0 1 0 1;0 0 0 1] % I decided to create 3D vectors to show the two separate lines

% Hit any key to define four 1-element target vectors denoted by "t". 
pause 

t=[0 1 1 0]

% Hit any key to plot the input and target vectors.

%v=[-2 3 -2 3];
v=[-2 3 -2 3 -2 3];

plotpv(p,t,v);

% Hit any key to create the perceptron and set its initial weights to random 
% numbers in the range [0, 1]. The perceptron's threshold is set to zero.
pause

%net=newp([0 1;0 1],1);
net=newp([0 1;0 1;0 1],1); %creates a 3d perceptron

w=(rands(3))'; % changed the rands to 3 because we are creating a 3d plane
b=[0];
net.IW{1,1}=w;
net.b{1}=b;

plotpv(p,t,v);
linehandle=plotpc(net.IW{1},net.b{1});

% Hit any key to train the perceptron for one pass and plot the classification line. 
% The training will be stoped after 10 passes.
pause

%for a=1:10;
 %  [net,Y,E]=adapt(net,p,t);
  % linehandle=plotpc(net.IW{1},net.b{1},linehandle);
   %pause
%end;

E=1;
  while (sse(E))
     [net,Y,E]=adapt(net,p,t);
     linehandle=plotpc(net.IW{1},net.b{1},linehandle);
     pause
  end;

% Hit any key to see that the perceptron has not learned the XOR operation.
pause

%p=[1;1]
%a=sim(net,p)

p=[1;1;1]
a=sim(net,p)

% Hit any key to continue.
pause

%p=[0;1]
%a=sim(net,p)

p=[0;1;0]
a=sim(net,p)

% Hit any key to continue.
pause

%p=[1;0]
%a=sim(net,p)

p=[1;0;0]
a=sim(net,p)

% Hit any key to continue.
pause

%p=[0;0]
%a=sim(net,p)

p=[0;0;0]
a=sim(net,p)
   
echo off
disp('end of Perceptron_XOR')