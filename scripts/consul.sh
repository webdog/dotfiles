# Consul functions
# EXPERIMENTAL
# Query the Consul HTTP API
# Usage:
# capi kv/foo -p "hello world" - post request to endpoint
# capi catalog/services <-No method default to GET
function capi() {
  URL=$CONSUL_HTTP_ADDR
  TOKEN=$CONSUL_HTTP_TOKEN
  BASE_URL="${URL}/v1"
  ENDPOINT=$1
  TOKEN_HEADER="X-Consul-Token:${TOKEN}"
  while getopts ":p" o; do
    case $o in
      p)
        m=$OPTARG
        echo "m is ${OPTARG} or $m"
        ;;
      d)
        data=${OPTARG}
        [ -z $data ] && echo "data was blank"
        ;;
    esac
  done
  # post $p with data $d as non zero length
  if [ $m == "p" ] && [ -n  $data ]; then
    echo "found a put"
    http PUT "${BASE_URL}/${ENDPOINT}" "${TOKEN_HEADER}" $data
  # Set a get, or didn't pass the method? Assume get
  elif [ $m == "g" ] || [ -z $m ] && [ -z $d ]; then
    echo "found a get"
    http "${BASE_URL}/${ENDPOINT}" "${TOKEN_HEADER}"
  else
    echo "Something went wrong!"
  fi
}
