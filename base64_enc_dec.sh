#!/bin/bash

# A Simple script to encode and decode base64 strings to and from base64

# A function to encode a string to base64
function base64_encode() {
	local input_string="$1"
	echo -n "$input_string" | base64
}

# A function to decode a base64 string to plain text
function base64_decode() {
	local input_string="$1"
	local decoded_string
	if ! decoded_string=$(echo -n "$input_string" | base64 --decode 2>/dev/null); then
		echo "Decoding failed"
		exit 1
	fi
	echo "$decoded_string"
}

# The main function to parse the arguments and call the appropriate function
function main() {
	if [ "$#" -ne 2 ]; then
		echo "Usage: $0 <encode|decode> <string>"
		exit 1
	fi

	local operation="$1"
	local input_string="$2"

	case "$operation" in
	encode)
		base64_encode "$input_string"
		;;
	decode)
		base64_decode "$input_string"
		;;
	*)
		echo "Usage $0 <encode|decode> <string>"
		exit 1
		;;
	esac
}

main "$@"
