
% 
% Matlab Function - chen_fln.m
% Perform Training of Enhanced Funtional Link Net
%
% $Id: chen_fln.m,v 1.2 1997/10/06 20:46:14 jak Exp $
%
% 

function [ W1, B1, W2 ] = chen_fln(I_samples,O_samples,hidden_units)

    % ---------------------------------------
    % Generate Enhancement Functions of Inputs.
    %
    [W1, B1] = nodeinit( I_samples, O_samples, hidden_units);
    H = [tansig( W1 * I_samples', B1)' , I_samples];

    HtH = H' * H;
    HtB = H' * O_samples ;
    [U S V] = svd( HtH );
    [d1,d2] = size( S );
    Sinv = zeros( d1, d1 );
    for i=1: d1
        if S(i,i) == 0.0
            Sinv(i,i) = 0;
        else
            Sinv(i,i) = 1.0 / S(i,i);
        end
    end
    W2 = ((V * Sinv) * (U' * HtB))';
    
%endfunction

% --------------------------------
% History:
% $Log: chen_fln.m,v $
% Revision 1.2  1997/10/06 20:46:14  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 00:00:21  jak
% Moved Chen's Functional Link Net to another file.
% Also added reults for the testing data set. -jak
%
%
