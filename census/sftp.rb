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

	def print(*args)
		puts "got in!" if @sftp;
		DIRS.each do |f|
			@sftp.dir.foreach(f) do |entry|
				atim = Time.at(entry.attributes.atime); 
				mtim = Time.at(entry.attributes.mtime); 
				utc  = atim.strftime("%m/%d/%y %H:%M:%S");
				local= Time.at(entry.attributes.atime-4*60*60).strftime("%m/%d/%y %H:%M:%S");
				if entry.attributes.file?
					if args.length == 0
						printf "%s,%s,%s,%s\n",entry.name,f,utc,local;
					else
						printf "%s,%s,%s,%s\n",entry.name,f,utc,local if args[:date] == atim.to_date;
					end
				end
			end
		end
	end

	def get_id(name)
		name =~ /(\d+)_.*/;
		return $1;
	end

	def get_payloads
		DIRS.each do |f|
			@sftp.dir.foreach(f) do |entry|
				atime = Time.at(entry.attributes.atime); 
				mtime = Time.at(entry.attributes.mtime); 
				if entry.attributes.file?
					app_id = get_id entry.name;
				 	@payloads[app_id] =  @payloads[app_id].nil? ? [] : @payloads[app_id];
#				 	@payloads[app_id] << Payload.new entry.name, atime, mtime;
				end
			end
		end
	end
end

