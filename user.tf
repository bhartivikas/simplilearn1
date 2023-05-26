/* access key, id and region will be passed through environment variables
*/

provider "aws" {
  
}

resource "aws_instance" "terraform_instance" {
   ami  = "ami-0607784b46cbe5816"
   instance_type = "t2.micro"
   key_key_name = "tf-key-pair"
   tags = {
     Name = "terraform_instance"

   } 
}
provisioner "remote-exec" {
    inline = [ "echo 'wait until SSH is ready'"]

   connconnection {
     type = "ssh"
     host = self.public_ip
     user = "ec2-user"
     private_key = file("./tf-key-pair")
   } 
}

provisioner "local-exec" {
   command = "ansible-playbook -i ${aws_instance.terraform_instance.ip}, --private-key ${"./tf-key-pair"} ansible_playbook.yml" 
}
  output "terraform_instance_ip" {
    value = aws_instance.terraform_instance.public_ip

  }
  




