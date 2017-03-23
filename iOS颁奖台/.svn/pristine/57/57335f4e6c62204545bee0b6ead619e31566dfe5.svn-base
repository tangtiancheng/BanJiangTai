快速开始
---------------
1、 通过[CocoaPods](http://cocoapods.org/) 安装诸葛: 
```shell
gem install cocoapods
```

在项目目录下创建`Podfile`文件，文件内容为:
```
pod 'Zhugeio'
```

在项目目录下执行下面脚本，CocoaPods会自动下载安装Zhuge SDK，并生成工作区文件:
```shell
pod install
```

打开工作区文件`*.xcworkspace`，不要打开原来的项目文件`*.xcodeproj`:
```shell
open {YOUR-PROJECT}.xcworkspace 
```

2、 向`AppDelegate.m`文件中添加诸葛启动代码:

	#import <Zhuge/Zhuge.h>

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    	[[Zhuge sharedInstance] startWithAppKey:@"Your App Key" launchOptions:launchOptions];
	}
	

3、 开始追踪用户行为:

	[[Zhuge sharedInstance] track:@"分享" properties:@{@"渠道":@"微博"}];
```

4、 识别用户身份

[[Zhuge sharedInstance] identify:@"1234" properties:@{@"email":@"zhuge@37degree.com"}]];
```

**了解更多 [完整文档 »](https://docs.zhugeio.com/help/developer/iOS)**
