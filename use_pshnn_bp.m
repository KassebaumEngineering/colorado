% ****************************************
% Matlab Function - use_pshnn_bp.m
% Use a PSHNN_BP Trained Function
%
% $Id: use_pshnn_bp.m,v 1.1 1997/09/30 05:26:52 jak Exp $
%
% ****************************************

function [Yc, Y] = use_pshnn_bp(I_samples, W1, B1, W2, B2)

	% ---------------------------------------
	% Network Architecture Definitions
	%
	[samples, channels] = size( I_samples );
	
	% ---------------------------------------
	% Calculate Net Output
	%
	Y = purelin(W2 * tansig( W1 * I_samples', B1),  B2);
		
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
% $Log: use_pshnn_bp.m,v $
% Revision 1.1  1997/09/30 05:26:52  jak
% Added functions to calculate the various networks. -jak
%
