//
//  NSDate+XPKit.h
//  XPKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 - 2015 Fabrizio Brancati. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "NSData+XPKit.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (XPKit)


+ (NSData *)dataWithBase64EncodedString:(NSString *)string {
	const char lookup[] = {
		99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,  99,  99,  99, 99,
		99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99,  99,  99,  99, 99,
		99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 99, 62,  99,  99,  99, 63,
		52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 99, 99,  99,  99,  99, 99,
		99, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12,  13, 14,
		15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 99,  99,  99,  99, 99,
		99, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38,  39, 40,
		41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 99,  99,  99,  99, 99
	};

	NSData *inputData = [string dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	long long inputLength = [inputData length];
	const unsigned char *inputBytes = [inputData bytes];

	long long maxOutputLength = (inputLength / 4 + 1) * 3;
	NSMutableData *outputData = [NSMutableData dataWithLength:(NSUInteger)maxOutputLength];
	unsigned char *outputBytes = (unsigned char *)[outputData mutableBytes];

	int accumulator = 0;
	long long outputLength = 0;
	unsigned char accumulated[] = { 0, 0, 0, 0 };

	for (long long i = 0; i < inputLength; i++) {
		unsigned char decoded = (unsigned char)lookup[inputBytes[i] & 0x7F];

		if (decoded != 99) {
			accumulated[accumulator] = decoded;

			if (accumulator == 3) {
				outputBytes[outputLength++] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);
				outputBytes[outputLength++] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);
				outputBytes[outputLength++] = (unsigned char)(accumulated[2] << 6) | accumulated[3];
			}

			accumulator = (accumulator + 1) % 4;
		}
	}

	//handle left-over data
	if (accumulator > 0) outputBytes[outputLength] = (unsigned char)(accumulated[0] << 2) | (accumulated[1] >> 4);

	if (accumulator > 1) outputBytes[++outputLength] = (unsigned char)(accumulated[1] << 4) | (accumulated[2] >> 2);

	if (accumulator > 2) outputLength++;

	//truncate data to match actual output length
	outputData.length = (NSUInteger)outputLength;
	return outputLength ? outputData : nil;
}

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth {
	//ensure wrapWidth is a multiple of 4
	wrapWidth = (wrapWidth / 4) * 4;

	const char lookup[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

	long long inputLength = [self length];
	const unsigned char *inputBytes = [self bytes];

	long long maxOutputLength = (inputLength / 3 + 1) * 4;
	maxOutputLength += wrapWidth ? (maxOutputLength / wrapWidth) * 2 : 0;
	unsigned char *outputBytes = (unsigned char *)malloc((size_t)maxOutputLength);

	long long i;
	long long outputLength = 0;

	for (i = 0; i < inputLength - 2; i += 3) {
		outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
		outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
		outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i + 1] & 0x0F) << 2) | ((inputBytes[i + 2] & 0xC0) >> 6)];
		outputBytes[outputLength++] = (unsigned char)lookup[inputBytes[i + 2] & 0x3F];

		//add line break
		if (wrapWidth && (outputLength + 2) % (wrapWidth + 2) == 0) {
			outputBytes[outputLength++] = '\r';
			outputBytes[outputLength++] = '\n';
		}
	}

	//handle left-over data
	if (i == inputLength - 2) {
		// = terminator
		outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
		outputBytes[outputLength++] = (unsigned char)lookup[((inputBytes[i] & 0x03) << 4) | ((inputBytes[i + 1] & 0xF0) >> 4)];
		outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i + 1] & 0x0F) << 2];
		outputBytes[outputLength++] =   '=';
	}
	else if (i == inputLength - 1) {
		// == terminator
		outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0xFC) >> 2];
		outputBytes[outputLength++] = (unsigned char)lookup[(inputBytes[i] & 0x03) << 4];
		outputBytes[outputLength++] = '=';
		outputBytes[outputLength++] = '=';
	}

	if (outputLength >= 4) {
		//truncate data to match actual output length
		outputBytes = realloc(outputBytes, (size_t)outputLength);
		return [[NSString alloc] initWithBytesNoCopy:outputBytes
		                                      length:(size_t)outputLength
		                                    encoding:NSASCIIStringEncoding
		                                freeWhenDone:YES];
	}
	else if (outputBytes) {
		free(outputBytes);
	}

	return nil;
}

