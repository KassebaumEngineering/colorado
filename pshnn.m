% ****************************************
% Matlab Script File - pshnn.m
% PSHNN test on the Colorado Data Set
%
% %Id$
%
% ****************************************

% ---------------------------------------
% Read Training Data
%
load -force colo_trn.mat;

% ---------------------------------------
% Network Architecture Definitions
%
[isamples, channels] = size( colorado_train_input );
[osamples, classes ] = size( colorado_train_output );
if isamples == osamples 
	samples = isamples;
else
    error('%dx%d -> %dx%d : Unequal amounts of input and output data!',\
        isamples, channels, osamples, classes);
end

% ---------------------------------------
% Obtain the size of the hidden layer
%
while (1)
    fflush(stdout);
    hidden_units = input( 'Enter the number of hidden units: ');
    if hidden_units == [] 
        continue;
    else
        break;
    end
endwhile

% ---------------------------------------
% Initialize weights and biases.
% Use Random Nguyen-Widrow Values
%
[W10,B10] = nwtan(hidden_units,channels);
W20 = rands(classes,hidden_units)*0.5; 
B20 = rands(classes,1)*0.5;

% ---------------------------------------
% Train the network.
%
 
% set training parameters
disp_freq = 10;
max_epoch = 8000;
err_goal = 0.02;
lr = 0.01;
lr_inc = 1.05;
lr_dec = 0.7;
err_ratio = 1.04;

TP = [disp_freq max_epoch err_goal lr lr_inc lr_dec err_ratio];

% perform training
[W1,B1,W2,B2,epoch,TR] = ...
    trainbpa( W10, B10, 'tansig', ...
              W20, B20, 'purelin', ...
              colorado_train_input' , ...
              colorado_train_output' , ...
              TP ...
            );

% ---------------------------------------
%
%

% --------------------------------
% History:
% $Log: pshnn.m,v $
% Revision 1.1  1997/09/27 18:57:14  jak
% Initial revision
%
%


