#!/bin/bash

# Colors for output
declare -A COLORS=(
	[GREEN]='\033[0;32m'
	[YELLOW]='\033[1;33m'
	[CYAN]='\033[0;36m'
	[RED]='\033[0;31m'
	[WHITE]='\033[1;37m'
	[NC]='\033[0m' # No Color
)

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
compile_c_code() {
	local c_file="base64_enc_dec.c"
	local output_executable="base64_enc_dec_c"

	echo -e "${COLORS[CYAN]}Compiling C code...${COLORS[NC]}"
	gcc "$c_file" -o "$output_executable" || {
		echo -e "${COLORS[RED]}C compilation failed. Exiting...${COLORS[NC]}"
		exit 1
	}
	echo -e "${COLORS[GREEN]}C code compiled successfully!${COLORS[NC]}"
}

# Check if executable exists and is executable
check_executable() {
	local exec_path="$1"
	if [[ ! -f "$exec_path" ]]; then
		echo -e "${COLORS[RED]}$exec_path not found. Skipping...${COLORS[NC]}"
		return 1
	elif [[ ! -x "$exec_path" ]]; then
		echo -e "${COLORS[YELLOW]}$exec_path is not executable. Attempting to fix...${COLORS[NC]}"
		chmod +x "$exec_path" || {
			echo -e "${COLORS[RED]}Failed to make $exec_path executable. Skipping...${COLORS[NC]}"
			return 1
		}
	fi
	return 0
}

# Benchmark the encoding/decoding time
benchmark_executable() {
	local lang="$1" exec_path="$2" encoded_string start_time end_time duration total_duration

	echo -e "${COLORS[WHITE]}\n============================${COLORS[NC]}"
	echo -e "${COLORS[CYAN]}Running $lang Script:${COLORS[NC]}"
	echo -e "${COLORS[WHITE]}============================${COLORS[NC]}"

	# Encode
	echo -e "${COLORS[YELLOW]}Encoding with $lang...${COLORS[NC]}"
	start_time=$(date +%s%N)
	encoded_string=$("$exec_path" "encode" "$input_string")
	end_time=$(date +%s%N)
	duration=$(((end_time - start_time) / 1000000))
	echo -e "${COLORS[GREEN]}Encoded string: $encoded_string${COLORS[NC]}"
	echo -e "${COLORS[CYAN]}$lang encoding took $duration ms.${COLORS[NC]}"

	# Decode
	echo -e "${COLORS[YELLOW]}Decoding with $lang...${COLORS[NC]}"
	start_time=$(date +%s%N)
	"$exec_path" "decode" "$encoded_string"
	end_time=$(date +%s%N)
	total_duration=$((duration + ((end_time - start_time) / 1000000)))
	echo -e "${COLORS[CYAN]}$lang decoding took $((total_duration - duration)) ms.${COLORS[NC]}"
	echo -e "${COLORS[WHITE]}$lang total time (encode + decode) took $total_duration ms.${COLORS[NC]}"
}

# Compile and run benchmarks
compile_c_code

for lang in "${!executables[@]}"; do
	check_executable "${executables[$lang]}" && benchmark_executable "$lang" "${executables[$lang]}" || echo -e "${COLORS[RED]}Skipping $lang.${COLORS[NC]}"
done
