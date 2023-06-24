module "frontend"{
    source = "./ec2"
    name = "frondend"
}

module "mongodb"{
    source = "./ec2"
    name = "mongodb"
}

module "catalogue"{
    source = "./ec2"
    name = "catalogue"
}

module "mysql"{
    source = "./ec2"
    name = "mysql"
}

module "cart"{
    source = "./ec2"
    name = "cart"
}

module "shipping"{
    source = "./ec2"
    name = "shipping"
}

module "redis"{
    source = "./ec2"
    name = "redis"
}

module "rabbitmq"{
    source = "./ec2"
    name = "rabbitmq"
}

module "dispatch"{
    source = "./ec2"
    name = "dispatch"
}

module "user"{
    source = "./ec2"
    name = "user"
}

