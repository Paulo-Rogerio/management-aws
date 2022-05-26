require 'json'
require 'text-table'

arq = "../tmp/ec2-security-groups.json"
file = File.open(arq)
data = JSON.parse(File.read(file))
payload = data["SecurityGroups"]   

# methods here #
...
... 
...
################

def print_ec2(payload=nil)
  @table = Text::Table.new
  ec2(payload)
  puts @table
end

print_ec2(payload)
file.close
