output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "pub_subnet" {
  value = aws_subnet.pub_subnet
}

output "pri_subnet" {
  value = aws_subnet.pri_subnet
}

output "db_subnet" {
  value = aws_subnet.db_subnet
}

output "public_route_table" {
  value = aws_route_table.route_table_public
}

output "private_route_table" {
  value = aws_route_table.route_table_private
}

output "db_route_table" {
  value = aws_route_table.route_table_db
}