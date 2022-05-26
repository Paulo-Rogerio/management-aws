module Cloud
  module Aws
    class SecurityGroup

      def more_data(data=nil)
        data.map do |i|
          @from_port = (i['FromPort'].nil? ? 'ALL' : i['FromPort'])
          @to_port = (i['ToPort'].nil? ? 'ALL' : i['ToPort'])
      
          ipv4range (ips  = i['IpRanges'])
      
          ipv6range (ips  = i['Ipv6Ranges'])
      
          unless i['UserIdGroupPairs'].nil?
            grouppairs (ggpairs = i['UserIdGroupPairs'])
          end    
      
        end
      end
      
      def ipv4range (ips=nil)
        ips.map do |i|
          @ip = i['CidrIp']
          @desc = i['Description']
          @table.rows << [ "#{@groupid}", "#{@groupname}", "#{@from_port}", "#{@ip}", "#{@to_port}", "#{@desc}" ] 
        end
      end
      
      def ipv6range (ips=nil)
        ips.map do |i|
          @ip = i['CidrIpv6']
          @desc = i['Description']
          @table.rows << [ "#{@groupid}", "#{@groupname}", "#{@from_port}", "#{@ip}", "#{@to_port}", "#{@desc}" ] 
        end
      end
      
      def grouppairs(group_pairs)
        group_pairs.map do |i|
          @ip = i['GroupId']
          @desc = i['Description']
          @from_port = "ALL"
          @to_port = "ALL"
          @table.rows << [ "#{@groupid}", "#{@groupname}", "#{@from_port}", "#{@ip}", "#{@to_port}", "#{@desc}" ] 
        end  
      end
      
      
      def ec2(payload=nil)
      
        @table.head = ['GroupId', 'GroupName', 'From Port', 'Ip Origin', 'To Port', 'Description']  
      
        payload.map do |i|
          @groupid = i['GroupId']
          @groupname = i['GroupName']
          more_data(i['IpPermissions'])
          line_blank = (["_"] * 20).join("")
          @table.rows << [ "#{line_blank}", "#{line_blank}", "#{line_blank}", "#{line_blank}", "#{line_blank}", "#{line_blank}" ]
        end 
      end      

      def aws_ec2_security_group_read_json
        arq = "#{Cloud::Aws::Constantes::EC2_DESCRIBE_SECURITY_GROUP_JSON}"
        file = File.open(arq)
        data = JSON.parse(File.read(file))
        payload = data["SecurityGroups"]        
        @table = Text::Table.new
        ec2(payload)
        file.close
        return @table
      end

    end
  end
end
