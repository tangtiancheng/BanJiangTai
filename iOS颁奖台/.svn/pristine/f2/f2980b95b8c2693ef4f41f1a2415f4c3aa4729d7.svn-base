//
//  UIDevice+XPKit.m
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

#import "UIDevice+XPKit.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <sys/types.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <sys/time.h>
#import <netinet/in.h>
#import <net/if_dl.h>
#import <netdb.h>
#import <errno.h>
#import <arpa/inet.h>
#import <unistd.h>
#import <CommonCrypto/CommonDigest.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <net/if.h>
#import <MessageUI/MessageUI.h>

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreMotion/CoreMotion.h>
#import <SystemConfiguration/SystemConfiguration.h>

#include <mach/mach.h>
#include <mach/mach_host.h>

static NSString *const XPUniqueIdentifierDefaultsKey = @"XPUniqueIdentifier";

@implementation UIDevice (XPKit)

+ (NSString *)devicePlatform {
	size_t size;
	sysctlbyname("hw.machine", NULL, &size, NULL, 0);
	char *machine = malloc(size);
	sysctlbyname("hw.machine", machine, &size, NULL, 0);
	NSString *platform = [NSString stringWithUTF8String:machine];
	free(machine);
	return platform;
}

+ (NSString *)devicePlatformString {
	NSString *platform = [self devicePlatform];
	// iPhone
	if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
	if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
	if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
	if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
	if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (CDMA)";
	if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
	if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (GSM)";
	if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (CDMA)";
	if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5C (GSM)";
	if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5C (Global)";
	if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5S (GSM)";
	if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5S (Global)";
	if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
	if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
	// iPod
	if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
	if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
	if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
	if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
	if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
	// iPad
	if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1";
	if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
	if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2 (GSM)";
	if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
	if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2 (32nm)";
	if ([platform isEqualToString:@"iPad2,5"]) return @"iPad mini (WiFi)";
	if ([platform isEqualToString:@"iPad2,6"]) return @"iPad mini (GSM)";
	if ([platform isEqualToString:@"iPad2,7"]) return @"iPad mini (CDMA)";
	if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
	if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3 (CDMA)";
	if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3 (GSM)";
	if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
	if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4 (GSM)";
	if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4 (CDMA)";
	if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
	if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
	if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air (China)";
	if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2 (WiFi)";
	if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2 (Cellular)";
	// iPad mini
	if ([platform isEqualToString:@"iPad4,4"]) return @"iPad mini 2 (WiFi)";
	if ([platform isEqualToString:@"iPad4,5"]) return @"iPad mini 2 (Cellular)";
	if ([platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2 (China)";
	if ([platform isEqualToString:@"iPad4,7"]) return @"iPad mini 3 (WiFi)";
	if ([platform isEqualToString:@"iPad4,8"]) return @"iPad mini 3 (Cellular)";
	if ([platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3 (China)";
	// Simulator
	if ([platform isEqualToString:@"i386"]) return @"Simulator";
	if ([platform isEqualToString:@"x86_64"]) return @"Simulator";
	return platform;
}

+ (NSString *)localIPAddress {
	NSString *localIP = nil;
	struct ifaddrs *addrs;

	if (getifaddrs(&addrs) == 0) {
		const struct ifaddrs *cursor = addrs;

		while (cursor != NULL) {
			if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0) {
				//NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
				//if ([name isEqualToString:@"en0"]) // Wi-Fi adapter
				{
					localIP = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];
					break;
				}
			}

			cursor = cursor->ifa_next;
		}
		freeifaddrs(addrs);
	}

	return localIP;
}

+ (BOOL)isiPad {
	if ([[[self devicePlatform] substringToIndex:4] isEqualToString:@"iPad"])
		return YES;
	else
		return NO;
}

+ (BOOL)isiPhone {
	if ([[[self devicePlatform] substringToIndex:6] isEqualToString:@"iPhone"])
		return YES;
	else
		return NO;
}

+ (BOOL)isiPod {
	if ([[[self devicePlatform] substringToIndex:4] isEqualToString:@"iPod"])
		return YES;
	else
		return NO;
}

+ (BOOL)isSimulator {
	if ([[self devicePlatform] isEqualToString:@"i386"] || [[self devicePlatform] isEqualToString:@"x86_64"])
		return YES;
	else
		return NO;
}

+ (BOOL)isRetina {
	if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0 || [UIScreen mainScreen].scale == 3.0))
		return YES;
	else
		return NO;
}

+ (BOOL)isRetinaHD {
	if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 3.0))
		return YES;
	else
		return NO;
}

+ (BOOL)checkConnection:(SCNetworkReachabilityFlags *)flags {
	struct sockaddr_in zeroAddress;

	bzero(&zeroAddress, sizeof(zeroAddress));
	zeroAddress.sin_len = sizeof(zeroAddress);
	zeroAddress.sin_family = AF_INET;

	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, flags) ? YES : NO;
	CFRelease(defaultRouteReachability);

	if (!didRetrieveFlags) return NO;

	return YES;
}

+ (BOOL)connectedToNetwork {
	SCNetworkReachabilityFlags flags;

	if (![self checkConnection:&flags]) return NO;

	BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkReachabilityFlagsConnectionRequired;

	return (isReachable && !needsConnection) ? YES : NO;
}

