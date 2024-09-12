#!/usr/bin/env node

/**
 * Encodes a string to base64.
 *
 * @param {string} input - The input string.
 * @returns {string} - The base64 encoded string.
 */
function base64Encode(input) {
  return Buffer.from(input).toString("base64");
}

/**
 * Decodes a base64 string.
 *
 * @param {string} input - The base64 encoded string.
 * @returns {string} - The decoded string.
 */
function base64Decode(input) {
  return Buffer.from(input, "base64").toString("utf-8");
}

/**
 * Main function to handle encoding and decoding based on arguments.
 *
 * @param {string} operation - The operation to perform ('encode' or 'decode').
 * @param {string} input - The input string.
 * @returns {string} - The result of the encoding or decoding operation.
 */
function main(operation, input) {
  if (operation === "encode") {
    return base64Encode(input);
  } else if (operation === "decode") {
    return base64Decode(input);
  } else {
    throw new Error("Usage: ./base64_enc_dec.js <encode|decode> <string>");
  }
}

// Get command line arguments
const args = process.argv.slice(2);

// Ensure correct number of arguments
if (args.length !== 2) {
  console.error("Usage: ./base64_enc_dec.js <encode|decode> <string>");
  process.exit(1);
}

const operation = args[0];
const input = args[1];

try {
  const result = main(operation, input);
  console.log(result);
} catch (error) {
  console.error(error.message);
  process.exit(1);
}
