% ===================
% Filename: Iris_bp.m
% ===================

% MY COMMENTS VV:
% In this task, the goal is to get to total iris plant recognition error
% low
% As i run it, the total iris plant recognition error starts of with 9.43 
% To experiment to get the error lower i have changed the following: 
% I have changed the number of epochs from 1000 to 10000, this gave me
% the total iris plant recognition error of 6.82. 
% I have also changed the number of neurons in the hidden layer from 15 to 10, 
% this made the  total iris plant recognition error around range from 4.5 -
% 2.22
%From what I experienced when running it at the beginning when opening a
%file again it prints me off at around 9.06 - 9.43 but running it afterwards after that
%again it gives me around 4.5 - 2.22 



echo  off

disp(' =====================================================')
disp(' Iris plant classification: back-propagation algorithm')
disp(' =====================================================')

disp(' ============================================================================')
disp(' Reference: Negnevitsky, M., "Artificial Intelligence: A Guide to Intelligent')  
disp('            Systems", 3rd edn. Addison Wesley, Harlow, England, 2011.        ')
disp('            Sec. 9.4 Will a neural network work for my problem?              ')
disp(' ============================================================================')

disp(' ===================================================================================')
disp(' Problem: The Iris plant data set contains 3 classes, and each class is represented ')
disp('          by 50 plants. A plant is characterised by its sepal length, sepal width,  ')
disp('          petal length and petal width. A three-layer back-propagation network is   ') 
disp('          required to classify Iris plants.                                         ') 
disp(' ===================================================================================')

[iris_data] = Iris_data;
iris_data = (iris_data(:,[1:4]))';

% Massaged values for the Iris plant data set

for n=1:4;
    iris_inputs(n,:)=(iris_data(n,:)-min(iris_data(n,:)))/...
        (max(iris_data(n,:)-min(iris_data(n,:))));
end
           
iris_target1 = [1 0 0]'; setosa=find(iris_target1);
iris_target2 = [0 1 0]'; versicolor=find(iris_target2);
iris_target3 = [0 0 1]'; verginica=find(iris_target3);

for n=1:(50-1)
   iris_target1=[iris_target1 iris_target1(:,1)]
   iris_target2=[iris_target2 iris_target2(:,1)];
   iris_target3=[iris_target3 iris_target3(:,1)];
end

iris_targets = [iris_target1 iris_target2 iris_target3];

disp('Hit any key to randomly select input vectors to be used in training.') 
disp(' ')
pause

p=[]; t=[]; test_p=[]; test_t=[];

for n=1:150
   if rand(1)>1/3
      p=[p iris_inputs(:,n)];
      t=[t iris_targets(:,n)];
   else
      test_p=[test_p iris_inputs(:,n)];
      test_t=[test_t iris_targets(:,n)];
   end
end

[m n]=size(test_p);

disp(' ')
fprintf(1,' The training data set contains %.0f elements.\n',(150-n));
fprintf(1,' The test data set contains %.0f elements.\n',n);
disp(' ')

echo on

% Hit any key to define the network architecture. 
pause 

%s1=15; % Five neurons in the hidden layer
s1=10; % Neuron changed to this in the hidden layer
s2=3; % Three neuron in the output layer

% Hit any key to create the network, initialise its weights and biases, 
% and set up training parameters.
pause 

rand('seed',1243);

net = newff(p,t,s1,{'logsig' 'purelin'},'traingdx');
net.divideFcn = '';

net.trainParam.show=20;      % Number of epochs between showing the progress
%net.trainParam.epochs=1000;  % Maximum number of epochs
net.trainParam.epochs=10000;  % Maximum number of epochs to this 
net.trainParam.goal=0.001;   % Performance goal
net.trainParam.lr=0.1;       % Learning rate
net.trainParam.lr_inc=1.05;  % Learning rate increase multiplier
net.trainParam.lr_dec=0.7;   % Learning rate decrease multiplier
net.trainParam.mc=0.9;       % Momentum constant

% Hit any key to train the back-propagation network. 
pause 

[net,tr]=train(net,p,t);

% Hit any key to plot the training errors and learning rates. 
pause 

figure
subplot(2,1,1), plot(tr.epoch,tr.perf)
tstring = sprintf('Training for %g epochs',max(tr.epoch));
title(tstring);
xlabel ('Epoch'); ylabel('Sum-squared error');
subplot(2,1,2), plot(tr.epoch,tr.lr)
xlabel ('Epoch'); ylabel('Learning rate');

echo off

disp(' ')
fprintf(1,' Iris-setosa is represented by output:      %.0f \n',setosa);
fprintf(1,' Iris-versicolor is represented by output:  %.0f \n',versicolor);
fprintf(1,' Iris-verginica is represented by output:   %.0f \n',verginica);

disp(' ')
disp(' Hit any key to test the network using the test data set.')
disp(' ')
pause 

n_setosa=0; n_versicolor=0; n_verginica=0;
error_setosa=0; error_versicolor=0; error_verginica=0; error=0;

fprintf(' Sepal length  Sepal width  Petal length  Petal width  Desired output   Actual output  Error\n');

for i=1:n
   fprintf('     %.1f           %.1f          %.1f           %.1f',test_p(1,i),test_p(2,i),test_p(3,i),test_p(4,i));
   a=compet(sim(net,test_p(:,i))); a=find(a);
   b=compet(test_t(:,i)); b=find(b);
   if b==1
      n_setosa=n_setosa+1;
      fprintf('      Iris-setosa            ');
      if abs(a-b)>0
         error_setosa=error_setosa+1;
         fprintf('%.0f        Yes\n',a);
      else
         fprintf('%.0f        No\n',a);
      end
   elseif b==2
      n_versicolor=n_versicolor+1;
      fprintf('      Iris-versicolor        ');
      if abs(a-b)>0
         error_versicolor=error_versicolor+1;
         fprintf('%.0f        Yes\n',a);
      else
         fprintf('%.0f        No\n',a);
      end
   else
      n_verginica=n_verginica+1;
      fprintf('      Iris-verginica         ');
      if abs(a-b)>0
         error_verginica=error_verginica+1;
         fprintf('%.0f        Yes\n',a);
      else
         fprintf('%.0f        No\n',a);
      end      
   end
end
      
error=(error_setosa+error_versicolor+error_verginica)/n*100;

error_setosa=error_setosa/n_setosa*100;
error_versicolor=error_versicolor/n_versicolor*100;
error_verginica=error_verginica/n_verginica*100;

fprintf(1,' \n')
fprintf(1,' Iris-setosa recognition error:      %.2f \n',error_setosa);
fprintf(1,' Iris-versicolor recognition error:  %.2f \n',error_versicolor);
fprintf(1,' Iris-verginica recognition error:   %.2f \n',error_verginica);
fprintf(1,' \n')
fprintf(1,' Total Iris plant recognition error: %.2f \n',error);
fprintf(1,' \n')

disp('end of Iris_bp.m')
