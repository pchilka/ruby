# RTM


FDIR = "features";

Dir.foreach(FDIR) do |file|
    if file =~ /\.feature$/
        #print "Feature file: #{file}\n";
        filepath = FDIR + "/#{file}";
        File.open(filepath).each do |line|
            if line =~ /^\s*Scenario/ 
                if line =~ /^\s*Scenario\s*:?(.*?)(\d+\.\d+\.\d+).*$/ 
                    print $2 + "\t" + $1 + "\t" + "#{file}\n";
                elsif line =~ /^\s*Scenario\s*:?(.*)$/ 
                    print "" + "\t" + $1 + "\t" + "#{file}\n";
                end
            end
        end
    end
end

