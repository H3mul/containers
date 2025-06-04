#Spec: {
    app:  #NonEmptyString
    version: #NonEmptyString
    builds: [...#Build]
}

#Build: {
    name: #NonEmptyString
    platforms: [...#AcceptedPlatforms]
    args?: [string]: string
}
#AcceptedPlatforms: "linux/amd64" | "linux/arm64"

#NonEmptyString: string & !=""
