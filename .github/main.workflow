workflow "Build and Publish" {
  on = "push"
  resolves = "Publish"
}

action "gcloud Login" {
  uses = "./auth"
  secrets = [
    "GCLOUD_AUTH",
  ]
}

action "gcloud login to special user" {
  needs = ["gcloud Login"]
  uses = "./cli"
  args = "computed ssh 961493731298-compute@test-github-actionn"
  secrets = ["GCLOUD_AUTH"]
}

action "Publish" {
  needs = ["gcloud login to special user"]
  uses = "actions/action-builder/docker@master"
  runs = "cd php-mysql-ngnix-docker && git pull"
}
