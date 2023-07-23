import "encoding/yaml"

#Spec: {
	app:  #NonEmptyString
	upstream?: #Upstream
	builds: [...#Build]
}

#Upstream: #GithubUpstream
#GithubUpstream: {
	github: {
		repo: #NonEmptyString
	}
}

#Build: {
	name: #NonEmptyString
	platforms: [...#AcceptedPlatforms]
	args?: [string]: string
}
#AcceptedPlatforms: "linux/amd64" | "linux/arm64"

#NonEmptyString: string & !=""
