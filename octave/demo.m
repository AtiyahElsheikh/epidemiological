%%
%% A demo showing how to use the implemented routines  
%% 


%%
%  add the folder containing the built-in statistical distribution routines to the path variable
% adjust the path to your octave installation folder and remove the comment of the following line 

% addpath('C:\path\to\octave\share\octave\packages\statistics-1.4.0\distributions


%%
%  simulation parameters 
% 

beta = 10; sigma = 1;      % model parameters 
S0 = 999; I0 = 1; R0 = 1;  % Initial values 
finalTime=5.0;             % end simulation time 
dt=0.01;				   % step size 	
NSim=10;				   % number of stochastic simulations 

%%
%  determinstic simulation 
% 

[SD,ID,RD,timeD] = simulateDeterministic(beta,sigma,S0,I0,R0,finalTime,dt); 

plot(timeD,ID);
title('determinstic simulation of ID'); 
xlabel('time'); ylabel('I');

%% 
% stochastic simulation 
% 

[SS,IS,RS,timeS] = simulateStochastic(beta,sigma,S0,I0,R0,finalTime,dt,NSim);
 
figure(); 

plot(timeS,IS);
title('stochastic simulation of ID'); 
xlabel('time'); ylabel('I'); 

%%
% comparing both simulation against each other 
% 

 [errI,SD,Sbar,ID,Ibar,RD,Rbar,time] = validateSimulation(beta,sigma,S0,I0,R0,finalTime,dt,NSim); 
 
 figure(); 
 plot(time,ID,"*;I Determinstic;",time,Ibar,"o;I Stochastic;");
 title('Determistic vs. stochastic simulation of ID'); 
 xlabel('time'); ylabel('I');
 
 
