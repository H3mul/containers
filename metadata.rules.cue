import "encoding/yaml"

#Spec: {
    app:  #NonEmptyString
    upstream?: #Upstream
    builds: [...#Build]
}

#Upstream: #GithubUpstream | #AlpineLinuxUpstream | #UbuntuPackageUpstream

#AlpineLinuxUpstream: {
	apkbuild: #NonEmptyString
}

#GithubUpstream: {
    github: {
        repo: #NonEmptyString
    }
}

#UbuntuPackageUpstream: {
    ubuntu: {
        package: #NonEmptyString
        releases: #NonEmptyString
    }
}

#Build: {
    name: #NonEmptyString
    platforms: [...#AcceptedPlatforms]
    args?: [string]: string
}
#AcceptedPlatforms: "linux/amd64" | "linux/arm64"

#NonEmptyString: string & !=""
