
require 'user_agent_parser'

Browser         = {};
OperatingSystem = {};

IO.foreach("splunk.txt") do |line|
    (uastr, count) = line.chomp.split /\t/;
    ua = UserAgentParser.parse uastr
    #printf "%s, %s, %s\n", ua.family.to_s, ua.version.to_s, ua.os.to_s;
    b = Browser[ua.family.to_s];
    Browser[ua.family.to_s] = b.nil? ? count.to_i : b + count.to_i;
end

Browser.each do |b,c|
    printf "%s, %d\n", b, c;
end
