# Creates an SSH session to an ECS container when SSM is enabled.
# Usage: ssm-ssh <ecs_container_name> <ecs_task_id>
function ssm-ssh { aws ecs execute-command --region us-east-1 --cluster clust1 --task $2 --container $1 --command "/bin/sh" --interactive
}

# Usage: ct attribute_id
function ct { 
	aws cloudtrail lookup-events --lookup-attributes AttributeKey=Username,AttributeValue=$1 --max-results=10 | jq -r '.Events[].CloudTrailEvent' | jq
}

# Usage altail /some/cw/path -f
# Watch an AWS logs path, in real time or not.
function altail {
	case $3 in 
		"-f") shift
			aws logs tail $1 --follow
			;;
		*) shift
			aws logs tail $1
	esac
}
