% ****************************************
% Matlab Function - use_pshnn_chen.m
% Use a PSHNN_CHEN Trained Function
%
% $Id: use_pshnn_chen.m,v 1.1 1997/09/30 05:26:54 jak Exp $
%
% ****************************************

function [Yc, Y] = use_pshnn_chen(I_samples, W1, B1, W2 )

	% ---------------------------------------
	% Network Architecture Definitions
	%
	[samples, channels] = size( I_samples );

	% ---------------------------------------
	% Calculate Net Output
	%
	Y = W2 * [tansig( W1 * I_samples', B1)' , I_samples]';

	[ classes, samples ]  = size( Y );
	% ---------------------------------------
	% Assign Outputs to Classes
	%
	Yc = zeros( classes, samples );
	for i=1:samples 
		max = 1;
		for j=2:classes 
			if Y(j,i) > Y(max,i)
				max = j;
			end
		endfor
		Yc( max, i ) = 1;
	endfor

endfunction

% --------------------------------
% History:
% $Log: use_pshnn_chen.m,v $
% Revision 1.1  1997/09/30 05:26:54  jak
% Added functions to calculate the various networks. -jak
%
%