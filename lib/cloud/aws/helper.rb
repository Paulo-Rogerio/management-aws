module Cloud
  module Aws
    class Helper

      def titulo
        @table = Text::Table.new
        @table.head = ['Serviço', 'Comando']
        row
      end

      def row
        # Para cada comando 
        # EC2
        svc = "AWS EC2"
        cmd = "ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-ec2"
        @table.rows << [ "#{svc}", "#{cmd}" ]        

        # Security Group
        svc = "AWS Security Group"
        cmd = "ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-sg"
        @table.rows << [ "#{svc}", "#{cmd}" ]

        # S3
        svc = "AWS S3"
        cmd = "ruby cloud.rb --cloud=aws --region=sa-east-1 --resource=aws-s3"
        @table.rows << [ "#{svc}", "#{cmd}" ]        

      end

      def help;
        titulo
        return @table
      end


      # Paramentros passados pelo Usuário
      def parameters_send(var_cloud=nil, var_region=nil, var_resource=nil)         
        if v_cloud = /(?<cloud>aws)/.match(var_cloud) 
          @cloud ||= v_cloud['cloud'] 
        end

        if v_region = /(?<region>[a-z]{2}-\w+-[0-9])/.match(var_region)
          @region ||= v_region['region']
        end

        if v_resource = /(?<resource>aws-\w+)/.match(var_resource)
          @resource ||= v_resource['resource']
        end
      end

      def cloud; 
        return @cloud 
      end

      def region; 
        return @region 
      end      

      def resource; 
        return @resource 
      end 

    end
  end
end