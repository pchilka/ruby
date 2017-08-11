require 'net/sftp'


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

	
class Payload
	def initialize(name, atime, mtime)
		@name  = name;
		@atime = atime;
		@mtime = mtime;
	end
end

class Dapps
	
	@payloads = {};

	def initialize(ftp, username, password)
		@sftp = Net::SFTP.start(ftp, username, :password => password);
	end

	def print(args={})
		DIRS.each do |f|
			@sftp.dir.foreach(f) do |entry|
				atim = Time.at(entry.attributes.atime); 
				mtim = Time.at(entry.attributes.mtime); 
				utc  = atim.strftime("%m/%d/%y %H:%M:%S");
				local= Time.at(entry.attributes.atime-4*60*60).strftime("%m/%d/%y %H:%M:%S");
				if entry.attributes.file?
					if !args[:date].nil?
						printf "%s,%s,%s,%s\n",entry.name,f,utc,local if args[:date] == atim.to_date;
					elsif !args[:appid].nil?
						entry.name =~ /^(\d+)_.*/;
						printf "%s,%s,%s,%s\n",entry.name,f,utc,local if args[:appid] == $1;
					else
						printf "%s,%s,%s,%s\n",entry.name,f,utc,local;
					end
				end
			end
		end
	end

	def rept(char, number)
		str = "";
		number.times {str = str + char};
		return str;
	end

	def print_line(name,f,local)
		printf "|%-90s|\n",rept("-",90);
		printf "|%-10s : %-77s|\n", "File", name;
		printf "|%-10s : %-77s|\n", "Folder", f;
		printf "|%-10s : %-77s|\n", "Time", local;
		printf "|%-90s|\n",rept("-",90);
		#printf "%-60s|%-40s|%-20s\n",name,f,local;
		#printf "%-60s|%-40s|%-20s\n",rept("-",60),rept("-",40),rept("-",20);
	end

	def print_monitor(args={})
		lines = [];
		DIRS.each do |f|
			@sftp.dir.foreach(f) do |entry|
				atim = Time.at(entry.attributes.atime); 
				mtim = Time.at(entry.attributes.mtime); 
				utc  = atim.strftime("%m/%d/%y %H:%M:%S");
				local= Time.at(entry.attributes.atime-4*60*60).strftime("%m/%d/%y %H:%M:%S");
				if entry.attributes.file?
					if !args[:date].nil?
						if args[:date] == atim.to_date
							lines << [entry.name, f, atim];
						end
					elsif !args[:appid].nil?
						entry.name =~ /^(\d+)_.*/;
						if args[:appid] == $1
							lines << [entry.name, f, atim];
						end
					else
							lines << [entry.name, f, atim];
					end
				end
			end
		end
		# now sort it
		lines_sorted = lines.sort {|a,b| a[2] <=> b[2]};
		lines_sorted.each do |x| 
			local= Time.at(x[2]-4*60*60).strftime("%m/%d/%y %H:%M:%S");
			print_line x[0], x[1], local;
		end
	end
end

