% ****************************************
% Matlab Function - use_chen.m
% Use a PSHNN_CHEN Trained Function
%
% $Id: use_chen.m,v 1.1 1997/10/07 16:36:50 jak Exp $
%
% ****************************************

function [Yc, Y] = use_chen(I_samples, W1, B1, W2 )

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
        end
        Yc( max, i ) = 1;
    end

%endfunction

% --------------------------------
% History:
% $Log: use_chen.m,v $
% Revision 1.1  1997/10/07 16:36:50  jak
% Names were changed to fit in a DOS filesystem.  -jak
%
% Revision 1.2  1997/10/06 20:46:37  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 05:26:54  jak
% Added functions to calculate the various networks. -jak
%
%
