% ****************************************
% Matlab Script File - pshnn.m
% PSHNN test on the Colorado Data Set
%
% $Id: pshnn.m,v 1.5 1997/09/30 00:00:23 jak Exp $
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
    error('%dx%d -> %dx%d : Unequal amounts of Training input and output data!',\
        isamples, channels, osamples, classes);
end

choice = menu("Which Learning Method would you like to use?",
              "2-Layer Perceptron with Linear Outputs - Adaptive BackPropagation Training",
              "Random Perceptron Enhanced Functional Link Network - LMS Training"
             );

if choice == 1 		% Adaptive BackProp
	
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
	% Calculate Net Output
	%
	Y = purelin(W2 * tansig( W1 * colorado_train_input', B1),  B2);

else if choice == 2		% Functional Link w/Random Perceptron Enhanced Nodes.
	% ---------------------------------------
	% Choose the number of enhancement nodes
	%
	while (1)
		fflush(stdout);
		hidden_units = input( 'Enter the number of random functions of inputs: ');
		if hidden_units == [] 
			continue;
		else
			break;
		end
	endwhile

    [W1, B1, W2 ] = chen_fln(colorado_train_input, colorado_train_output, hidden_units);

	% ---------------------------------------
	% Calculate Net Output
	%
	Y = W2 * [tansig( W1 * colorado_train_input', B1)' , colorado_train_input]';

    end
end

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
	endfor
	Yc( max, i ) = 1;
endfor

% ---------------------------------------
% Generate Confusion Matrix for Training Samples.
%
[confusion_tr, percent_correct_tr, total_percent_correct_tr] = conf_mat(colorado_train_output',Yc, train_samples);
percent_correct_tr = percent_correct_tr';
%
% Print Results
%
fprintf( stdout, "\n****************************************\n");
fprintf( stdout, "Training Results: \n" );
confusion_tr
percent_correct_tr
total_percent_correct_tr

% ---------------------------------------
% Read Testing Data
%
load -force colo_tst.mat;

% ---------------------------------------
% Network Architecture Definitions
%
[isamples, channels] = size( colorado_test_input );
[osamples, classes ] = size( colorado_test_output );
if isamples == osamples 
	samples = isamples;
else
    error('%dx%d -> %dx%d : Unequal amounts of Testing input and output data!',\
        isamples, channels, osamples, classes);
end

if choice == 1 			% Adaptive BackProp
 	% ---------------------------------------
	% Calculate Net Output
	%
	Y = purelin(W2 * tansig( W1 * colorado_test_input', B1),  B2);
   
else if choice == 2 	% Functional Link w/Random Perceptron Enhanced Nodes.
	% ---------------------------------------
	% Calculate Net Output
	%
	Y = W2 * [tansig( W1 * colorado_test_input', B1)' , colorado_test_input]';
    
    end
end

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
	endfor
	Yc( max, i ) = 1;
endfor

% ---------------------------------------
% Generate Confusion Matrix for Training Samples.
%
[confusion_te, percent_correct_te, total_percent_correct_te] = conf_mat(colorado_test_output',Yc, test_samples);
percent_correct_te = percent_correct_te';

%
% Print Results
%
fprintf( stdout, "\n****************************************\n");
fprintf( stdout, "Testing Results: \n" );
confusion_te
percent_correct_te
total_percent_correct_te

saveit = menu("Save Network To a File?",
              "Yes",
              "No"
             );
if saveit == 1		% Yes
	filename = input( 'Enter the filename: ', 0);
    filename = strcat( filename, ".mat" )
	if filename == '' 
		continue;
	else
        if choice == 1
            nettype = "backprop";
		    save -mat-binary _tmpfile nettype W1 B1 W2 B2;
            rename ("_tmpfile", filename);
        else
            nettype = "chen_fln";
		    save -mat-binary _tmpfile nettype W1 B1 W2;
            rename ("_tmpfile", filename);
        end
	end
end

% E = sum( abs( colorado_train_output' - Yc )/2 );

% --------------------------------
% History:
% $Log: pshnn.m,v $
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


