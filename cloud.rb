require_relative 'lib/cloud/aws'

cloud = Cloud::Provider::Execute.new
cloud.run
