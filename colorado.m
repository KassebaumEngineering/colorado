
%
% Matlab Script to generate input and output data 
% for colorado data set.
%
% Uses Files:
%      trn_inp.m,  trn_cls.m   - for training data
%     test_inp.m, test_cls.m   - for testing data
%
% $Id: colorado.m,v 1.2 1997/10/06 20:46:23 jak Exp $
%


% ------------------------------------------------------------
% read in the colorado data set - training and test samples
%
trn_inp      % colorado_train_input
trn_cls      % colorado_train_classes
test_inp     % colorado_test_input
test_cls     % colorado_test_classes

number_of_test_cases = length(colorado_test_classes);
number_of_training_cases = length(colorado_train_classes);

% ------------------------------------------------------------
% generate an appropriate output representaion for the training data
%
colorado_train_output = zeros( number_of_training_cases, 10 );
for i = 1:number_of_training_cases
    colorado_train_output( i, colorado_train_classes(i) ) = 1 ;
end

% ------------------------------------------------------------
% generate an appropriate output representaion for the testing data
%
colorado_test_output = zeros( number_of_test_cases, 10 );
for i = 1:number_of_test_cases
    colorado_test_output( i, colorado_test_classes(i) ) = 1 ;
end

% ------------------------------------------------------------
% count the test samples by class
%
test_samples = [0,0,0,0,0,0,0,0,0,0];
for i = 1:number_of_test_cases
    test_samples( colorado_test_classes(i) ) = test_samples( colorado_test_classes(i)) + 1;
end

% ------------------------------------------------------------
% establish test sample class assignments by index
%
test_cases = [0,0,0,0,0,0,0,0,0,0];
test_cases(1) = test_samples(1);
for i = 2:10
    test_cases( i ) = test_samples( i ) + test_cases( i-1 ) ;
end

% ------------------------------------------------------------
% test data - probability of class membership
%
for i = 1:10
    prob_test_class( i ) = test_samples( i )/number_of_test_cases;
end

% ------------------------------------------------------------
% seperate test samples by index
%
colorado_test_class1  = colorado_test_input(               1 :test_cases( 1),1:7);
colorado_test_class2  = colorado_test_input((test_cases(1)+1):test_cases( 2),1:7);
colorado_test_class3  = colorado_test_input((test_cases(2)+1):test_cases( 3),1:7);
colorado_test_class4  = colorado_test_input((test_cases(3)+1):test_cases( 4),1:7);
colorado_test_class5  = colorado_test_input((test_cases(4)+1):test_cases( 5),1:7);
colorado_test_class6  = colorado_test_input((test_cases(5)+1):test_cases( 6),1:7);
colorado_test_class7  = colorado_test_input((test_cases(6)+1):test_cases( 7),1:7);
colorado_test_class8  = colorado_test_input((test_cases(7)+1):test_cases( 8),1:7);
colorado_test_class9  = colorado_test_input((test_cases(8)+1):test_cases( 9),1:7);
colorado_test_class10 = colorado_test_input((test_cases(9)+1):test_cases(10),1:7);

% ------------------------------------------------------------
% establish training sample class assignments by index
%
train_samples = [0,0,0,0,0,0,0,0,0,0];
for i = 1:number_of_training_cases
    train_samples( colorado_train_classes(i) ) = train_samples( colorado_train_classes(i)) + 1;
end

% ------------------------------------------------------------
% establish training sample class assignments by index
%
train_cases = [0,0,0,0,0,0,0,0,0,0];
train_cases(1) = train_samples(1);
for i = 2:10
    train_cases( i ) = train_samples( i ) + train_cases( i-1 ) ;
end

% ------------------------------------------------------------
% training data - probability of class membership
%
for i = 1:10
    prob_train_class( i ) = train_samples( i )/number_of_training_cases;
end


% ------------------------------------------------------------
% seperate training samples by index
%
colorado_train_class1  = colorado_train_input(                1 :train_cases( 1),1:7);
colorado_train_class2  = colorado_train_input((train_cases(1)+1):train_cases( 2),1:7);
colorado_train_class3  = colorado_train_input((train_cases(2)+1):train_cases( 3),1:7);
colorado_train_class4  = colorado_train_input((train_cases(3)+1):train_cases( 4),1:7);
colorado_train_class5  = colorado_train_input((train_cases(4)+1):train_cases( 5),1:7);
colorado_train_class6  = colorado_train_input((train_cases(5)+1):train_cases( 6),1:7);
colorado_train_class7  = colorado_train_input((train_cases(6)+1):train_cases( 7),1:7);
colorado_train_class8  = colorado_train_input((train_cases(7)+1):train_cases( 8),1:7);
colorado_train_class9  = colorado_train_input((train_cases(8)+1):train_cases( 9),1:7);
colorado_train_class10 = colorado_train_input((train_cases(9)+1):train_cases(10),1:7);

% ------------------------------------------------------------
% all data - total probability of class membership
%
for i = 1:10
    prob_class( i ) = ( train_samples(i) + test_samples(i) ) / ( number_of_training_cases + number_of_test_cases );
end


% ------------------------------------------------------------
% save data to MATLAB-style mat files
%
save colo_trn.mat colorado_train_input colorado_train_output number_of_training_cases train_samples train_cases;

save trn_cls.mat colorado_train_class* colorado_train_classes;

save colo_tst.mat colorado_test_input colorado_test_output number_of_test_cases test_samples test_cases;

save tst_cls.mat colorado_test_class* colorado_test_classes ;

save colo_pr.mat prob_test_class prob_train_class prob_class;

% --------------------------------
% History:
% $Log: colorado.m,v $
% Revision 1.2  1997/10/06 20:46:23  jak
% The files are now compatible with LINUX Matlab v 5.1 -jak
%
% Revision 1.1.1.1  1997/09/27 18:57:14  jak
% First commit of the colorado data set in matlab. -jak
%
%

