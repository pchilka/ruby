require "erb"

# Build template data class.
class Scenario

    attr_reader :ikey, :iid, :itype, :assign, :status;
    attr_reader :sprint, :reqid, :summary, :testid, :test;

    def initialize(ikey,iid,itype,assign,status,sprint,reqid,summary,testid,test)
        @ikey   = ikey;
        @iid    = iid;
        @itype  = itype;
        @assign = assign;
        @status = status;
        @sprint = sprint;
        @reqid  = reqid;
        @summary= summary;
        @testid = testid;
        @test   = test;
    end

    def add_req(reqid)
        @reqid << reqid;
    end

end

class Scenarios

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

    def initialize(infile)
        @infile    = infile
        @scenarios = Array.new;
        File.readlines(infile, '<eol>').each do |line|
            fields = line.split /\t/;
            if mystrip(fields[0]) =~ /^CEN-/ then
                @@ikey   = mystrip(fields[0]);
                @@iid    = mystrip(fields[1]);
                @@itype  = mystrip(fields[2]);
                @@assign = mystrip(fields[3]);
                @@status = mystrip(fields[4]);
                @@sprint = mystrip(fields[5]);
                @@reqid  = mystrip(fields[6]);
                @@summary= mystrip(fields[7]);
            end
            @@testid = mystrip(fields[8]);
            @@test   = mystrip(fields[9]);
            @@test.gsub!(/\n\n+/,"\n") if !@@test.nil?
            @scenarios << Scenario.new(@@ikey,@@iid,@@itype,@@assign,@@status,@@sprint,@@reqid,@@summary,@@testid,@@test);
        end
    end

    # Support templating of member data.
    def get_binding
        binding
    end

end

# Create template.
template = %{
  <html>
    <head><title>C-SHaRPS JIRA Product Backlog</title></head>
    <body>
      <table>
        <% @scenarios.each do |s| %>
            <tr style="background-color:powderblue">
                <td style="text-align:right" valign="top">REQUIREMENT ID:</td>
                <td valign="top"><%= s.reqid %></td>
            </tr>
            <tr>
                <td style="text-align:right" valign="top">JIRA ISSUE KEY:</td>
                <td valign="top"><%= s.ikey %></td>
            </tr>
            <tr>
            <td style="text-align:right" valign="top">JIRA ISSUE TYPE:</td>
            <td valign="top"><%= s.itype %></td>
            </tr>
            <tr>
            <td style="text-align:right" valign="top">SUMMARY:</td><td valign="top">
            <%= s.summary %></td>
            </tr>
            <tr>
            <td style="text-align:right" valign="top">TEST ID:</td><td><pre>
            <%= s.testid %></pre></td>
            </tr>
            <tr>
            <td style="text-align:right" valign="top">SCENARIO:</td><td><pre>
            <%= s.test %></pre></td>
            </tr>
        <% end %>
      </table>
    </body>
  </html>
}.gsub(/^  /, '')

rhtml = ERB.new(template)

# Set up template data.
scenarios = Scenarios.new("jira.txt");

# Produce result.
rhtml.run(scenarios.get_binding)
