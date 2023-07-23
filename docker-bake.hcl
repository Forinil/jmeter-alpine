variable "ALPINE_VERSION" {
  default = "latest"
}
variable "JMETER_VERSION" {
  default = "5.6.2"
}
variable "TAG" {
    default = "latest"
}

group "default" {
  targets = ["local"]
}

target "local" {
  tags = ["docker.io/forinil/jmeter-alpine:${TAG}"]
  args = {
    ALPINE_VERSION = "${ALPINE_VERSION}",
    JMETER_VERSION = "${JMETER_VERSION}"
  }
}

target "docker-metadata-action" {}

target "ci" {
  inherits = ["docker-metadata-action"]
  args = {
    ALPINE_VERSION = "${ALPINE_VERSION}",
    JMETER_VERSION = "${JMETER_VERSION}"
  }
  platforms = [
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64"
  ]
}