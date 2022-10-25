# Pull a Docker image from the public ECR reposistory
function dawker() {
	# dawker pull amazonlinux/amazonlinux:latest
	case $1 in
		"pull") shift
			# docker pull public.ecr.aws/amazonlinux/amazonlinux:latest
			docker pull public.ecr.aws/$1
			;;
    *)
      echo "You didn't pass an image name. Try again"
	esac
}
