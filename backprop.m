% 
% Matlab Function - backprop.m
% Perform 2-layer Net Training
%
% $Id: backprop.m,v 1.1 1997/09/28 04:49:21 jak Exp $
%
% 

function [W1,B1,W2,B2,epoch,TR] = backprop(I_samples,O_samples,hidden_units,W1,B1,W2,B2,TP)

	% ---------------------------------------
	% Network Architecture Definitions
	%
	[isamples, channels] = size( I_samples );
	[osamples, classes ] = size( O_samples );
	if isamples == osamples 
		samples = isamples;
	else
		error('%dx%d -> %dx%d : Unequal amounts of input and output data!',\
			isamples, channels, osamples, classes);
	end
	
	% ---------------------------------------
	% Train the network.
	%	
	[W1,B1,W2,B2,epoch,TR] = ...
		trainbpa( W1, B1, 'tansig', ...
					W2, B2, 'purelin', ...
					I_samples' , ...
					O_samples' , ...
					TP ...
				);

endfunction

% --------------------------------
% History:
% $Log: backprop.m,v $
% Revision 1.1  1997/09/28 04:49:21  jak
% Broke some backprop things into their own files. -jak
%
%
