# this code uses the ibm_vpc client library
# the client library can be installed using:
# pip install --upgrade "ibm-vpc>=0.0.3"

from ibm_vpc import VpcV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_cloud_sdk_core import ApiException

# Authenticate to IBM Cloud, set the API endpoint 

authenticator = IAMAuthenticator("<<your-api-key>>")
service = VpcV1('2020-06-02', authenticator=authenticator)

service.set_service_url('https://eu-gb.iaas.cloud.ibm.com/v1')

# set the resource group - use the ibmcloud CLI command:
# ibmcloud resource groups
# to get the ID value of your resource group

resource_group_identity_model = {}
resource_group_identity_model['id'] = '<<your-resource-group-id>>'

# Create a new VPC

address_prefix_management = 'manual'
classic_access = False
new_vpc_name = input("Please enter a name for your VPC\n")
new_vpc_name = new_vpc_name.lower()
resource_group = resource_group_identity_model

vpc_count = 0

#  Listing VPCs
print("Just Checking this VPC  doesn't already exist.....")
try:
    vpcs = service.list_vpcs().get_result()['vpcs']
except ApiException as e:
  print("List VPC failed with status code " + str(e.code) + ": " + e.message)
for vpc in vpcs:
    if (vpc['name'] == new_vpc_name):
       print(vpc['id'], "\t",  vpc['name'])
       print("This VPC already exists")
       vpc_count=1
       vpc_id = vpc['id']
       quit()
 
if (vpc_count==0):
        print("Nope, doesn't exist.... Creating a new VPC named ", new_vpc_name)
        new_vpc = service.create_vpc(
        address_prefix_management=address_prefix_management,
        classic_access=classic_access,
        name=new_vpc_name,
        resource_group=resource_group,
        ).get_result()
        print('ID: ', new_vpc['id'], "\t",  'NAME :', new_vpc['name'])
        vpc_id = new_vpc['id']

# the VPC above was created without any IP address prefixes
# so this next code block creates one

new_prefix = input("Do you want to create a new Prefix now [Y/n] ")

if (new_prefix=='Y'):
      my_zone = input("Enter the zone number - 1, 2 or 3: ")
      my_zone = "eu-gb-" + my_zone
      cidr = input("Enter the CIDR block for the Prefix: ")

      zone_identity_model = {}
      zone_identity_model['name'] = my_zone
      zone = zone_identity_model
      is_default = True
      prefix_name = 'my-address-prefix'

      my_subnet = service.create_vpc_address_prefix(
         vpc_id,
         cidr,
         zone,
         is_default=is_default,
         name=prefix_name,
      )   

# Next, try adding a subnet and then a Virtual Server.... but I'll leave that to you!


