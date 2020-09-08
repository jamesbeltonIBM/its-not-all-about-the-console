# this program lists VPC services that you already have

from ibm_vpc import VpcV1
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator
from ibm_cloud_sdk_core import ApiException

authenticator = IAMAuthenticator("<<your-api-key>>")
service = VpcV1('2020-06-02', authenticator=authenticator)

service.set_service_url('https://eu-gb.iaas.cloud.ibm.com/v1')

#  Listing VPCs
print("List VPCs")
try:
    vpcs = service.list_vpcs().get_result()['vpcs']
except ApiException as e:
  print("List VPC failed with status code " + str(e.code) + ": " + e.message)
for vpc in vpcs:
    print(vpc['id'], "\t",  vpc['name'])

#  Listing Subnets
print("List Subnets")
try:
    subnets = service.list_subnets().get_result()['subnets']
except ApiException as e:
  print("List subnets failed with status code " + str(e.code) + ": " + e.message)
for subnet in subnets:
    print(subnet['id'], "\t",  subnet['name'])

#  Listing Instances
print("List Instances")
try:
    instances = service.list_instances().get_result()['instances']
except ApiException as e:
  print("List instances failed with status code " + str(e.code) + ": " + e.message)
for instance in instances:
    print(instance['id'], "\t",  instance['name'])

instanceId = instances[0]['id']
instanceName = instances[0]['name']

