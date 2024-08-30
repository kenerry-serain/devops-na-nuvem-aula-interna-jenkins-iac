resource "aws_ecr_repository" "this" {
  name                 = "jenkins/production/frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}
