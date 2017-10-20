
require 'user_agent_parser'

OperatingSystem = {};

def fixos(os)
	if os =~ /^iOS/
		return "iOS";
	elsif os =~ /^Mac OS X/
		return "Mac OS X";
	elsif os =~ /^Linux/
		return "Linux";
	elsif os =~ /^Ubuntu/
		return "Ubuntu";
	else
		return os;
	end
	return os;
end

IO.foreach("splunk.txt") do |line|
    (uastr, count) = line.chomp.split /\t/;
    ua = UserAgentParser.parse uastr
	browser = ua.family.to_s;
	opersys = fixos(ua.os.to_s);
	count   = count.to_i;
	if OperatingSystem[opersys].nil? then
		OperatingSystem[opersys] = {browser => count};
	else
		if OperatingSystem[opersys][browser].nil?
			OperatingSystem[opersys][browser] = count;
		else
			OperatingSystem[opersys][browser] += count;
		end
	end
end

OperatingSystem.each do |os,browsers|
	browsers.each do |b,c|
		printf "%s, %s, %d\n", os, b, c;
	end
end
