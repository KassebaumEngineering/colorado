
% 
% Matlab Function - nodeinit.m
% Initialize 1st layer of Net
%
% $Id: nodeinit.m,v 1.1 1997/09/30 00:00:22 jak Exp $
%
% 

function [W1,B1] = nodeinit(I_samples,O_samples,hidden_units) 

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
	% Initialize weights and biases.
	% Use Random Nguyen-Widrow Values
	%
	MaM = zeros(channels,2);
	for r= 1:channels
		min = I_samples(1, r);
		max = I_samples(1, r);
		for i= 2:samples
			if  I_samples(i, r) > max
				max = I_samples(i, r);
			end
			if  I_samples(i, r) < min
				min = I_samples(i, r);
			end
		endfor
		MaM(r,1)=min;
		MaM(r,2)=max;
	endfor
	[W1,B1] = nwtan(hidden_units,channels,MaM);

endfunction

% --------------------------------
% History:
% $Log: nodeinit.m,v $
% Revision 1.1  1997/09/30 00:00:22  jak
% Moved Chen's Functional Link Net to another file.
% Also added reults for the testing data set. -jak
%
%
