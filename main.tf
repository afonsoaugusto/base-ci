data "aws_ec2_transit_gateway" "example" {
  filter {
    name   = "amazon-side-asn"
    values = ["64512"]
  }
}