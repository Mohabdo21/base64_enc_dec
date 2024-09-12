#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BASE64_CHARS \
	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
#define BASE64_PADDING '='
#define INVALID_INPUT_ERROR -1

/* Lookup table for decoding base64 characters */
static const int base64_lookup[] = {
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /* 0-15 */
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, /* 16-31 */
	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, /* 32-47 */
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -2, -1, -1, /* 48-63 */
	-1, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10, 11, 12, 13, 14, /* 64-79 */
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, /* 80-95 */
	-1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, /* 96-111 */
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1 /* 112-127 */
};

int base64_encode(const char *input, char *output, int input_len);
int base64_decode(const char *input, char *output, int input_len);

/**
 * main - Main function.
 *
 * @argc: The number of arguments.
 * @argv: The arguments.
 * Return: The exit status.
 */
int main(int argc, char *argv[])
{
	char *input;
	char *output;
	int output_len;

	if (argc != 3)
	{
		printf("Usage: %s <encode|decode> <string>\n", argv[0]);
		return (1);
	}

	input = argv[2];

	/* Allocate output buffer based on operation */
	if (strcmp(argv[1], "encode") == 0)
	{
		/* Base64 encoded data needs more space */
		output = (char *)malloc((strlen(input) * 4 / 3) + 4);
	}
	else if (strcmp(argv[1], "decode") == 0)
	{
		/* Base64 decoded data is smaller */
		output = (char *)malloc(strlen(input) * 3 / 4 + 1);
	}
	else
	{
		printf("Usage: %s <encode|decode> <string>\n", argv[0]);
		return (1);
	}

	if (output == NULL)
	{
		printf("Memory allocation failed\n");
		return (1);
	}

	if (strcmp(argv[1], "encode") == 0)
	{
		output_len = base64_encode(input, output, strlen(input));
		output[output_len] = '\0';
		printf("%s\n", output);
	}
	else if (strcmp(argv[1], "decode") == 0)
	{
		output_len = base64_decode(input, output, strlen(input));
		if (output_len < 0)
		{
			printf("Decoding failed\n");
			free(output);
			return (1);
		}
		output[output_len] = '\0';
		printf("%s\n", output);
	}

	free(output);
	return (0);
}

/**
 * base64_encode - Encodes a string to base64.
 *
 * @input: The input string.
 * @output: The output string.
 * @input_len: The length of the input string.
 * Return: The length of the output string.
 */
int base64_encode(const char *input, char *output, int input_len)
{
	int i = 0, j = 0;
	unsigned char buffer[3];
	unsigned char encoded_buffer[4];
	int output_len = 0;

	while (i < input_len)
	{
		/* Fill buffer */
		buffer[0] = input[i++];
		buffer[1] = (i < input_len) ? input[i++] : 0;
		buffer[2] = (i < input_len) ? input[i++] : 0;

		/* Encode into 4 base64 chars */
		encoded_buffer[0] = (buffer[0] & 0xFC) >> 2;
		encoded_buffer[1] = ((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4);
		encoded_buffer[2] = ((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6);
		encoded_buffer[3] = buffer[2] & 0x3F;

		output[j++] = BASE64_CHARS[encoded_buffer[0]];
		output[j++] = BASE64_CHARS[encoded_buffer[1]];
		output[j++] = BASE64_CHARS[encoded_buffer[2]];
		output[j++] = BASE64_CHARS[encoded_buffer[3]];

		output_len += 4;
	}

	/* Padding if necessary */
	if (input_len % 3 == 1)
	{
		output[--j] = BASE64_PADDING;
		output[--j] = BASE64_PADDING;
	}
	else if (input_len % 3 == 2)
	{
		output[--j] = BASE64_PADDING;
	}

	return (output_len);
}

/**
 * base64_decode - Decodes a base64 string.
 *
 * @input: The input string.
 * @output: The output string.
 * @input_len: The length of the input string.
 * Return: The length of the output string, or -1 on failure.
 */
int base64_decode(const char *input, char *output, int input_len)
{
	int i = 0, j = 0;
	unsigned char buffer[4];
	unsigned char decoded_buffer[3];

	while (i < input_len)
	{
		int k = 0;

		/* Read 4 characters from input */
		for (k = 0; k < 4 && i < input_len; k++)
		{
			if (input[i] == BASE64_PADDING)
			{
				buffer[k] = 0;
			}
			else if ((unsigned char)input[i] > 127 ||
					base64_lookup[(int)(unsigned char)input[i]] == -1)
			{
				return (-1); /* Invalid character found */
			}
			else
			{
				buffer[k] = base64_lookup[(int)input[i]];
			}
			i++;
		}

		/* Decode the 4 base64 chars into 3 bytes */
		decoded_buffer[0] = (buffer[0] << 2) | ((buffer[1] & 0x30) >> 4);
		decoded_buffer[1] = ((buffer[1] & 0x0F) << 4) | ((buffer[2] & 0x3C) >> 2);
		decoded_buffer[2] = ((buffer[2] & 0x03) << 6) | (buffer[3] & 0x3F);

		/* Write decoded bytes to output */
		output[j++] = decoded_buffer[0];
		if (buffer[2] != 0)
			output[j++] = decoded_buffer[1];
		if (buffer[3] != 0)
			output[j++] = decoded_buffer[2];
	}

	return (j);
}
