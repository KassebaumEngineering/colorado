% ****************************************
% Matlab Script File - colotest.m
% PSHNN test on the Colorado Data Set
%
% $Id: colotest.m,v 1.1 1997/09/30 05:26:04 jak Exp $
%
% ****************************************

% ---------------------------------------
% Read Training Data
%
load -force colo_trn.mat;

% ---------------------------------------
% Choose Basic Algorithm
%
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
	% Generate PSHNN Network
	%
	[W1, B1, W2, B2 ] = pshnn_bp(colorado_train_input, colorado_train_output, hidden_units);

    % ---------------------------------------
	% Get Output from PSHNN Network
	%
    [Yc, Y] = use_pshnn_bp(colorado_train_input, W1, B1, W2, B2 );

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

	% ---------------------------------------
	% Generate PSHNN Network
	%
	[W1, B1, W2 ] = pshnn_chen(colorado_train_input, colorado_train_output, hidden_units);

    % ---------------------------------------
	% Get Output from PSHNN Network
	%
    [Yc, Y] = use_pshnn_chen(colorado_train_input, W1, B1, W2 );

    end
end


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
    [Yc, Y] = use_pshnn_bp(colorado_test_input, W1, B1, W2, B2 );
   
else if choice == 2 	% Functional Link w/Random Perceptron Enhanced Nodes.
	% ---------------------------------------
	% Calculate Net Output
	%
    [Yc, Y] = use_pshnn_chen(colorado_test_input, W1, B1, W2 );
    
    end
end

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

% --------------------------------
% History:
% $Log: colotest.m,v $
% Revision 1.1  1997/09/30 05:26:04  jak
% Split up the programs a little more. -jak
%