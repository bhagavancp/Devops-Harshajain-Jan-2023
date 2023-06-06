import boto3
import pprint
from operator import attrgetter

ec2 = boto3.resource('ec2')

client = boto3.client('ec2')
Myec2=client.describe_instances()

def list_ec2_by_tag(ec2_tag):
    response = client.describe_instances(Filters=ec2_tag)
    ec2_ids = []
    for pythonins in response['Reservations']:
        for instances in pythonins['Instances']:
            if (instances['State'])['Name'] != 'terminated':
                # pprint.pprint((instances['State'])['Name'])
                ec2_ids.append(instances['InstanceId'])
    return ec2_ids            
                # pprint.pprint(instances['Tags'][0])

def check_ami(ami_name):
    images = client.describe_images(Owners=['self'])
    if images['Images']:
        for image in images['Images']:
            if ami_name == image['Name']:
                return { 'status': False, 'ImageId': image['ImageId'] }
            else:
                return { 'status': True, 'ImageId': '' } 
    else:
        return { 'status': True, 'ImageId': '' }                        

def create_ami_from_ec2(ec2_tag, ami_name):
    count = 0 
    ec2_found = list_ec2_by_tag(ec2_tag)
    if len(ec2_found) < 1:
        print('There are no ec2 instance with tag to create ami')  
        exit()  
    else:    
        for instance in ec2_found:
            count = count + 1
            ami_name_new = ami_name + '_' + str(count)
            if (check_ami(ami_name_new))['status']:
                print(f'Creating ami {ami_name} for {instance}')
                response = client.create_image(InstanceId=instance, NoReboot=True, Name=ami_name_new, Description=ami_name)
                print(f'AMI {response["ImageId"]} successfully created')
            else:
                print(f'AMI {(check_ami(ami_name_new))["ImageId"]} already exists')    

# print(check_ami('test-ami'))

def delete_all_ami():
    images = client.describe_images(Owners=['self'])
    for image in images['Images']:
        # image = ec2.Image()
        ami = list(ec2.images.filter(ImageIds=[str(image['ImageId'])]).all())[0]
        ami.deregister()
        print(f'AMI {image["ImageId"]} successfully deregistered')


# ec2_instance tag to which AMI need to be created 
ec2_tag = [{
    'Name':'tag:Name', 
    'Values': ['Jenkins-master']}]

# Name of the ami to be created 
# If multiple ec2_instances found, then ami_name will be suffixed with _1, _2 .....
ami_name = 'test-ami'

# create - creates AMI of ec2_instance with the above tag and name of the ami will be ami_name
# delete - delete all the AMI associated with the user account.
run_type = 'create'

if run_type == 'create':
    create_ami_from_ec2(ec2_tag, ami_name)
elif run_type == 'delete':    
    delete_all_ami()
