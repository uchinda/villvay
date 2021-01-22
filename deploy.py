import os
import sys
from dotenv import load_dotenv
from python_terraform import *
import uuid
import json

# Change Directory
class cd:
    def __init__(self, newPath):
        self.newPath = os.path.expanduser(newPath)
    
    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)
    
    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

# Docker Image URL
def docker_url():
    UUID = uuid.uuid4()
    url = "public.ecr.aws/k9b4t6f8/111960289902/villvay-assessment-nginx:" + str(UUID)
    return url

# Build New Docker Images with New Content and Push to Repo
def docker_build(tag):
    with cd('Docker'):
        os.system('aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/k9b4t6f8')
        os.system('docker build -f Dockerfile -t ' + tag + ' .')
        os.system('docker push ' + tag)

# Change Docker Image Tag according to the build in container.json
def change_container_image(tag):
    with cd('villvay-terraform'):
        f_open = open('template_container.json', 'r')
        current_data = f_open.read()
        f_open.close()
        
        new_data = current_data.replace('TAG', tag)
        
        f_write = open('container.json', 'w')
        f_write.write(new_data)
        f_write.close()
        
## Terraform Block
# Terraform Init
def terraform_init(tf):
    return_code, init_out, stderr = tf.init_cmd(capture_output=False)
    
# Terraform Plan
def terraform_plan(tf):
    return_code, plan_out, stderr = tf.plan_cmd(capture_output=False)
    
# Terraform Apply
def terraform_apply(tf):
    return_code, apply_out, stderr = tf.apply_cmd(capture_output=False, auto_approve=True)
    
def main():
    # initializing terraform working directory
    tf = Terraform(working_dir='villvay-terraform')
    
    # creating docker tag for every new deployment
    print('Generating Docker Tag.....')
    tag = docker_url()
    print('New Docker Tag: ' + str(tag) + '\n')
    
    # Build docker image
    docker_build(tag)
    
    # Change container.json with newly created docker image
    change_container_image(tag)
    
    # Infrastructure creating and Deploying
    terraform_init(tf) 
    terraform_plan(tf)
    terraform_apply(tf)
    
# Run main function.
if __name__ == "__main__":
    main()