% ****************************************
% Matlab Function - pshnn_bp.m
% PSHNN Function
%
% $Id: pshnn_bp.m,v 1.1 1997/09/30 05:26:08 jak Exp $
%
% ****************************************

function [W1, B1, W2, B2] = pshnn_bp(I_samples, O_samples, hidden_units)

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
	
	% ---------------------------------------
	% Adaptive BackProp
    %
	disp_freq = 10;
	max_epoch = 50;
	err_goal = 0.02;
	lr = 0.01;
	lr_inc = 1.05;
	lr_dec = 0.7;
	err_ratio = 1.04;
	
	TP = [disp_freq max_epoch err_goal lr lr_inc lr_dec err_ratio];
	[W1,B1,W2,B2] = net_init(I_samples, O_samples, hidden_units);
	[W1,B1,W2,B2,epoch,TR] = backprop(I_samples, O_samples, hidden_units, W1, B1, W2, B2, TP);

endfunction

% E = sum( abs( O_samples' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn_bp.m,v $
% Revision 1.1  1997/09/30 05:26:08  jak
% Split up the programs a little more. -jak
%
% Revision 1.5  1997/09/30 00:00:23  jak
% Moved Chen's Functional Link Net to another file.
% Also added reults for the testing data set. -jak
%
% Revision 1.4  1997/09/29 21:01:58  jak
% Moved the confusion matrix to a seperate function. -jak
%
% Revision 1.3  1997/09/28 04:49:25  jak
% Broke some backprop things into their own files. -jak
%
% Revision 1.2  1997/09/27 18:59:21  jak
% Fixed the Id - oops. -jak
%
% Revision 1.1.1.1  1997/09/27 18:57:14  jak
% First commit of the colorado data set in matlab. -jak
%
%


