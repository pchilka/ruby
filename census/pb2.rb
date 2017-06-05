FILE = "pb2.txt";
COL1 = 200;
COL2 = 800;

puts "<html>";
puts "<body>";
puts "<table>";
File.readlines(FILE, '<eof>').each do |line|
#	print ">>>>>>>>> #{line}\n";
	fields = line.split /\t/;
	ikey   = fields[0].strip;
	iid    = fields[1];
	itype  = fields[2];
	assign = fields[3];
	status = fields[4];
	sprint = fields[5];
	reqid1 = fields[6];
	reqid2 = fields[7];
	reqid3 = fields[8];
	reqid4 = fields[9];
	summary= fields[10];
	desc   = fields[11];
	desc.gsub!(/\n\n+/,"\n") if !desc.nil?
	puts "<tr style=\"background-color:powderblue\">";
	puts "<td style=\"text-align:right\" valign=\"top\">REQUIREMENT ID:</td>";
    puts "<td valign=\"top\">#{reqid1}";
	puts ", #{reqid2}" if reqid2 !="";
	puts ", #{reqid3}" if reqid3 !="";
	puts ", #{reqid4}" if reqid4 !="";
	puts "</td></tr>";
	puts "<tr>";
	puts "<td style=\"text-align:right\">JIRA ISSUE KEY:</td><td valign=\"top\">#{ikey}</td>";
	puts "</tr>";
	puts "<tr>";
	puts "<td style=\"text-align:right\">JIRA ISSUE TYPE:</td><td valign=\"top\">#{itype}</td>";
	puts "</tr>";
	puts "<tr>";
	puts "<td style=\"text-align:right\">SUMMARY:</td><td valign=\"top\">#{summary}</td>";
	puts "</tr>";
	puts "<tr>";
	puts "<td style=\"text-align:right\" valign=\"top\">DESCRIPTION:</td><td><pre>#{desc}</pre></td>";
	puts "</tr>";
end
puts "</table>";
puts "</body>";
puts "</html>";
