
% 
% Matlab Function - nodeinit.m
% Initialize 1st layer of Net
%
% $Id: nodeinit.m,v 1.3 1997/10/08 02:52:10 jak Exp $
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
        fprintf( 2, '%dx%d -> %dx%d :', isamples, channels, osamples, classes );
	error('Unequal amounts of input and output data!');
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
    end
    MaM(r,1)=min;
    MaM(r,2)=max;
    end
    [W1,B1] = nwtan(hidden_units,channels,MaM);

%endfunction

% --------------------------------
% History:
% $Log: nodeinit.m,v $
% Revision 1.3  1997/10/08 02:52:10  jak
% Additions toward the full pshnn. -jak
%
% Revision 1.2  1997/10/06 20:46:28  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 00:00:22  jak
% Moved Chen's Functional Link Net to another file.
% Also added reults for the testing data set. -jak
%
%
