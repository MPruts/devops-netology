output "account_id" {
  value = data.aws_caller_identity.mytestcalleridentity.account_id
}

output "caller_user" {
  value = data.aws_caller_identity.mytestcalleridentity.user_id
}

output "region" {
  value = data.aws_region.mytestregion.name
}

/* output "ip_addr" {
  value = aws_instance.web.private_ip
}

output "id_network" {
  value = aws_instance.web.subnet_id
}*/