#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# String to encode
input_string="Hello, this is a test string for base64 encoding and decoding."

# Executable paths
declare -A executables=(
	["C"]="./base64_enc_dec_c"
	["Python"]="./base64_enc_dec.py"
	["Ruby"]="./base64_enc_dec.rb"
	["JavaScript"]="./base64_enc_dec.js"
	["Bash"]="./base64_enc_dec.sh"
)

# Compile the C code
function compile_c_code {
	local c_file="base64_enc_dec.c"
	local output_executable="base64_enc_dec_c"

	echo -e "${CYAN}\nCompiling C code...${NC}"

	gcc "$c_file" -o "$output_executable"

	if [ $? -ne 0 ]; then
		echo -e "${RED}C code compilation failed. Exiting...${NC}"
		exit 1
	fi

	echo -e "${GREEN}C code compiled successfully!${NC}"
}

# Check if executable is present and handle errors gracefully
function check_executable {
	if [ ! -f "$1" ]; then
		echo -e "${RED}$1 not found. Skipping...${NC}"
		return 1
	elif [ ! -x "$1" ]; then
		echo -e "${YELLOW}$1 found but is not executable. Trying to make it executable...${NC}"
		chmod +x "$1"

		# Recheck
		if [ ! -x "$1" ]; then
			echo -e "${RED}Failed to make $1 executable. Skipping...${NC}"
			return 1
		else
			echo -e "${GREEN}$1 is now executable.${NC}"
		fi
	fi
	return 0
}

# Measure execution time for encoding/decoding
function benchmark_executable {
	local lang="$1"
	local exec_path="$2"
	local encoded_string

	echo -e "${WHITE}\n============================${NC}"
	echo -e "${CYAN}Running $lang Script:${NC}"
	echo -e "${WHITE}============================${NC}"

	# Encode the input_string
	echo -e "${YELLOW}Encoding with $lang...${NC}"

	# Measure encoding time
	start_time=$(date +%s%N)
	encoded_string=$("$exec_path" "encode" "$input_string")
	end_time=$(date +%s%N)
	encoding_duration=$(((end_time - start_time) / 1000000))

	echo -e "${GREEN}Encoded string: $encoded_string${NC}"
	echo -e "${CYAN}$lang encoding took $encoding_duration ms.${NC}"

	# Decode the encoded string
	echo -e "${YELLOW}Decoding with $lang...${NC}"

	# Measure decoding time
	start_time=$(date +%s%N)
	"$exec_path" "decode" "$encoded_string"
	end_time=$(date +%s%N)
	decoding_duration=$(((end_time - start_time) / 1000000))

	echo -e "${CYAN}$lang decoding took $decoding_duration ms.${NC}"

	# Output total time
	total_duration=$((encoding_duration + decoding_duration))
	echo -e "${WHITE}$lang total time (encode + decode) took $total_duration ms.${NC}"
}

# Compile C code first
compile_c_code

# Check and run all executables, logging errors and continuing
for lang in "${!executables[@]}"; do
	if check_executable "${executables[$lang]}"; then
		benchmark_executable "$lang" "${executables[$lang]}"
	else
		echo -e "${RED}Skipping $lang due to errors.${NC}"
	fi
done
