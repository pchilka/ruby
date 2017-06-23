# Generates a tab separated file of <req_id> <scenario> <feature_file> rows
# Looks for a directory called "features" in current working directory that 
# should have all the .feature files
# Author : Pradeep Chilka
# Created: 19th May 2017

FDIR = "Features";

Dir.foreach(FDIR) do |file|
    if file =~ /\.feature$/
        filepath = FDIR + "/#{file}";
        File.open(filepath).each do |line|
            if line =~ /^\s*Scenario/ 
                if line =~ /^\s*Scenario\s*:?\s*(.*?)(\d+\.\d+\.\d+)(.*$)/ 
                    print $2 + "|";
                    print $2 + $3.strip + "|";
                    line.gsub!(',',';');
                    print "#{line.chop.strip}|";
                    print file + "\n";
                elsif line =~ /^\s*Scenario\s*:?\s*(.*)$/ 
                    print "" + "|";
                    print "" + "|";
                    print "ERROR: Scenario: " + $1 + "|";
                    print file + "\n";
                end
            end
        end
    end
end

