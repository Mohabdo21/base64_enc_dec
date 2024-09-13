package main

import (
	"encoding/base64"
	"flag"
	"fmt"
	"os"
)

// base64Encode encodes a string to base64.
func base64Encode(input string) string {
	return base64.StdEncoding.EncodeToString([]byte(input))
}

// base64Decode decodes a base64 string.
func base64Decode(input string) (string, error) {
	decodedBytes, err := base64.StdEncoding.DecodeString(input)
	if err != nil {
		return "", err
	}
	return string(decodedBytes), nil
}

// main function handles encoding and decoding based on arguments.
func main() {
	// Define flags
	operation := flag.String("operation", "", "The operation to perform ('encode' or 'decode').")
	input := flag.String("input", "", "The input string.")
	flag.Parse()

	// Ensure correct number of arguments
	if *operation == "" || *input == "" {
		fmt.Println("Usage: base64_enc_dec -operation <encode|decode> -input <string>")
		os.Exit(1)
	}

	var result string
	var err error

	switch *operation {
	case "encode":
		result = base64Encode(*input)
	case "decode":
		result, err = base64Decode(*input)
		if err != nil {
			fmt.Println("Error decoding base64 string:", err)
			os.Exit(1)
		}
	default:
		fmt.Println("Invalid operation. Usage: base64_enc_dec -operation <encode|decode> -input <string>")
		os.Exit(1)
	}

	fmt.Println(result)
}
