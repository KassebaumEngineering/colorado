% ****************************************
% Matlab Script File - colotest.m
% PSHNN test on the Colorado Data Set
%
% $Id: colotest.m,v 1.5 1997/10/08 02:52:10 jak Exp $
%
% ****************************************

% ---------------------------------------
% Read Training Data
%
load colo_trn.mat;

% ---------------------------------------
% Choose Basic Algorithm
%
choice = menu('Which Learning Method would you like to use?', 'Adaptive BackPropagation Training', 'LMS Training');

if choice == 1      % Adaptive BackProp
    
    % ---------------------------------------
    % Obtain the size of the hidden layer
    %
    while (1)
        %fflush(stdout);
        hidden_units = input( 'Enter the number of hidden units: ');
        if isempty(hidden_units)
            continue;
        else
            break;
        end
    end

    % ---------------------------------------
    % Obtain the size of the hidden layer
    %
    while (1)
        %fflush(stdout);
        epochs = input( 'Enter the number of training epochs: ');
        if isempty(epochs)
            continue;
        else
            break;
        end
    end

    % ---------------------------------------
    % Generate PSHNN Network
    %
    [W1, B1, W2, B2 ] = pshnn_bp(colorado_train_input, colorado_train_output, hidden_units, epochs );

    % ---------------------------------------
    % Get Output from PSHNN Network
    %
    [Yc, Y] = use_bp(colorado_train_input, W1, B1, W2, B2 );

elseif choice == 2      % Functional Link w/Random Perceptron Enhanced Nodes.

    % ---------------------------------------
    % Choose the number of enhancement nodes
    %
    while (1)
        %fflush(stdout);
        hidden_units = input( 'Enter the number of random functions of inputs: ');
        if isempty(hidden_units)
            continue;
        else
            break;
        end
    end

    % ---------------------------------------
    % Generate PSHNN Network
    %
    [W1, B1, W2 ] = pshnn_ch(colorado_train_input, colorado_train_output, hidden_units, train_samples );

    % ---------------------------------------
    % Get Output from PSHNN Network
    %
    [Yc, Y] = use_chen(colorado_train_input, W1, B1, W2 );

end


% ---------------------------------------
% Generate Confusion Matrix for Training Samples.
%
[confusion_tr, percent_correct_tr, total_percent_correct_tr] = conf_mat(colorado_train_output',Yc, train_samples);
percent_correct_tr = percent_correct_tr';
%
% Print Results
%
stdout=2;
fprintf( stdout, '\n****************************************\n');
fprintf( stdout, 'Training Results: \n' );
confusion_tr
percent_correct_tr
total_percent_correct_tr

% ---------------------------------------
% Read Testing Data
%
load colo_tst.mat;

% ---------------------------------------
% Network Architecture Definitions
%
[isamples, channels] = size( colorado_test_input );
[osamples, classes ] = size( colorado_test_output );
if isamples == osamples 
    samples = isamples;
else
    error('%dx%d -> %dx%d : Unequal amounts of Testing input and output data!', isamples, channels, osamples, classes);
end

if choice == 1          % Adaptive BackProp
    % ---------------------------------------
    % Calculate Net Output
    %
    [Yc, Y] = use_bp(colorado_test_input, W1, B1, W2, B2 );
   
else if choice == 2     % Functional Link w/Random Perceptron Enhanced Nodes.
    % ---------------------------------------
    % Calculate Net Output
    %
    [Yc, Y] = use_chen(colorado_test_input, W1, B1, W2 );
    
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
fprintf( stdout, '\n****************************************\n');
fprintf( stdout, 'Testing Results: \n' );
confusion_te
percent_correct_te
total_percent_correct_te

saveit = menu('Save Network To a File?', 'Yes', 'No');
if saveit == 1      % Yes
    filename = input( 'Enter the filename: ', 0);
    filename = strcat( filename, '.mat' )
    if filename == '' 
        continue;
    else
        if choice == 1
            nettype = 'backprop';
            save -mat-binary _tmpfile nettype W1 B1 W2 B2;
            rename ('_tmpfile', filename);
        else
            nettype = 'chen_fln';
            save -mat-binary _tmpfile nettype W1 B1 W2;
            rename ('_tmpfile', filename);
        end
    end
end

% --------------------------------
% History:
% $Log: colotest.m,v $
% Revision 1.5  1997/10/08 02:52:10  jak
% Additions toward the full pshnn. -jak
%
% Revision 1.4  1997/10/07 17:33:42  jak
% ooops - I had en error in colotest.m, its fixed now. - jak
%
% Revision 1.3  1997/10/07 16:36:44  jak
% Names were changed to fit in a DOS filesystem.  -jak
%
% Revision 1.2  1997/10/06 20:46:24  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1  1997/09/30 05:26:04  jak
% Split up the programs a little more. -jak
%
