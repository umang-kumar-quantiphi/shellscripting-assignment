#!bin/bash
instance1_id=$( aws ec2 run-instances --image-id ami-14c5486b  --count 1 --instance-type t2.micro --key-name PE_Umang_1 --iam-instance-profile Name=PE_trainee_Admin_role --region us-east-1  --user-data '#!bin/bash; touch t12.txt; aws s3 cp t12.txt s3://umang01//' --query 'Instances[0].InstanceId')
exists=$(aws s3 ls s3://umang01//t12.txt)
echo Uploading FIle....
while [ -z "$exists" ]
do
sleep 5
exists=$(aws s3 ls s3://umang01//t12.txt)
done
echo Upload complete!
instance2_id=$( aws ec2 run-instances --image-id ami-14c5486b  --count 1 --instance-type t2.micro --key-name PE_Umang_1 --iam-instance-profile Name=PE_trainee_Admin_role --region us-east-1  --user-data '#!bin/bash; aws s3 cp s3://umang01//t12.txt t12.txt' --query 'Instances[0].InstanceId')