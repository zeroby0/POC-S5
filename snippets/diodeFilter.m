%% diodeFilter: makes all values less than zero 0
function [result] = diodeFilter(vector)
	vector(vector < 0) = 0;
	result = vector;
end
	
