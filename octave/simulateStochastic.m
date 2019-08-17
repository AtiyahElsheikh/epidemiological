%%
%%  This program implements the solution of a system of stochastic differential equation for infectious disease. 
%%  The epidemiological model comes from the simple ODE system: 
%%
%%  	dS/dt = - beta * S * I / N 
%%      dI/dt = beta * S * I / N - sigma * I  
%%  	dR/dt = sigma * I 
%%
%%  Coefficients of the model are taken from bionomial distribution. 
%%
%%  [S,I,R,time] = simulateStochastic(beta=10,sigma=1,S0=999,I0=1,R0=0,finalTime=5.0,dt=0.01,NSim=1) 
%% 
%%	Inputs:
%%		beta, sigma 	: model parameters 
%%		S0,I0,R0		: start values
%%		finalTime		: final simulation time
%%		dt				: step size
%%		NSim			: number of simulations 
%%
%%	Outputs:
%%		S,I,R			: simulation results in matrix of size D x NSim where 
%%							D = finalTime/dt + 1 
%%		time			: simulation time points 
%%  
%% 

function [S,I,R,time] = simulateStochastic(beta=10,sigma=1,S0=999,I0=1,R0=0,finalTime=5.0,dt=0.01,NSim=1) 
	
	%%
	% Check validty of inputs 
	% 
		
	assertInputsConsistency(beta,sigma,S0,I0,R0,finalTime,dt);
	
	%% 
	% Initialization of help variables  
	% 
	
	N = S0 + I0 + R0; % population size 
	time = linspace(0,finalTime,finalTime/dt+1)';     
	
	D    = ceil(finalTime / dt) + 1; % Dimension of output vectors
	S    = zeros(D,NSim); 
	I    = zeros(D,NSim); 
	R    = zeros(D,NSim); 
	
	iter = 1;   % first iteration 
	S(iter,:) = S0; I(iter,:) = I0; R(iter,:) = R0; 
	iter += 1; 
	
	%% 
	%  main loop 
	% 
	
	while(iter <= D) 
		dI = binornd( S(iter-1,:) , beta * I(iter-1,:) / N * dt , 1 , NSim); 
		dR = binornd( I(iter-1,:) , sigma * dt , 1 , NSim);
		S(iter,:) = S(iter-1,:) - dI;   
		I(iter,:) = I(iter-1,:) + dI - dR;  
		R(iter,:) = R(iter-1,:) + dR;  
		iter += 1; 
	end 


	
		