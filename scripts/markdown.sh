function h1 {
  cat $1 | grep -E "^# "
}
function h2 {
  cat $1 | grep -E "^## "
}

function h3 {
  cat $1 | grep -E "^### "
}

function h4 {
  cat $1 | grep -E "^# "
}


