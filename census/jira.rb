FILE = "jira.txt";
COL1 = 200;
COL2 = 800;

def mychomp(str)
    str.nil? ? str : str.chomp;
end

puts "<html>";
puts "<body>";
puts "<table>";
File.readlines(FILE, '<eol>').each do |line|
	fields = line.split /\t/;
	temp   = fields[0].strip;
    if temp =~ /^CEN-/ then
        $ikey   = temp;
        $iid    = fields[1];
        $itype  = fields[2];
        $assign = fields[3];
        $status = fields[4];
        $sprint = fields[5];
        $reqid  = mychomp(fields[6]);
        $summary= mychomp(fields[7]);
    end
	$testid = mychomp(fields[8]);
    $test   = mychomp(fields[9]);
	$test.gsub!(/\n\n+/,"\n") if !$test.nil?
    if !($ikey == "" && $reqid == "" && $testid == "" && $test == "") then
        puts "<tr style=\"background-color:powderblue\">";
        puts "<td style=\"text-align:right\" valign=\"top\">REQUIREMENT ID:</td>";
        puts "<td valign=\"top\">#{$reqid}";
        puts "</td></tr>";
        puts "<tr>";
        puts "<td style=\"text-align:right\" valign=\"top\">JIRA ISSUE KEY:</td><td valign=\"top\">#{$ikey}</td>";
        puts "</tr>";
        puts "<tr>";
        puts "<td style=\"text-align:right\" valign=\"top\">JIRA ISSUE TYPE:</td><td valign=\"top\">#{$itype}</td>";
        puts "</tr>";
        puts "<tr>";
        puts "<td style=\"text-align:right\" valign=\"top\">SUMMARY:</td><td valign=\"top\">#{$summary}</td>";
        puts "</tr>";
        puts "<tr>";
        puts "<td style=\"text-align:right\" valign=\"top\">TEST ID:</td><td><pre>#{$testid}</pre></td>";
        puts "</tr>";
        puts "<tr>";
        puts "<td style=\"text-align:right\" valign=\"top\">SCENARIO:</td><td><pre>#{$test}</pre></td>";
        puts "</tr>";
    end
end
puts "</table>";
puts "</body>";
puts "</html>";
