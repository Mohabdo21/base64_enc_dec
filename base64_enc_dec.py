#!/usr/bin/env python3.12
"""
A professional Python script to encode and decode strings to and from
base64 using a Singleton pattern.
"""

import base64
import sys


class Base64Singleton:
    """Singleton class for encoding and decoding base64."""

    _instance = None

    def __new__(cls):
        """
        Create a new instance if one does not exist,
        else return the existing instance.
        """
        if cls._instance is None:
            cls._instance = super().__new__(cls)
        return cls._instance

    def encode(self, input_string: str) -> str:
        """Encodes a string to base64."""
        encoded_bytes = base64.b64encode(input_string.encode())
        return encoded_bytes.decode()

    def decode(self, input_string: str) -> str:
        """Decodes a base64-encoded string."""
        try:
            decoded_bytes = base64.b64decode(input_string)
            return decoded_bytes.decode()
        except (base64.binascii.Error, UnicodeDecodeError):
            return None


def parse_arguments():
    """Parse command-line arguments."""
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <encode|decode> <string>")
        sys.exit(1)
    return sys.argv[1], sys.argv[2]


def main():
    """Main function to handle encoding and decoding based on CLI arguments."""
    operation, input_string = parse_arguments()

    base64_instance = Base64Singleton()

    if operation == "encode":
        print(base64_instance.encode(input_string))
    elif operation == "decode":
        decoded = base64_instance.decode(input_string)
        if decoded is None:
            print("Decoding failed")
            sys.exit(1)
        print(decoded)
    else:
        print(f"Usage: {sys.argv[0]} <encode|decode> <string>")
        sys.exit(1)


if __name__ == "__main__":
    main()
