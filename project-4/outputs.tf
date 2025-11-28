/*output "ec2_public_ip"{

    value = aws_instance.rk-ec2[*].public_ip #if count is more the add [*] else not
}



output "ec2_private_dns"{

    value = aws_instance.rk-ec2[*].private_dns
}*/

#for_each output

output "ec2_public_ip"{
     value = [
        for k in aws_instance.rk-ec2 : k.public_ip
     ]

}