# RTM

rtm = Hash.new;

File.open("Feature.txt").each do |line|
	if line =~ /Scenario/ 
		print line;
		if line =~ /Scenario:.*?(\d+\.\d+\.\d+)\.\d+.*$/ 
			print "Extracted>>>>>>> " + $1 + "\n";
			rtm[$1] = rtm[$1].nil? ? 0 : rtm[$1]+1
		end
	end
end

rtm.each {|key, val| print "req=#{key}, count=#{val}\n";}
