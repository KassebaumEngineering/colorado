% ****************************************
% Matlab Function - pshnn_ch.m
% PSHNN Function using Chen's 
% Functional Link Network
%
% $Id: pshnn_ch.m,v 1.2 1997/10/08 02:52:11 jak Exp $
%
% ****************************************

function [ W1, B1, W2 ] = pshnn_ch(I_samples, O_samples, hidden_units, class_samples)

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
    % Get Output from PSHNN Network
    %
    [Yc, Y] = use_chen(I_samples, W1, B1, W2 );

    % ---------------------------------------
    % Select classes with low probability of being classified correctly.
    %
    [confusion, percent_correct, total_percent_correct] = conf_mat(O_samples',Yc, class_samples);

    % ---------------------------------------
    % Build Reject List
    %
    reject_output = zeros( 2, samples );
        %
        % reject_output( 1, : ) -> accept = 1, reject = 0 (Accept)
        % reject_output( 2, : ) -> accept = 0, reject = 1 (Reject)
        %
    reject_samples = zeros( 1, 2 );
    for i=1:10,
        if percent_correct(i) < 50.0   % reject
            for k=1:samples,
                if O_samples(k,i) == 1
                    reject_output(2,k) = 1;
                    reject_samples(1,2) = reject_samples(1,2) + 1;
                end
            end
        else    % accept
            for k=1:samples,
                if O_samples(k,i) == 1
                    reject_output(1,k) = 1;
                    reject_samples(1,1)= reject_samples(1,1) + 1;
                end
            end
        end
    end

    % ---------------------------------------
    % Build Pre-Rejector
    %

    % ---------------------------------------
    % Train Functional Link w/Random Perceptron Enhanced Nodes.
    %
    [ PreW1, PreB1, PreW2 ] = chen_fln(I_samples, reject_output', hidden_units);

    % ---------------------------------------
    % Get Output from PSHNN Network
    %
    [PreYc, PreY] = use_chen(I_samples, PreW1, PreB1, PreW2 );

    [PreConf, Pre_percent_correct, Pre_total_percent_correct] = conf_mat(reject_output,PreYc, reject_samples)

%endfunction

% E = sum( abs( O_samples' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn_ch.m,v $
% Revision 1.2  1997/10/08 02:52:11  jak
% Additions toward the full pshnn. -jak
%
%
% pshnn_chen.m:
% Revision 1.3  1997/10/07 16:36:46  jak
% Names were changed to fit in a DOS filesystem.  -jak
%
% Revision 1.2  1997/10/06 20:46:30  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 05:26:11  jak
% Split up the programs a little more. -jak
%
%
