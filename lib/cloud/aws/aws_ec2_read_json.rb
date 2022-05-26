module Cloud
  module Aws
    class Ec2

      def tag(tags=nil)
        tags.map do |i|
          i['Value'] 
        end
      end
      
      def securitygroup_name(var_sg_name=nil)
        var_sg_name.map do |i|
          i['GroupName'] 
        end
      end

      def securitygroup_id(var_sg_id=nil)
        var_sg_id.map do |i|
          i['GroupId'] 
        end
      end
      
      def ec2(payload=nil)

        @table.head = ['InstanceId', 'PrivateIpAddress', 'PublicIpAddress', 'SecurityGroupsId', 'Tags' ]        
      
        payload.map do |i|
          instanceid = i['Instances'][0]['InstanceId']
          privateipaddress = i['Instances'][0]['PrivateIpAddress']
          publicipaddress = (i['Instances'][0]['PublicIpAddress'].nil? ? 'NOT IP PUBLIC' : i['Instances'][0]['PublicIpAddress'])
          tags = tag(i['Instances'][0]['Tags'])[0]
          sg_name = securitygroup_name(i['Instances'][0]['SecurityGroups']).join(',')
          sg_id = securitygroup_id(i['Instances'][0]['SecurityGroups']).join(',')
      
          @table.rows << [ "#{instanceid}", "#{privateipaddress}", "#{publicipaddress}", "#{sg_id}", "#{tags}" ]          
      
        end 
      end
      
      def aws_ec2_read_json
        arq = "#{Cloud::Aws::Constantes::EC2_DESCRIBE_INSTANCE_JSON}"
        file = File.open(arq)
        data = JSON.parse(File.read(file))
        payload = data["Reservations"]        
        @table = Text::Table.new
        ec2(payload)
        file.close
        return @table
      end      

    end
  end
end