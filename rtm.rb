# Generates a tab separated file of <req_id> <scenario> <feature_file> rows
# Looks for a directory called "features" in current directory that should have all the .feature files
# Author : Pradeep Chilka
# Created: 19th May 2017

FDIR = "features";

Dir.foreach(FDIR) do |file|
    if file =~ /\.feature$/
        #print "Feature file: #{file}\n";
        filepath = FDIR + "/#{file}";
        File.open(filepath).each do |line|
            if line =~ /^\s*Scenario/ 
                if line =~ /^\s*Scenario\s*:?\s*(.*?)(\d+\.\d+\.\d+)(.*$)/ 
                    print $2 + "\t";
                    print "Scenario: " + $1 + $2 + $3 + "\t";
                    print file + "\n";
                elsif line =~ /^\s*Scenario\s*:?\s*(.*)$/ 
                    print "" + "\t";
                    print "Scenario: " + $1 + "\t";
                    print file + "\n";
                end
            end
        end
    end
end

