module Cloud
  module Aws
    class CommandLine

      def describe_instance(region=nil)
        `aws ec2 describe-instances --region #{region} > #{Cloud::Aws::Constantes::EC2_DESCRIBE_INSTANCE_JSON}`
      end

      def describe_security_groups(region=nil)
        `aws ec2 describe-security-groups --region #{region} > #{Cloud::Aws::Constantes::EC2_DESCRIBE_SECURITY_GROUP_JSON}`
      end

    end
  end
end