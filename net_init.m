
% 
% Matlab Function - net_init.m
% Perform 2-layer Net Training
%
% $Id: net_init.m,v 1.2 1997/10/06 20:46:26 jak Exp $
%
% 

function [W1,B1,W2,B2] = net_init(I_samples,O_samples,hidden_units) 

    % ---------------------------------------
    % Network Architecture Definitions
    %
    [isamples, channels] = size( I_samples );
    [osamples, classes ] = size( O_samples );
    if isamples == osamples 
        samples = isamples;
    else
        error('%dx%d -> %dx%d : Unequal amounts of input and output data!',isamples, channels, osamples, classes);
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
    W2 = rands(classes,hidden_units)*0.5; 
    B2 = rands(classes,1)*0.5;

%endfunction

% --------------------------------
% History:
% $Log: net_init.m,v $
% Revision 1.2  1997/10/06 20:46:26  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/28 04:49:24  jak
% Broke some backprop things into their own files. -jak
%
%
