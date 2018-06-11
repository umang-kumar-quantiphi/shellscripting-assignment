#client server
chmod 700 umang_production.sh
chmod 700 umang_jump.sh
scp -i shellscripting1.pem umang_production.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:/home/ec2-user/
scp -i shellscripting1.pem umang_jump.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:/home/ec2-user/
scp -i shellscripting1.pem umang_q1.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:/home/ec2-user/
scp -i shellscripting1.pem umang_q2.sh ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com:/home/ec2-user/
ssh -i shellscripting1.pem ec2-user@ec2-18-221-144-26.us-east-2.compute.amazonaws.com /home/ec2-user/umang_jump.sh




#jump server
mkdir umang
mv umang_q2.sh umang
mv umang_q1.sh umang
mv umang_production.sh umang
mv umang_jump.sh umang
cd umang
id=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names "shellscripting" --query 'AutoScalingGroups[0].Instances[0].InstanceId' --output text)
ip=$(aws ec2 describe-instances --instance-ids $id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)
scp umang_q1.sh ec2-user@$ip:/home/ec2-user/
scp umang_q2.sh ec2-user@$ip:/home/ec2-user/
scp umang_production.sh ec2-user@$ip:/home/ec2-user/
ssh -t -t ec2-user@$ip /home/ec2-user/umang_production.sh


#production server
mkdir umang
mv umang_q2.sh umang
mv umang_q1.sh umang
cd umang
sudo yum update
sudo yum install git
git init
git add *
git commit -m "First commit"
git remote add origin git@github.com:umang-kumar-quantiphi/shellscripting-assignment.git
git push -u origin master
