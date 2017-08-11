require 'net/sftp'
require 'date'
require 'optparse'
require 'json'
require_relative 'dapps'

options = {:appid => nil, :date => nil, :monitor => false, :env => "pilot", :ftp => nil, :username => nil, :password => nil};

OptionParser.new do |opts|
	opts.banner = "Usage: ruby show.rb [options]";
	opts.on("-a", "--appid appid", "Specify applicant id") do |appid|
		options[:appid] = appid;
	end
	opts.on("-d", "--date date", "Specify date to filter, e.g. -d \"2017-08-04\"") do |date|
		options[:date] = Date.parse(date);
	end
	opts.on("-m", "--monitor", "Monitor the traffic") do
		options[:monitor] = true;
	end
	opts.on("-p", "--pilot", "Specify pilot environment [default]") do
		options[:env] = "pilot";
	end
	opts.on("-s", "--stage", "Specify stage environment [default pilot]") do
		options[:env] = "stage";
	end
	opts.on("-t", "--today", "Specify today's date to filter") do
		options[:date] = Date.today;
	end
end.parse!

json     = `gpg -d -r pchilka@yahoo.com .config.gpg`;
config   = JSON.parse(json);

# setting default to Pilot environment
if (options[:env] == "stage")
	options[:ftp]      = config["stage"]["ftp"];
	options[:username] = config["stage"]["username"];
	options[:password] = config["stage"]["password"];
else
	options[:ftp]      = config["pilot"]["ftp"];
	options[:username] = config["pilot"]["username"];
	options[:password] = config["pilot"]["password"];
end

dapps = Dapps.new(options[:ftp],options[:username],options[:password]);

if options[:monitor]
	while true
		system 'clear';
		dapps.print_monitor :appid => options[:appid];
		sleep 15;
	end
else
	dapps.print :appid => options[:appid];
end

