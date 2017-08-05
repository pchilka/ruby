
file  = ARGV[0];
appid = ARGV[1];

File.open(file).each do |line|
  line =~ /(\d+)_/;
  puts line if $1 == appid;
end
