#Spec: {
    app:  #NonEmptyString
    version: #NonEmptyString
    builds: [...#Build]
    image?: #Image
}

#Image: {
    registry?: #Registry
}

#Registry: "ghcr.io" | "docker.io"

#Build: {
    name: #NonEmptyString
    platforms: [...#AcceptedPlatforms]
    args?: [string]: string
}
#AcceptedPlatforms: "linux/amd64" | "linux/arm64"

#NonEmptyString: string & !=""
