% ****************************************
% Matlab Script File - pshnn.m
% PSHNN test on the Colorado Data Set
%
% $Id: pshnn.m,v 1.4 1997/09/29 21:01:58 jak Exp $
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
% Call backprop routine.
%
% set training parameters
disp_freq = 10;
max_epoch = 50;
err_goal = 0.02;
lr = 0.01;
lr_inc = 1.05;
lr_dec = 0.7;
err_ratio = 1.04;

TP = [disp_freq max_epoch err_goal lr lr_inc lr_dec err_ratio];
[W1,B1,W2,B2] = net_init(colorado_train_input, colorado_train_output, hidden_units);
[W1,B1,W2,B2,epoch,TR] = backprop(colorado_train_input, colorado_train_output, hidden_units, W1, B1, W2, B2, TP);

% ---------------------------------------
% Generate Confusion Matrix for Training Samples.
%

%
% Calculate Net Output
%
Y = purelin(W2 * tansig( W1 * colorado_train_input', B1),  B2);

%
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

%
% Obtain correct vs incorrect for each class
%
[confusion, percent_correct, total_percent_correct] = conf_mat(colorado_train_output',Yc, train_samples);

confusion
percent_correct
total_percent_correct

E = sum( abs( colorado_train_output' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn.m,v $
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


