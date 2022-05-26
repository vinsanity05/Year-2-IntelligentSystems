function digit_recognition

% MY COMMENTS - VV:
% In this sceneario, we were tasked to make the noise level low. 
% To do this, i have changed the numbers of neurons in hidden layer from 12
% to 20. This was one of the changes, because beforehand the recognition
% error was around 25 - 30% when running the test without any changes. 
% When changing it now it has changed to 18% - 25%. Furthermore,
% I have also changed the performance rate from 0.001 to 0.0001. This also
% made it even lowever the noise level as it now has changed to 12%- 18%.
% Additionally, i have changed the learning rate from 0.1 to 2.07.  This
% also now has changed to 10% - 15%. To conclude I have also changed to
% noise range from 50 to 20. This made it even lower drastically as it now
% has no recognition error for the noise level or around 1% of recognition
% error for the noise level. 


disp(' =====================================')
disp(' Character recognition neural networks')
disp(' =====================================')

disp(' ============================================================================')
disp(' Reference: Negnevitsky, M., "Artificial Intelligence: A Guide to Intelligent')  
disp('            Systems", 3rd edn. Addison Wesley, Harlow, England, 2011.        ')
disp('            Sec. 9.4 Will a neural network work for my problem?              ')
disp(' ============================================================================')

disp(' ============================================================================')
disp(' Problem: A multilayer feedforward network is used for the recognition of    ')
disp('          digits from 0 to 9. Each digit is represented by a 5 x 9 bit map.  ')
disp(' ============================================================================')

disp(' Hit any key to visualise bit maps of the digits.')
disp(' ')
pause 

[digit1,digit2,digit3,digit4,digit5,digit6,digit7,digit8,digit9,digit0] = bit_maps;

disp(' Hit any key to obtain ten 45-element input vectors denoted by "p".') 
pause 

p=[digit1(:),digit2(:),digit3(:),digit4(:),digit5(:),digit6(:),digit7(:),digit8(:),digit9(:),digit0(:)]

disp(' Hit any key to define ten 10-element target vectors denoted by "t". ')
pause

t = eye(10)

disp(' Hit any key to define the network architecture.')
pause 

%s1=12; % Number of neurons in the hidden layer
s1=20; % Number of neurons in the hidden layer changed to this
s2=10; % Number of neurons in the output layer

disp(' ')
fprintf(1,' s1=%.0f;    Number of neurons in the hidden layer\n',s1);
fprintf(1,' s2=%.0f;    Number of neurons in the output layer\n',s2);
disp(' ')

disp(' Hit any key to create the network, initialise its weights and biases, ') 
disp(' and set up training parameters.')
pause 

net = newff(p,t,s1,{'logsig' 'purelin'},'traingdx');
net.divideFcn = '';

net.trainParam.show = 20;      % Number of epochs between showing the progress
net.trainParam.epochs = 1000;  % Maximum number of epochs
%net.trainParam.goal = 0.001;   % Performance goal
net.trainParam.goal = 0.0001;   % Performance goal changed to this
%net.trainParam.lr=0.1;         % Learning rate
net.trainParam.lr= 2.07;         % Learning rate changed to this


disp(' ')
fprintf(1,' net.trainParam.show=%.0f;        Number of epochs between showing the progress\n',net.trainParam.show);
fprintf(1,' net.trainParam.epochs=%.0f;    Maximum number of epochs\n',net.trainParam.epochs);
fprintf(1,' net.trainParam.goal=%.3f;     Performance goal\n',net.trainParam.goal);
fprintf(1,' net.trainParam.lr=%.2f;        Learning rate\n',net.trainParam.lr);
disp(' ')

disp(' Hit any key to train the back-propagation network.') 
pause 

disp(' ')
disp(' net = train(net,p,t)')
disp(' ')

net = train(net,p,t);

disp(' Hit any key to see how the network recognises a digit, for example digit 3.')
pause 

digit3
probe=digit3(:);
a=sim(net,probe);
disp(' a=sim(net,probe)')
a=round(a)
        
disp(' Hit any key to see how "noise" distorts the bit map of a digit, for example digit 5.')
disp(' ')
pause 

probe=digit5;
figure('name','"Noisy" bit maps')
subplot(1,2,1) 
probe_plot(probe)
title('Noise level: 0%')

disp(' Hit any key to continue.')
disp(' ')
pause

probe=digit5+randn(size(probe))*0.1;
subplot(1,2,2) 
probe_plot(probe)
title('Noise level: 10%')

disp(' Hit any key to continue.')
disp(' ')
pause

probe=digit5+randn(size(probe))*0.2;
figure('name','"Noisy" bit maps')
subplot(1,2,1)
probe_plot(probe)
title('Noise level: 20%')

disp(' Hit any key to continue.')
disp(' ')
pause

probe=digit5+randn(size(probe))*0.5;
subplot(1,2,2) 
probe_plot(probe)
title('Noise level: 50%')

disp(' Hit any key to evaluate the digit recognition neural network.')
disp(' ')
pause 

% Set parameters for the test.
%noise_range = 0:.05:.50;  % Range of noise
noise_range = 0:.05:.20;  % Range of noise changed to this 
max_test = 100;           % Number of test examples for each digit to be recognised
average_error = [];       % Average recognition error for a particular noise level 

% Evaluate the digit recognition network.
for noise_level=noise_range
   error=0;

  for i=1:max_test
    probe=p+randn(size(p))*noise_level;
    a=compet(sim(net,probe));
    error=error+sum(sum(abs(a-t)))/2;
  end
  
  average_error = [average_error error/10/max_test];
  fprintf('Noise level: %.0f percent; Average error: %.0f percent\n',noise_level*100,error/10/max_test*100);
end

disp(' ')
disp(' Hit any key to plot the test results.')
disp(' ')
pause

h = figure;

plot(noise_range*100,average_error*100,'b-');
title('Performance of the digit recognition network')
xlabel('Noise level, %');
ylabel('Recognition error, %');

disp(' ')
disp(' Hit any key to train the digit recognition network with "noisy" examples.')
disp(' ')
pause

net.trainParam.epochs = 1000;   % Maximum number of epochs to train.

t_noise = [t t t t];
for pass = 1:10
  fprintf('Pass = %.0f\n',pass);
  p_noise=[p p (p+randn(size(p))*0.1) (p+randn(size(p))*0.2)];
  net= train(net,p_noise,t_noise);
end

disp(' Hit any key to evaluate the digit recognition network trained with "noisy" examples.')
disp(' ')
pause 

average_error = []; 

for noise_level = noise_range
   error = 0;

  for i=1:max_test
    probe=p+randn(size(p))*noise_level;
    a=compet(sim(net,probe));
    error=error+sum(sum(abs(a-t)))/2;
  end
  
  average_error = [average_error error/10/max_test];
  fprintf('Noise level: %.0f percent; Average error: %.0f percent\n',noise_level*100,error/10/max_test*100);
end

disp(' ')
disp(' Hit any key to plot the test results.')
disp(' ')
pause

figure(h)
hold on
plot(noise_range*100,average_error*100,'r-');
legend('Network trained with "perfect" examples','Network trained with "noisy" examples','Location', 'Northwest');

%legend('Best','Average',0);
%legend('Best','Average','Location', 'South') ;


hold off

disp('end of digit_recognition')

function probe_plot(probe);

[m n]=size(probe);
probe_plot=[probe probe(:,[n])]';
probe_plot=[probe_plot probe_plot(:,[m])]';
pcolor(probe_plot)
colormap(gray)
axis('ij')
axis image