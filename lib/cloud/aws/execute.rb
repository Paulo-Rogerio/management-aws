module Cloud
  module Provider
    class Execute

      def run(v_cloud=ARGV[0], v_region=ARGV[1], v_resource=ARGV[2])
        h = Cloud::Aws::Helper.new

        if (v_cloud.nil? && v_region.nil? && v_resource.nil?)
        then
          puts h.help
        else
          h.parameters_send(v_cloud, v_region, v_resource)

          # Amazon
          if h.cloud == 'aws'
          then          
            if h.resource == 'aws-ec2'
            then
              puts
              puts "Getting data AWS !!! Waiting...."
              puts
              get_data_api_aws = Cloud::Aws::CommandLine.new
              get_data_api_aws.describe_instance(h.region)

              read_data_api_aws = Cloud::Aws::Ec2.new
              puts read_data_api_aws.aws_ec2_read_json

            elsif h.resource == 'aws-sg'
            then
              puts
              puts "Getting data AWS !!! Waiting...."
              puts
              get_data_api_aws = Cloud::Aws::CommandLine.new
              get_data_api_aws.describe_security_groups(h.region)

              read_data_api_aws = Cloud::Aws::SecurityGroup.new
              puts read_data_api_aws.aws_ec2_security_group_read_json

            else
              puts "Parametro invalido:  #{h.resource}" 
            end
          end  
        end
      end 
    end
  end
end