- (NSString *)base64Decode {
	NSString *string = [self stringValue];
	NSData *data = [NSData dataWithBase64EncodedString:string];
	return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)hexValue {
	unsigned char *inbuf = (unsigned char *)[self bytes];
	NSMutableString *stringBuffer = [NSMutableString string];

	for (NSUInteger i = 0; i < [self length]; i++) {
		if (i != 0 && i % 16 == 0) [stringBuffer appendString:@"\n"];

		[stringBuffer appendFormat:@"0x%02X, ", inbuf[i]];
	}

	return stringBuffer;
}

- (NSString *)stringValue {
	NSString *buffer = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];

	return buffer;
}

- (NSString *)base64Encode {
	return [self base64EncodedStringWithWrapWidth:0];
}

- (NSString *)md5 {
	unsigned char result[CC_MD5_DIGEST_LENGTH];

	CC_MD5(self.bytes, (CC_LONG)self.length, result);
	NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

	for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[ret appendFormat:@"%02x", result[i]];
	}

	return ret;
}

- (NSData *)aesEncryptWithKey:(NSString *)key initialVector:(NSString *)iv {
	NSUInteger keyLength = [key length];

	if (keyLength != kCCKeySizeAES128 && keyLength != kCCKeySizeAES192 && keyLength != kCCKeySizeAES256) {
		return nil;
	}

	char keyBytes[keyLength + 1];
	bzero(keyBytes, sizeof(keyBytes));
	[key getCString:keyBytes maxLength:sizeof(keyBytes) encoding:NSUTF8StringEncoding];

	size_t numBytesEncrypted = 0;
	size_t encryptedLength = [self length] + kCCBlockSizeAES128;
	char *encryptedBytes = malloc(encryptedLength);

	CCCryptorStatus result = CCCrypt(kCCEncrypt,
	                                 kCCAlgorithmAES128,
	                                 (iv == nil ? kCCOptionECBMode | kCCOptionPKCS7Padding : kCCOptionPKCS7Padding),                                            //default: CBC (when initial vector is supplied)
	                                 keyBytes,
	                                 keyLength,
	                                 (__bridge const void *)(iv),
	                                 [self bytes],
	                                 [self length],
	                                 encryptedBytes,
	                                 encryptedLength,
	                                 &numBytesEncrypted);

	if (result != kCCSuccess)
		return nil;

	NSData *data = [NSData dataWithBytesNoCopy:encryptedBytes length:numBytesEncrypted];
	free(encryptedBytes);
	return data;
}

- (NSData *)aesDecryptWithKey:(NSString *)key initialVector:(NSString *)iv {
	NSUInteger keyLength = [key length];

	if (keyLength != kCCKeySizeAES128 && keyLength != kCCKeySizeAES192 && keyLength != kCCKeySizeAES256) {
		return nil;
	}

	char keyBytes[keyLength + 1];
	bzero(keyBytes, sizeof(keyBytes));
	[key getCString:keyBytes maxLength:sizeof(keyBytes) encoding:NSUTF8StringEncoding];

	size_t numBytesDecrypted = 0;
	size_t decryptedLength = [self length] + kCCBlockSizeAES128;
	char *decryptedBytes = malloc(decryptedLength);

	CCCryptorStatus result = CCCrypt(kCCDecrypt,
	                                 kCCAlgorithmAES128,
	                                 (iv == nil ? kCCOptionECBMode | kCCOptionPKCS7Padding : kCCOptionPKCS7Padding),                                            //default: CBC (when initial vector is supplied)
	                                 keyBytes,
	                                 keyLength,
	                                 (__bridge const void *)(iv),
	                                 [self bytes],
	                                 [self length],
	                                 decryptedBytes,
	                                 decryptedLength,
	                                 &numBytesDecrypted);

	if (result != kCCSuccess)
		return nil;

	NSData *data = [NSData dataWithBytesNoCopy:decryptedBytes length:numBytesDecrypted];
	free(decryptedBytes);
	return data;
}

- (NSString *)gb18030String {
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *str = [[NSString alloc] initWithData:self encoding:enc];

	if (!str) {
		str = [[NSString alloc]initWithData:[self dataByHealingGB18030Stream] encoding:enc];
	}

	return str;
}

