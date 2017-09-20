%% RCFilter: function description
function [time_f, signal_f] = RCfilter(time, signal, RC = 0.383)
	% t_response = 0:ns/length(time):ns;
	
	% 1/fc < RC < 1/b
	% b = 1.5 KHz

	t_response = time;

	dt = 1/40;

	u_response = ones(length(signal), 1);

	% RC = 3.833 / 10;

	RC = 1 / 1.5;

	temp_t = t_response./RC;
	temp_t = temp_t.*-1;

	temp_t_exp = arrayfun( @(x) exp(x), temp_t);

	u_response = u_response.*temp_t_exp;

	u_response = u_response(1,:);

	size(t_response)
	size(u_response)

	[time_f, signal_f]  = contconv(signal, u_response, time(1), t_response(1), dt);
end
