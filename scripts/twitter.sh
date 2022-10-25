# twitter functions
# Get a twitter embed URL by passing a link.
function tembed() {
	http https://publish.twitter.com/oembed\?url\=$1 | jq -r .html
}