- (NSData *)dataByHealingGB18030Stream {
	NSUInteger length = [self length];

	if (length == 0) {
		return self;
	}

	static NSString *replacementCharacter = @"?";
	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSData *replacementCharacterData = [replacementCharacter dataUsingEncoding:enc];

	NSMutableData *resultData = [NSMutableData dataWithCapacity:self.length];

	const Byte *bytes = [self bytes];

	static const NSUInteger bufferMaxSize = 1024;
	Byte buffer[bufferMaxSize];
	NSUInteger bufferIndex = 0;

	NSUInteger byteIndex = 0;
	BOOL invalidByte = NO;


#define FlushBuffer() if (bufferIndex > 0) { [resultData appendBytes:buffer length:bufferIndex]; bufferIndex = 0; }
#define CheckBuffer() if ((bufferIndex + 5) >= bufferMaxSize) { [resultData appendBytes:buffer length:bufferIndex]; bufferIndex = 0; }

	while (byteIndex < length) {
		Byte byte = bytes[byteIndex];

		//检查第一位
		if (byte >= 0 && byte <= (Byte)0x7f) {
			//单字节文字
			CheckBuffer();
			buffer[bufferIndex++] = byte;
		}
		else if (byte >= (Byte)0x81 && byte <= (Byte)0xfe) {
			//可能是双字节，可能是四字节
			if (byteIndex + 1 >= length) {
				//这是最后一个字节了，但是这个字节表明后面应该还有1或3个字节，那么这个字节一定是错误字节
				FlushBuffer();
				return resultData;
			}

			Byte byte2 = bytes[++byteIndex];

			if (byte2 >= (Byte)0x40 && byte <= (Byte)0xfe && byte != (Byte)0x7f) {
				//是双字节，并且可能合法
				unsigned char tuple[] = { byte, byte2 };
				CFStringRef cfstr = CFStringCreateWithBytes(kCFAllocatorDefault, tuple, 2, kCFStringEncodingGB_18030_2000, false);

				if (cfstr) {
					CFRelease(cfstr);
					CheckBuffer();
					buffer[bufferIndex++] = byte;
					buffer[bufferIndex++] = byte2;
				}
				else {
					//这个双字节字符不合法，但byte2可能是下一字符的第一字节
					byteIndex -= 1;
					invalidByte = YES;
				}
			}
			else if (byte2 >= (Byte)0x30 && byte2 <= (Byte)0x39) {
				//可能是四字节
				if (byteIndex + 2 >= length) {
					FlushBuffer();
					return resultData;
				}

				Byte byte3 = bytes[++byteIndex];

				if (byte3 >= (Byte)0x81 && byte3 <= (Byte)0xfe) {
					// 第三位合法，判断第四位

					Byte byte4 = bytes[++byteIndex];

					if (byte4 >= (Byte)0x30 && byte4 <= (Byte)0x39) {
						//第四位可能合法
						unsigned char tuple[] = { byte, byte2, byte3, byte4 };
						CFStringRef cfstr = CFStringCreateWithBytes(kCFAllocatorDefault, tuple, 4, kCFStringEncodingGB_18030_2000, false);

						if (cfstr) {
							CFRelease(cfstr);
							CheckBuffer();
							buffer[bufferIndex++] = byte;
							buffer[bufferIndex++] = byte2;
							buffer[bufferIndex++] = byte3;
							buffer[bufferIndex++] = byte4;
						}
						else {
							//这个四字节字符不合法，但是byte2可能是下一个合法字符的第一字节，回退3位
							//并且将byte1,byte2用?替代
							byteIndex -= 3;
							invalidByte = YES;
						}
					}
					else {
						//第四字节不合法
						byteIndex -= 3;
						invalidByte = YES;
					}
				}
				else {
					// 第三字节不合法
					byteIndex -= 2;
					invalidByte = YES;
				}
			}
			else {
				// 第二字节不是合法的第二位，但可能是下一个合法的第一位，所以回退一个byte
				invalidByte = YES;
				byteIndex -= 1;
			}

			if (invalidByte) {
				invalidByte = NO;
				FlushBuffer();
				[resultData appendData:replacementCharacterData];
			}
		}

		byteIndex++;
	}
	FlushBuffer();
	return resultData;
}

@end
