# RTM

File.open("Feature.txt").each do |line|
	if line =~ /Scenario/ 
		print line;
		if line =~ /Scenario:.*?(\d+\.\d+\.\d+)\.\d+.*$/ 
			print "Extracted>>>>>>> " + $1 + "\n";
		end
	end
end
