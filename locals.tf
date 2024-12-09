locals {
  vpc_name = "expense-${var.environment}"
  ig_name = "ig-expense-${var.environment}"
  az_name = slice(data.aws_availability_zones.available.names, 0, 2)
  resource_name = "${var.project}-${var.environment}"
}
