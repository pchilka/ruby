# RTM


FDIR = "features";

Dir.foreach(FDIR) do |file|
    if file =~ /\.feature$/
        #print "Feature file: #{file}\n";
        filepath = FDIR + "/#{file}";
        File.open(filepath).each do |line|
            line = line.chomp
            if line =~ /^\s*Scenario/ 
                if line =~ /^\s*Scenario\s*:?(.*?)(\d+\.\d+\.\d+)(.*$)/ 
                    print $2 + "\t";
                    print "Scenario: " + $1 + $2 + $3 + "\t";
                    print file + "\n";
                elsif line =~ /^\s*Scenario\s*:?(.*)$/ 
                    print "" + "\t";
                    print "Scenario: " + $1 + "\t";
                    print file + "\n";
                end
            end
        end
    end
end

