terraform {
  required_providers {
    hashicups = {
      version = "0.2"
      source  = "hashicorp.com/edu/hashicups"
    }
  }
}

provider "hashicups" {
  username = "education"
  password = "test123"
}

#list coffies
module "psl" {
  source = "./coffee"

  coffee_name = "Packer Spiced Latte"
}

#output "psl" {
#  value = module.psl.coffee
#}

#list orders
data "hashicups_order" "order" {
  id = 1
}

#output "order" {
#  value = data.hashicups_order.order
#}

#create order
resource "hashicups_order" "edu" {
  items {
    coffee {
      id = 3
    }
    quantity = 2
  }
  items {
    coffee {
      id = 2
    }
    quantity = 2
  }
}

output "edu_order" {
  value = hashicups_order.edu
}

