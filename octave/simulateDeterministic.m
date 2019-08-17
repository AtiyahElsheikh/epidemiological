%%
%%  This program implements the solution of a system of stochastic differential equation for infectious disease. 
%%  The epidemiological model comes from the simple ODE system: 
%%
%%  	dS/dt = - beta * S * I / N 
%%      dI/dt = beta * S * I / N - sigma * I  
%%  	dR/dt = sigma * I 
%%
%%  [S,I,R,time] = simulateDeterministic(beta=10.0,sigma=1.0,S0=999,I0=1,R0=0,finalTime=5.0,dt=0.01) 
%% 
%%	Inputs:
%%		beta, sigma 	: model parameters 
%%		S0,I0,R0		: start values
%%		finalTime		: final simulation time
%%		dt				: step size 
%%
%%	Outputs:
%%		S,I,R			: simulation results in matrix of size D x NSim where 
%%							D = finalTime/dt + 1 
%%		time			: simulation time points 
%%  
%% 


function [S,I,R,time] = simulateDeterministic(beta=10.0,sigma=1.0,S0=999,I0=1,R0=0,finalTime=5.0,dt=0.01)

	%%
	% global variables 
	% 
	
	global glo_beta; global glo_sigma; global glo_N; 
	
	%%
	% Check validty of inputs 
	% 
		
	assertInputsConsistency(beta,sigma,S0,I0,R0,finalTime,dt);
	
	%% 
	% Initialization of help variables  
	% 
	
	N = S0 + I0 + R0; % population size 
	time = linspace(0,finalTime,finalTime/dt+1)';     
	
	glo_beta = beta; glo_sigma = sigma; glo_N = N; 
	
	x = lsode("f",[S0,I0,R0],time);
	S = x(:,1);
	I = x(:,2);
	R = x(:,3); 


	function  xdot = f(x,t) 
		global glo_beta; global glo_sigma; global glo_N; 
		
		xdot = zeros(3,1); 
		
		xdot(1) = -glo_beta * x(1) * x(2) / glo_N; 
		%xdot(2) = glo_beta * x(1) * x(2) / glo_N - glo_sigma * x(2);  
		xdot(3) = glo_sigma * x(2); 
		xdot(2) = -xdot(1)-xdot(3); 
		