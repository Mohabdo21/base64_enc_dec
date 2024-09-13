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

# Compile C code
function compile_c_code {
	local c_file="base64_enc_dec.c"
	local output_executable="base64_enc_dec_c"

	echo -e "${CYAN}Compiling C code...${NC}"
	gcc "$c_file" -o "$output_executable" || {
		echo -e "${RED}C compilation failed. Exiting...${NC}"
		exit 1
	}
	echo -e "${GREEN}C code compiled successfully!${NC}"
}

# Check if executable exists and is executable
function check_executable {
	local exec_path="$1"
	if [[ ! -f "$exec_path" ]]; then
		echo -e "${RED}$exec_path not found. Skipping...${NC}"
		return 1
	elif [[ ! -x "$exec_path" ]]; then
		echo -e "${YELLOW}$exec_path is not executable. Attempting to fix...${NC}"
		chmod +x "$exec_path" || {
			echo -e "${RED}Failed to make $exec_path executable. Skipping...${NC}"
			return 1
		}
	fi
	return 0
}

# Benchmark the encoding/decoding time
function benchmark_executable {
	local lang="$1" exec_path="$2" encoded_string start_time end_time duration total_duration

	echo -e "${WHITE}\n============================${NC}"
	echo -e "${CYAN}Running $lang Script:${NC}"
	echo -e "${WHITE}============================${NC}"

	# Encode
	echo -e "${YELLOW}Encoding with $lang...${NC}"
	start_time=$(date +%s%N)
	encoded_string=$("$exec_path" "encode" "$input_string")
	end_time=$(date +%s%N)
	duration=$(((end_time - start_time) / 1000000))
	echo -e "${GREEN}Encoded string: $encoded_string${NC}"
	echo -e "${CYAN}$lang encoding took $duration ms.${NC}"

	# Decode
	echo -e "${YELLOW}Decoding with $lang...${NC}"
	start_time=$(date +%s%N)
	"$exec_path" "decode" "$encoded_string"
	end_time=$(date +%s%N)
	total_duration=$((duration + ((end_time - start_time) / 1000000)))
	echo -e "${CYAN}$lang decoding took $((total_duration - duration)) ms.${NC}"
	echo -e "${WHITE}$lang total time (encode + decode) took $total_duration ms.${NC}"
}

# Compile and run benchmarks
compile_c_code

for lang in "${!executables[@]}"; do
	check_executable "${executables[$lang]}" && benchmark_executable "$lang" "${executables[$lang]}" || echo -e "${RED}Skipping $lang.${NC}"
done
