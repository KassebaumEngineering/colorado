% ****************************************
% Matlab Function - pshnn_chen.m
% PSHNN Function using Chen's 
% Functional Link Network
%
% $Id: pshnn_chen.m,v 1.1 1997/09/30 05:26:11 jak Exp $
%
% ****************************************

function [ W1, B1, W2 ] = pshnn_chen(I_samples, O_samples, hidden_units)

	% ---------------------------------------
	% Network Architecture Definitions
	%
	[isamples, channels] = size( I_samples );
	[osamples, classes ] = size( O_samples );
	if isamples == osamples 
		samples = isamples;
	else
		error('%dx%d -> %dx%d : Unequal amounts of Training input and output data!',\
			isamples, channels, osamples, classes);
	end
	
	% Functional Link w/Random Perceptron Enhanced Nodes.

	[ W1, B1, W2 ] = chen_fln(I_samples, O_samples, hidden_units);

endfunction

% E = sum( abs( O_samples' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn_chen.m,v $
% Revision 1.1  1997/09/30 05:26:11  jak
% Split up the programs a little more. -jak
%
%
