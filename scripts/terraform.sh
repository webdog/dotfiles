# Audible alert when an apply or destroy has completed.
function tf {
  case $1 in
    "apply") shift
      terraform apply -auto-approve && say "deploy done"
      ;;
    "destroy") shift
      terraform destroy -auto-approve &&  say "destroy done"
      ;;
  esac
}
