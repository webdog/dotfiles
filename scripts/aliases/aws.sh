# aws aliases
alias awslogpaths="aws logs describe-log-groups | jq '.logGroups[].logGroupName'"
alias awsregion="aws configure set default.region"
alias cpaws="cat ~/.aws/credentials | pbcopy"
alias amzn_al2_ami="aws ssm get-parameters --names /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 --region us-east-1 | jq '.Parameters[0].Value'"
alias awscreds='unset AWS_ACCESS_KEY_ID; unset AWS_SECRET_ACCESS_KEY; doormat --smoke-test || doormat -r && doormat aws -m -a education_internal_dev'
