# Author : Pradeep Chilka
# Created: 24th May 2017

DIR = "resx";

Dir.foreach(DIR) do |file|
    if file =~ /\.resx$/
        filepath = DIR + "/#{file}";
	$data = false;
        File.open(filepath).each do |line|
            if line =~ /^\s*\<data name=\"(\w*)\"/ 
		$data = true;
		$name = $1;
		#print "got <data name=\"#{$name}\">\n";
            elsif line =~ /^\s*\<\/data\>/ 
		$data = false;
            elsif line =~ /^\s*\<value\>(.*?)\<\/value\>/ 
		$value = $1;
		#print "got <value>#{$value}</value>\n";
		print "#{$name}\t#{$value}\n";
            end
        end
    end
end

