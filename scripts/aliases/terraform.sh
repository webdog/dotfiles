# terraform aliases
alias tfbuild="tflint && terraform fmt && terraform validate"
alias tfo="terraform output -json | jq -r"

