function GA_1

%MY COMMENTS - Vince Verdadero
%Firstly my task is to ensure GA_1 'makes no progress' whilst executing properly. 
%Where 'makes no progress' implies that the system does not produce an optimal solution.
% To do this, I tried experimenting and changing the number of genes in a
% chromosome. I have changed the number 4 to 1. So only 1 is the number of
% genes. The result of this, is that the number of the red dots have not
% been moved and haven't reached to the top/middle of the graph. Although for the performance graph the
% fitness does drop from range 7- 11 and then makes no progress after when the
% number of generations happen after the 1st one. 
%I tried experimenting this more, So what i changed was the mutation
%probability from 0.010 to 1.0. This also made the same graph when the
%number of generations were generated. However, when the performance graph
%showed, this made a better execution to show that it does not make no
%progress, the y is always 2.33333 and does not move and stays in a
%contstant line. Although this only happens because it randomly generated
%but the fitness level will only be ranges to 7 - 2 and then makes no progress. 


disp('=============================================================')
disp('Genetic algorithms: the fitness function of a single variable')
disp('=============================================================')

disp('============================================================================')
disp('Reference: Negnevitsky, M., "Artificial Intelligence: A Guide to Intelligent')  
disp('           Systems", 3rd edn. Addison Wesley, Harlow, England, 2011.        ')
disp('           Sec. 7.3 Genetic algorithms                                      ')
disp('============================================================================')

disp('=============================================================================')
disp('Problem: It is desired to find the maximum value of the function (15*x - x*x)')
disp('         where parameter "x" varies between 0 and 15. Assume that "x" takes  ')
disp('         only integer values.                                                ')
disp('=============================================================================')

disp('Hit any key to define the objective function.') 
pause

ObjFun='15*x -x.*x';

disp(' ')
disp('ObjFun=15*x -x.*x')
disp(' ')

disp('Hit any key to define the size of a chromosome population, the number of genes') 
disp('in a chromosome, the crossover probability, the mutation probability, possible') 
disp('minimum and maximum values of parameter "x", and the number of generations.') 
pause 

nind=6;    % Size of a chromosome population
%ngenes=4; % Number of genes in a chromosome
ngenes=1;  % Number of genes in a chromosome changed to this
Pc=0.9;    % Crossover probability
%Pm=0.010; % Mutation probability
Pm=1.0;    % Mutation probability changed to this 
xmin=0;    % Possible minimum value of parameter "x" 
xmax=15;   % Possible maximum value of parameter "x" 
ngener=20; % Number of generations

disp(' ')
fprintf(1,'nind=%.0f;      Size of a chromosome population\n',nind);
fprintf(1,'ngenes=%.0f;    Number of genes in a chromosome\n',ngenes);
fprintf(1,'Pc=%.1f;      Crossover probability\n',Pc);
fprintf(1,'Pm=%.3f;    Mutation probability\n',Pm);
fprintf(1,'xmin=%.0f;      Possible minimum value of parameter "x"\n',xmin);
fprintf(1,'xmax=%.0f;     Possible maximum value of parameter "x"\n',xmax);
fprintf(1,'ngener=%.0f;   Number of generations\n',ngener);
disp(' ')

fprintf(1,'Hit any key to generate a population of %.0f chromosomes.\n',nind);
pause

chrom=round(rand(nind,ngenes))

disp('Hit any key to obtain decoded integers from the chromosome strings.')
pause

x=chrom*[2.^(ngenes-1:-1:0)]'

% Calculation of the chromosome fitness
ObjV=evalObjFun(ObjFun,x);
best(1)=max(ObjV);
ave(1)=mean(ObjV);

disp('Hit any key to display initial locations of the chromosomes on the objective function.')
pause

figure('name','Chromosome locations on the objective function');
%
% PDR
%fplot(ObjFun,[xmin,xmax])
fplot(@(x)15.*x-x.*x,[xmin,xmax])
%
hold;
plot(x,ObjV,'r.','markersize',15)
%
% PDR
%legend(['The objective function: ',ObjFun],'Initial chromosome population',4);
legend(['The objective function: ',ObjFun],'Initial chromosome population','Location', 'South');
% 
title('Hit any key to continue');
xlabel('Parameter "x"');
ylabel('Chromosome fitness');
hold;

disp(' ')
disp('Hit any key to run the genetic algorithm.')
pause

for i=1:ngener,
   
   % Fitness evaluation
   fitness=ObjV;
   if min(ObjV)<0
      fitness=fitness-min(ObjV);
   end
   
   % Roulette wheel selection
   numsel=round(nind*0.9); % The number of chromosomes to be selected for reproduction
   cumfit=repmat(cumsum(fitness),1,numsel);
   chance=repmat(rand(1,numsel),nind,1)*cumfit(nind,1);
   [selind,j]=find(chance < cumfit & chance >= [zeros(1,numsel);cumfit(1:nind-1,:)]);
   newchrom=chrom(selind,:);

   % Crossover 
   points=round(rand(floor(numsel/2),1).*(ngenes-2))+1;
   points=points.*(rand(floor(numsel/2),1)<Pc);   
   for j=1:length(points),
      if points(j),
         newchrom(2*j-1:2*j,:)=[newchrom(2*j-1:2*j,1:points(j)),...
               flipud(newchrom(2*j-1:2*j,points(j)+1:ngenes))];
      end
   end
   
   % Mutation
   mut=find(rand(numsel,ngenes)<Pm);
   newchrom(mut)=round(rand(length(mut),1));
   
   % Fitness calculation
     newx=newchrom*[2.^(ngenes-1:-1:0)]';

% for ngenes=2, set xmax=3 here 
   %
   % pdr
   %newx=xmin+(newx+1)*(xmax-xmin)/(2^ngenes-1);
      newx=xmin+(newx)*(xmax-xmin)/(2^ngenes-1);
    %
 
newObjV=evalObjFun(ObjFun,newx) ;
   
% for ngenes=2, set xmax=15 here 

   
  
   % Creating a new population of chromosomes
   if nind-numsel, % Preserving a part of the parent chromosome population
      [ans,Index]=sort(fitness);
      chrom=[chrom(Index(numsel+1:nind),:);newchrom];
      x=[x(Index(numsel+1:nind));newx];
      ObjV=[ObjV(Index(numsel+1:nind));newObjV];      
   else % Replacing the entire parent chromosome population with a new one
      chrom=newchrom;
      x=newx;
      ObjV=newObjV;
   end
   
   % Plotting current locations of the chromosomes on the objective function
   %
   % PDR
   % fplot(ObjFun,[xmin,xmax])
    fplot(@(x)15.*x-x.*x,[xmin,xmax])
   %
   hold;
	plot(x,ObjV,'r.','markersize',15)
    %
    % PDR
    %   legend(['The objective function: ',ObjFun],'Current chromosome population',4);
   legend(['The objective function: ',ObjFun],'Current chromosome population','Location', 'South');
   % 
   %
   title(['Generation # ',num2str(i)]);
   xlabel('Parameter "x"');
   ylabel('Chromosome fitness');
   pause(0.2)
   hold; 

   best(1+i)=max(ObjV);
   ave(1+i)=mean(ObjV);
end

disp(' ')
disp('Hit any key to display the performance graph.')
pause

figure('name','Performance graph');
plot(0:ngener,best,0:ngener,ave);
%
% PDR
%legend('Best','Average',0);
legend('Best','Average','Location', 'South');
%
title(['Pc = ',num2str(Pc),', Pm = ',num2str(Pm)]);
xlabel('Generations');
ylabel('Fitness')

function y=evalObjFun(ObjFun,x)
y=eval(ObjFun);

