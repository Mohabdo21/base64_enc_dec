# Base64 Encoder/Decoder

A collection of scripts to encode and decode strings to and from Base64 in various programming languages.

## Table of Contents

- [Overview](#overview)
- [Files](#files)
- [Usage](#usage)
  - [C](#c)
  - [JavaScript](#javascript)
  - [Python](#python)
  - [Ruby](#ruby)
  - [Bash](#bash)
  - [Go](#go)
- [Benchmarking Script](#benchmarking-script)

## Overview

This repository contains implementations of Base64 encoding and decoding in multiple programming languages. Each script provides
functionality to encode a given string to Base64 and decode a Base64-encoded string back to its original form.

## Files

- `base64_enc_dec.c` - C implementation
- `base64_enc_dec.js` - JavaScript implementation
- `base64_enc_dec.py` - Python implementation
- `base64_enc_dec.rb` - Ruby implementation
- `base64_enc_dec.sh` - Bash implementation
- `base64_enc_dec.go` - Go implementation

## Usage

Make sure you have the required runtime installed on your system before running the scripts.
Make sure all scripts have executable permissions except for the C & Go programs:

```sh
chmod +x base64_enc_dec.*
```

### C

Compile the C program using `gcc`:

```sh
gcc -o base64_enc_dec base64_enc_dec.c
```

Run the program:

```sh
./base64_enc_dec encode "your_string"
./base64_enc_dec decode "your_base64_string"
```

### JavaScript

Ensure you have installed `node`:

```sh
./base64_enc_dec.js encode "your_string"
./base64_enc_dec.js decode "your_base64_string"
```

### Python

Ensure you have installed `python3.12`:

```sh
./base64_enc_dec.py encode "your_string"
./base64_enc_dec.py decode "your_base64_string"
```

### Ruby

Ensure you have installed `ruby`:

```sh
./base64_enc_dec.rb encode "your_string"
./base64_enc_dec.rb decode "your_base64_string"
```

### Bash

Run the Bash script:

```sh
./base64_enc_dec.sh encode "your_string"
./base64_enc_dec.sh decode "your_base64_string"
```

### Go

Build the Go executable using `go build`:

```sh
go build -o base64_enc_dec base64_enc_dec.go
```

Run the program:

```sh
./base64_enc_dec -operation encode -input "your_string"
./base64_enc_dec -operation decode -input "your_base64_string"
```

## Benchmarking Script

This repository includes a benchmarking script, `benchmark_base64.sh`, which allows you to compare the performance of Base64 encoding and decoding across multiple programming languages. The script executes implementations in C, Python, Ruby, JavaScript, Bash, and Go, measuring the time taken to encode and decode a sample string in each language.

### Running the Benchmark

To use the benchmarking script, ensure that all necessary runtime environments and dependencies are installed. The script will compile the C program and build the Go executable automatically and attempt to run each language's script. It also checks if the scripts are executable and makes them executable if necessary.

To run the benchmark:

```sh
./benchmark_base64.sh
```

This benchmarking script provides insight into the relative performance of Base64 encoding and decoding across different languages.
