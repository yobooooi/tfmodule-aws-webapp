output "autoscaling_group_id" {
    value = aws_autoscaling_group.webapp_asg.id
}

output "launch_configuration_id" {
    value = aws_autoscaling_group.webapp_asg.launch_configuration
}

output "aws_ami_id" {
    value = data.aws_ami.webapp_ami.id
}

output "aws_ami_name" {
    value = data.aws_ami.webapp_ami.name
}