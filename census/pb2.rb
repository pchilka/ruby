filepath = "pb2.txt";
puts "<table>";
File.readlines(filepath, '<eof>').each do |line|
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
	#print "#{reqid1}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n";
	#print "#{reqid2}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid2 != "";
	#print "#{reqid3}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid3 != "";
	#print "#{reqid4}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid4 != "";
	puts "<tr>";
	puts "<td align=\"right\">REQUIREMENT:</td><td>#{reqid1}";
	puts ", #{reqid2}" if reqid2 !="";
	puts ", #{reqid3}" if reqid3 !="";
	puts ", #{reqid4}" if reqid4 !="";
	puts "</td></tr>";
	puts "<tr>";
	puts "<td  align=\"right\" valign=\"top\">JIRA ID:</td><td>#{ikey}</td>";
	puts "</tr>";
	puts "<tr>";
	puts "<td align=\"right\" valign=\"top\">SUMMARY:</td><td>#{summary}</td>";
	puts "</tr>";
	puts "<tr>";
	puts "<td align=\"right\" valign=\"top\">ACCEPTANCE:</td><td><pre>#{desc}</pre></td>";
	puts "</tr>";
end
puts "<table>";

