#https://registry.terraform.io/modules/terraform-aws-modules/key-pair/aws/latest


resource "aws_key_pair" "my-pub-key" {
  key_name   = var.project
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD8mG0aOXTi25IZv99d2sJdlVAzL3T0bzHT7x934YX/xLmrcwW2DWaUdFyr7dFu9q60NBWra9cLTFiEHQtLqnWhMr5BeGpTzpELCh8CBHrOX2KJc0581RvmAbgRCEzCX/EuiN3uhuxpHPXzS1Uxo+DKFtk6SMNuIWP4QxpbNXqoDh8As7hvbKyvxVyrbWRuQcfdRh5pp14NgBmO/JxD/gFwlx+PskUjVslMSdhhika/q5HnNDUvbwEHKFxPCbb2tWI5HmZUj44d2nwFqq+gbS1lECdDqamb/r4N+Mitz26HQxDMOTrpsSLAcNQVF8OO6VGa2VohSLtW+mNGfvrWV+K+Fy4AASEr6W8ujKX45NgUHizAcDrF5NnXN+k2xwv4ZI7Vv31o9NbpGmAV88FrNlp8kZn806SUP8eZqJOC1lcVAm/y2+ooQxrnX2vSI8JL8HpzEP8wYfYB+j677VZsRoD2p4ngLFJb40Td+uYb6IzsUbFPhrdxuTpSdsVWE5B4O8= george@g-mbp.local"

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      Name = "${var.project}-keypair"
    }
  )
}