module "shipping" {
    source = "git::https://dasarisaikrishna97@dev.azure.com/dasarisaikrishna97/Roboshop/_git/immutable//APP-module"
    env = var.env
    instance_type = var.instance_type
    component   = "shipping"
    port        = 8080
    is_internal = "true"
    priority    = 200
    APP_VERSION = var.APP_VERSION
}