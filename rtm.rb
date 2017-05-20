# RTM

rtm = Hash.new(0);

File.open("Feature.txt").each do |line|
	if line =~ /Scenario/ 
		print line;
		if line =~ /Scenario:.*?(\d+\.\d+\.\d+)\.\d+.*$/ 
			print "Extracted>>>>>>> " + $1 + "\n";
			rtm[$1] += 1;
		end
	end
end

rtm.each {|key, val| print "req=#{key}, count=#{val}\n";}
