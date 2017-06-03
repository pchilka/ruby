filepath = "pb.txt";
File.open(filepath).each do |line|
	fields = line.split /\t/;
	ikey   = fields[0];
	iid    = fields[1];
	itype  = fields[2];
	assign = fields[3];
	status = fields[4];
	sprint = fields[5];
	reqid1 = fields[6];
	reqid2 = fields[7];
	reqid3 = fields[8];
	reqid4 = fields[9];
	print "#{reqid1}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n";
	print "#{reqid2}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid2 != "";
	print "#{reqid3}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid3 != "";
	print "#{reqid4}, #{ikey}, #{itype}, #{assign}, #{status}, #{sprint}\n" if reqid4 != "";
end

