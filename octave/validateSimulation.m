%%
%% validate the stochastic simulation against the determintic simulation 
%% The deterministic soluation is theoretically the average of a large number 
%% of stochastic simulations 
%% 
%%	Inputs:
%%		beta, sigma 	: model parameters 
%%		S0,I0,R0		: start values
%%		finalTime		: final simulation time
%%		dt				: step size
%%		NSim			: number of simulations 
%%
%%	Outputs:
%%		errorI			: the norm of the difference between stochastic and deterministic solution of I  
%%		SD,ID,RD		: simulation results of the deterministic model  
%%		Sbar,Ibar,Rbar	: average of the stochastic simulations 
%%		time			: simulation time points 
%%  
%% 

function [errorI,SD,Sbar,ID,Ibar,RD,Rbar,time] = validateSimulation(beta=10,sigma=1,S0=999,I0=1,R0=0,finalTime=5.0,dt=0.01,NSim=100) 

	[SD,ID,RD,time] = simulateDeterministic(beta,sigma,S0,I0,R0,finalTime,dt); 
	
	[S,I,R,time] = simulateStochastic(beta,sigma,S0,I0,R0,finalTime,dt,NSim);

	Sbar = mean(S')'; 
    Ibar = mean(I')'; 
	Rbar = mean(R')'; 
	
	errorI = 0; 
	for k = 1:length(ID) 
		errorI += abs(Ibar(k)-ID(k))*dt ; 
	end
	
	
	

	


