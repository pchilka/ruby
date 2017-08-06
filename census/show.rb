require 'net/sftp'
require 'date'
require 'optparse'
require 'json'

DIRS = ["Applicant/Packages",
	"Applicant/Packages/InProgress",
	"Applicant/Packages/Completed",
	"Applicant/Packages/Response",
#	"Applicant/Packages/Response/InProgress",
	"Applicant/Packages/Response/Completed",
	"Applicant/Updates",
	"Applicant/Updates/InProgress",
	"Applicant/Updates/Completed",
	"Applicant/Updates/Response",
	"Applicant/Updates/Response/InProgress",
	"Applicant/Updates/Response/Completed"];
	

options = {:date => nil, :ftp => nil, :username => nil, :password => nil};

OptionParser.new do |opts|
  opts.banner = "Usage: ruby showp.rb [options]";
  opts.on("-d", "--date date", "Specify date to filter") do |date|
    options[:date] = Date.parse(date);
  end
  opts.on("-t", "--today", "Specify today's date to filter") do
    options[:date] = Date.today;
  end
  opts.on("-s", "--stage", "Specify stage environment [default pilot]") do
    options[:ftp]      = config["stage"]["ftp"];
    options[:username] = config["stage"]["username"];
    options[:password] = config["stage"]["password"];
  end
  opts.on("-p", "--pilot", "Specify pilot environment [default") do
    options[:ftp]      = config["pilot"]["ftp"];
    options[:username] = config["pilot"]["username"];
    options[:password] = config["pilot"]["password"];
  end
end.parse!

json     = `gpg -d -r pchilka@yahoo.com .config.gpg`;
config   = JSON.parse(json);

# setting default to Pilot environment
if (options[:ftp].nil?)
    options[:ftp]      = config["pilot"]["ftp"];
    options[:username] = config["pilot"]["username"];
    options[:password] = config["pilot"]["password"];
end

Net::SFTP.start(options[:ftp], options[:username], :password => options[:password]) do |sftp|
  # list the entries in a directory
  DIRS.each do |f|
    sftp.dir.foreach(f) do |entry|
      atim = Time.at(entry.attributes.atime); 
      mtim = Time.at(entry.attributes.mtime); 
      utc  = atim.strftime("%m/%d/%y %H:%M:%S");
      local= Time.at(entry.attributes.atime-4*60*60).strftime("%m/%d/%y %H:%M:%S");
      if entry.attributes.file?
              if options[:date].nil?
		      printf "%s,%s,%s,%s\n",entry.name,f,utc,local;
#		      printf "%-40s: %s\n", f, entry.name;
#		      puts entry.longname;
              else
		      if options[:date] == atim.to_date;
			      printf "%s,%s,%s,%s\n",entry.name,f,utc,local;
#			      printf "%-40s: %s\n", f, entry.name;
#			      puts entry.longname;
	#                     puts "atime= " + atim.asctime;
	#                     puts "mtime= " + mtim.asctime;
		      end
              end
      end
    end
  end
end
