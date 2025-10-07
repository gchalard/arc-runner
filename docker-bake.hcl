group "default" {
    targets = [
        "__default__"
    ]
}

variable "TAG" {}
variable "IMAGE" {
    default = "arc-custom-runner"
}
variable "OWNER" {
    default = "gchalard"
}

variable "REGISTRY" {
    default = "ghcr.io"
}

target "__default__" {
    dockerfile = "Dockerfile"
    context = "."
    tags = [
        "${REGISTRY}/${OWNER}/${IMAGE}:${TAG}",
        "${REGISTRY}/${OWNER}/${IMAGE}:latest"
    ]
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
    cache-from = [
        {
            type = "registry"
            ref = "${REGISTRY}/${OWNER}/${IMAGE}:cache"
        }
    ]
    cache-to = [
        {
            type = "registry"
            ref = "${REGISTRY}/${OWNER}/${IMAGE}:cache"
        }
    ]
}