% ****************************************
% Matlab Function - pshnn_ch.m
% PSHNN Function using Chen's 
% Functional Link Network
%
% $Id: pshnn_ch.m,v 1.1 1997/10/07 16:36:46 jak Exp $
%
% ****************************************

function [ W1, B1, W2 ] = pshnn_ch(I_samples, O_samples, hidden_units)

    % ---------------------------------------
    % Network Architecture Definitions
    %
    [isamples, channels] = size( I_samples );
    [osamples, classes ] = size( O_samples );
    if isamples == osamples 
    samples = isamples;
    else
    error('%dx%d -> %dx%d : Unequal amounts of Training input and output data!', isamples, channels, osamples, classes);
    end
    
    % ---------------------------------------
    % Train Functional Link w/Random Perceptron Enhanced Nodes.
    %
    [ W1, B1, W2 ] = chen_fln(I_samples, O_samples, hidden_units);

    % ---------------------------------------
    % Select classes with low probability of being classified correctly.
    %


%endfunction

% E = sum( abs( O_samples' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn_ch.m,v $
% Revision 1.1  1997/10/07 16:36:46  jak
% Names were changed to fit in a DOS filesystem.  -jak
%
% Revision 1.2  1997/10/06 20:46:30  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 05:26:11  jak
% Split up the programs a little more. -jak
%
%
