
% 
% Matlab Function - conf_mat.m
% Calculate and Display a Confusion Matrix
%
% $Id: conf_mat.m,v 1.1 1997/09/29 21:01:56 jak Exp $
%
% 

function [confusion, percent_correct, total_percent_correct] = conf_mat(Desired,Actual,samples_per_class) 

	err = Desired - Actual;
    [classes, samples ] = size( Desired );
	confusion = zeros(classes, classes);
	for s=1:samples
		from = 0;
		to = from;
		for c=1:classes
			if err(c,s) == -1
				to = c;
			end
			if err(c,s) == 1
				from = c;
			end
			if Desired(c,s) == 1
				d = c;
			end
		endfor
		if from == to
			confusion(d,d) = confusion(d,d) + 1;
		else
			confusion(from,to) = confusion(from,to) + 1;
		end
	endfor

	correct = zeros(1,classes);
	for i=1:classes
		correct(1, i) = confusion(i,i);
	endfor
	percent_correct = zeros(1,classes);
	for i=1:classes
		percent_correct(1, i) = (correct(1,i) / samples_per_class(i)) * 100 ;
	endfor
	total_percent_correct = (sum( correct ) / sum( samples_per_class )) * 100;

endfunction

% --------------------------------
% History:
% $Log: conf_mat.m,v $
% Revision 1.1  1997/09/29 21:01:56  jak
% Moved the confusion matrix to a seperate function. -jak
%
%
