# RTM


FDIR = "features";

Dir.foreach(FDIR) do |file|
    if file =~ /\.feature$/
        #print "Feature file: #{file}\n";
        filepath = FDIR + "/#{file}";
        File.open(filepath).each do |line|
            if line =~ /^\s*Scenario/ 
                if line =~ /Scenario:(.*?)(\d+\.\d+\.\d+).*$/ 
                    print $2 + "\t" + $1 + "\t" + "#{file}\n";
                elsif line =~ /Scenario:(.*)$/ 
                    print "" + "\t" + $1 + "\t" + "#{file}\n";
                end
            end
        end
    end
end

