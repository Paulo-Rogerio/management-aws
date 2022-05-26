#!/usr/bin/env bash

# Region
# export AWS_REGION="sa-east-1"

# Generate Data
# mkdir tmp/
# aws ec2 describe-instances --region sa-east-1 > tmp/ec2.json
# aws ec2 describe-security-groups --region sa-east-1 > tmp/ec2-security-groups.json
# jq ".SecurityGroups[0]" tmp/ec2-security-groups.json
# GroupId
# GroupName
# FromPort + IpProtocol
# CidrIp ( Para quem )
# 

# a=$(jq -r '.Reservations[]|
#            .Instances[]|
#            [(.InstanceId | . + ","),
#             (.Tags[]? |select(.Key=="Name")|.Value | . + ","),
#             (.PrivateIpAddress | . + ","),
#             (.PublicIpAddress | . + ","),
#             (.SecurityGroups[]? |.GroupName | . + ","),
#             (.SecurityGroups[]? |.GroupId)] | @tsv' tmp/ec2.json)

# printf "%10s %s \n" "======================================================================================================================================="
# printf "%-20s | %-30s | %-14s | %-15s | %-27s | %-20s | %s \n"  "Instance Id" "Intance Name" "Private Ip" "Private Public" "Security Group Name" "Security Group Id"
# printf "%10s %s \n" "======================================================================================================================================="

# while read tmp;
# do
#   IFS=','
#   for line in ${tmp[@]}
#   do
#     echo $line
#   done
#   echo "-----"
#   INSTANCEID=$(echo ${tmp} | cut -d "," -f1)
#   INSTANCENAME=$(echo ${tmp} | cut -d "," -f2)
#   PRIVATEIPADDRESS=$(echo ${tmp} | cut -d "," -f3)
#   PUBLICIPADDRESS=$(echo ${tmp} | cut -d "," -f4)
#   GROUPNAME=$(echo ${tmp} | cut -d "," -f5)
#   GROUPID=$(echo ${tmp} | cut -d "," -f8)
#   printf "%-20s | %-30s | %-14s | %-15s | %-27s | %-20s |%s \n" "${INSTANCEID}" "${INSTANCENAME}" "${PRIVATEIPADDRESS}" "${PUBLICIPADDRESS}" "${GROUPNAME}" "${GROUPID}"
# done <<< $a


# | @tsv
# Read Data
# jq . tmp/ec2.json

# List All EC2
# aws ec2 describe-instances --region sa-east-1 > /tmp/aws-cli/ec2.json && \
# jq ".Reservations[] | .Instances[] | {Tags: .Tags, Tags: .Tags, InstanceId: .InstanceId, SecurityGroups: .SecurityGroups}" /tmp/aws-cli/ec2.json


# aws iam list-policies --scope Local | jq -r '.Policies[]|"\(.PolicyName) \(.Arn) \(.DefaultVersionId)"' | while read name arn version; 
# do 
#   aws iam get-policy-version --policy-arn $arn --version-id $version | jq -r '.PolicyVersion.Document.Statement[].Resource' | grep arn:aws:s3:::geofusion-core-data -q && ( echo $arn; aws iam list-entities-for-policy --policy-arn $arn | jq -r '.PolicyUsers[].UserName'; aws iam list-entities-for-policy --policy-arn $arn | jq -r '.PolicyGroups[].GroupName' | while read i; 
#   do 
#     aws iam get-group --group-name $i | jq -r '.Users[].UserName'; 
#   done); 
# done


# jq -r ".Reservations[] | .Instances[] | {InstanceId: .InstanceId, Tags: .Tags}" tmp/ec2.json
# jq -r ".Reservations[] | .Instances[] | {Tags: .Tags}" tmp/ec2.json
# jq -r ".Reservations[] | .Instances[] | .Tags[] | .Value" tmp/ec2.json

# aws ec2 describe-instances --region sa-east-1 --query "Reservations[*].Instances[*].[InstanceId].Tags[*].[Tags]" --output table
# aws ec2 describe-subnets --query "Subnets[*].[SubnetId,CidrBlock]" --output table

# aws ec2 describe-instances --region sa-east-1 --filters "Name=tag:Name,Values=$NAME" "Name=instance-state-name,Values=running" | jq -r ".Reservations[] | .Instances[] | .InstanceId" 

# jq -r '.Reservations[]|.Instances[]|[(.Tags[]?|select(.Key=="Name")|.Value), (.Tags[]?|select(.Key=="Group-Name")|.Value),.InstanceId,.PrivateIpAddress] tmp/ec2.json

# (.SecurityGroups[]? |.GroupId)] | @tsv' tmp/ec2.json) 

# jq -r '.Reservations[]|.Instances[]|[(.InstanceId),(.Tags[]? |select(.Key=="Name")|.Value),(.PrivateIpAddress),(.PublicIpAddress),(.SecurityGroups[]? |.GroupName),(.SecurityGroups[]? |.GroupId)] | @tsv' tmp/ec2.json