+ (BOOL)connectedToWiFi {
	SCNetworkReachabilityFlags flags;

	if (![self checkConnection:&flags]) return NO;

	BOOL isReachable = flags & kSCNetworkReachabilityFlagsReachable;
	BOOL needsConnection = flags & kSCNetworkReachabilityFlagsConnectionRequired;
	BOOL cellConnected = flags & kSCNetworkReachabilityFlagsTransientConnection;

	return (isReachable && !needsConnection && !cellConnected) ? YES : NO;
}

+ (NSInteger)iOSVersion {
	return [[[UIDevice currentDevice] systemVersion] integerValue];
}

+ (NSUInteger)getSysInfo:(uint)typeSpecifier {
	size_t size = sizeof(int);
	int results;
	int mib[2] = { CTL_HW, typeSpecifier };
	sysctl(mib, 2, &results, &size, NULL, 0);
	return (NSUInteger)results;
}

+ (NSUInteger)cpuFrequency {
	return [self getSysInfo:HW_CPU_FREQ];
}

+ (NSUInteger)busFrequency {
	return [self getSysInfo:HW_BUS_FREQ];
}

+ (NSUInteger)ramSize {
	return [self getSysInfo:HW_MEMSIZE];
}

+ (NSUInteger)cpuNumber {
	return [self getSysInfo:HW_NCPU];
}

+ (NSUInteger)totalMemory {
	return [self getSysInfo:HW_PHYSMEM];
}

+ (NSUInteger)userMemory {
	return [self getSysInfo:HW_USERMEM];
}

+ (NSNumber *)totalDiskSpace {
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemSize];
}

+ (NSNumber *)freeDiskSpace {
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSString *)macAddress {
	int mib[6];
	size_t len;
	char *buf;
	unsigned char *ptr;
	struct if_msghdr *ifm;
	struct sockaddr_dl *sdl;

	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;

	if ((mib[5] = if_nametoindex("en0")) == 0) {
		printf("Error: if_nametoindex error\n");
		return NULL;
	}

	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 1\n");
		return NULL;
	}

	if ((buf = malloc(len)) == NULL) {
		printf("Could not allocate memory. Rrror!\n");
		return NULL;
	}

	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
		printf("Error: sysctl, take 2");
		return NULL;
	}

	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
	                       *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
	// NSString *outstring = [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X",
	//                       *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);

	return outstring;
}

+ (NSString *)uniqueIdentifier {
	NSString *uuid;
	if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)]) {
		uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
	}
	else {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		uuid = [defaults objectForKey:XPUniqueIdentifierDefaultsKey];
		if (!uuid) {
			uuid = [self generateUUID];
			[defaults setObject:uuid forKey:XPUniqueIdentifierDefaultsKey];
			[defaults synchronize];
		}
	}
	return uuid;
}

+ (NSString *)generateUUID {
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef string = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);
	return (__bridge_transfer NSString *)string;
}

+ (NSString *)name {
	return [[UIDevice currentDevice] name];
}

+ (NSString *)defaultLanguage {
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	NSArray *languages = [defs objectForKey:@"AppleLanguages"];

	return [languages objectAtIndex:0];
}

+ (BOOL)cameraSupported {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)photoLibrarySupported {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL)microphoneSupported {
	AVAudioSession *ptr = [AVAudioSession sharedInstance];

	return ptr.inputAvailable;
}

+ (BOOL)multitaskingSupported {
	BOOL backgroundSupported = NO;

	if ([self respondsToSelector:@selector(isMultitaskingSupported)]) backgroundSupported = self.multitaskingSupported;

	return backgroundSupported;
}

+ (BOOL)callPhoneSupported {
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel://"]];
}

+ (BOOL)sendSMSSupported {
#ifdef __IPHONE_4_0
	return [MFMessageComposeViewController canSendText];

#else
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"sms://"]];

#endif
}

+ (BOOL)sendEmailSupported {
	return [MFMailComposeViewController canSendMail];
}

+ (BOOL)photoAlbumSupported {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}

+ (BOOL)flashSupported {
#ifdef __IPHONE_4_0
	return [UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear];

#else
	return NO;

#endif
}

+ (BOOL)frontCameraSupported {
#ifdef __IPHONE_4_0
	return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];

#else
	return NO;

#endif
}

+ (BOOL)videoCameraSupported {
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	NSArray *sourceTypes = [UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];

	if (![sourceTypes containsObject:(NSString *)kUTTypeMovie]) {
		return NO;
	}

	return YES;
}

+ (BOOL)compassSupported {
	#ifdef __IPHONE_4_0
	return [CLLocationManager headingAvailable];

#else   //location.headingAvailable deprecated
	CLLocationManager *location = [[CLLocationManager alloc] init];
	BOOL supported = location.headingAvailable;
	SM_RELEASE(location);
	return supported;

#endif
}

+ (BOOL)gyroscopeSupported {
#ifdef __IPHONE_4_0
	CMMotionManager *motionManager = [[CMMotionManager alloc] init];
	BOOL gyroAvailable = motionManager.gyroAvailable;
	return gyroAvailable;
#else
	return NO;

#endif
}

@end
