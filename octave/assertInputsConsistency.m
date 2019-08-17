%%
%% check whether input parameters of the simulation models are consistent
%% 
%% function assertInputConsistency(beta,sigma,S0,I0,R0,finalTime,dt)
%% 
%% Inputs:
%%		beta, sigma 	: model parameters 
%%		S0,I0,R0		: start values
%%		finalTime		: final simulation time
%%		dt				: step size 

 function assertInputsConsistency(beta,sigma,S0,I0,R0,finalTime,dt)

	assert(finalTime > 0 , ' finalTime negative');
	assert(dt > 0 && dt < finalTime , 'invalid value for dt'); 
	assert(finalTime/dt - floor(finalTime/dt) < 1e-5 , 'finalTime/dt should result in an integer number');
	
	assert(S0 >  0 , 'S0 should be more than 0');  
	assert(I0 >= 0 , 'I0 should not be negative');
	assert(R0 >= 0 , 'R0 should not be negative'); 
	
	assert(floor(S0) == S0 && ~isinf(S0) , 'S0 should be an integer '); 
	assert(floor(I0) == I0 && ~isinf(I0) , 'I0 should be an integer '); 
	assert(floor(R0) == R0 && ~isinf(R0) , 'R0 should be an integer '); 