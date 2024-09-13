package main

import (
	"encoding/base64"
	"flag"
	"fmt"
	"os"
)

// Base64Processor defines a structure for Base64 encoding/decoding operations.
type Base64Processor struct {
	Operation string
	Input     string
}

// NewBase64Processor creates a new instance of Base64Processor.
func NewBase64Processor(operation, input string) *Base64Processor {
	return &Base64Processor{
		Operation: operation,
		Input:     input,
	}
}

// Encode encodes the input string to Base64.
func (b *Base64Processor) Encode() string {
	return base64.StdEncoding.EncodeToString([]byte(b.Input))
}

// Decode decodes a Base64 encoded string.
func (b *Base64Processor) Decode() (string, error) {
	decodedBytes, err := base64.StdEncoding.DecodeString(b.Input)
	if err != nil {
		return "", err
	}
	return string(decodedBytes), nil
}

// Execute performs the specified operation based on the Base64Processor's state.
func (b *Base64Processor) Execute() (string, error) {
	switch b.Operation {
	case "encode":
		return b.Encode(), nil
	case "decode":
		return b.Decode()
	default:
		return "", fmt.Errorf("invalid operation: %s", b.Operation)
	}
}

// main function parses command-line arguments and runs the Base64Processor.
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

	processor := NewBase64Processor(*operation, *input)
	result, err := processor.Execute()
	if err != nil {
		fmt.Println("Error:", err)
		os.Exit(1)
	}

	fmt.Println(result)
}
