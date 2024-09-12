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

## Overview

This repository contains implementations of Base64 encoding and decoding in multiple programming languages. Each script provides
functionality to encode a given string to Base64 and decode a Base64-encoded string back to its original form.

## Files

- `base64_enc_dec.c` - C implementation
- `base64_enc_dec.js` - JavaScript implementation
- `base64_enc_dec.py` - Python implementation
- `base64_enc_dec.rb` - Ruby implementation
- `base64_enc_dec.sh` - Bash implementation

## Usage

Make sure you have the required runtime installed on your system before running the scripts.
Make sure all scripts have executable permissions except for the C program:

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
