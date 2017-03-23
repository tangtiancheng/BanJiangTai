#XPStorage

# 动机
以前一直都觉得将SQLite二次封装就算是对持久层的理解，进来发现不是那么回事。个人觉得持久层最核心的思维是与ViewController Layer、Model Layer、View Layer、ViewModel Layer是平级的！

## 目的
使用该库可以用最简单的key-value方式持久化数据（貌似在我看来，key-value结构已经足够满足我们的需求。value最终的形式是String，所以可以存放NSArray、NSDictionary、NSData等），并且该库可对数据库文件进行加密、解密，以解决数据的安全性问题！

### 支持Pods
pod 'XPStorage', :git => 'https://coding.net/huangxinping/XPStorage.git', :tag => '1.0.1'

```
因为该库依赖于XPFMDBEncrypt（它依赖于FMDatabase、SQLCipher），但是XPFMDBEncrypt是本人的另外一个非公共的库，所以在使用Cocoapods时候，必须写上：
pod 'XPStorage', :git => 'https://coding.net/huangxinping/XPStorage.git', :tag => '1.0.1'
pod 'XPFMDBEncrypt', :git => 'https://coding.net/huangxinping/XPFMDBEncrypt.git', :tag => '1.0.0'
```