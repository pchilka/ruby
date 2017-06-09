FILE = "jira.txt";
COL1 = 200;
COL2 = 800;

def mystrip(str)
    if !str.nil? then
        if str =~ /"(.*)"/m
            return $1.strip;
        else
            return str.strip;
        end
    else
        return str;
    end
end

puts "<html>";
puts "<body>";
puts "<table>";
File.readlines(FILE, '<eol>').each do |line|
	fields = line.split /\t/;
    if mystrip(fields[0]) =~ /^CEN-/ then
        $ikey   = mystrip(fields[0]);
        $iid    = mystrip(fields[1]);
        $itype  = mystrip(fields[2]);
        $assign = mystrip(fields[3]);
        $status = mystrip(fields[4]);
        $sprint = mystrip(fields[5]);
        $reqid  = mystrip(fields[6]);
        $summary= mystrip(fields[7]);
        if $ikey=="CEN-13"
            puts $ikey;
        end
    end
	$testid = mystrip(fields[8]);
    $test   = mystrip(fields[9]);
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
