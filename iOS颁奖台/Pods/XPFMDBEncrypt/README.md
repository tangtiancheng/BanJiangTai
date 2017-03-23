#XPFMDBEncrypt

# 动机
虽然FMDB有FMDB/SQLCipher源，但是默认情况下这个源是不能直接使用setKey函数进行加密、解密的，可能是因为考虑SQLCipher是商业性质！哈哈哈...

## 作用
**XPFMDBEncrypt**是一个使用FMDB+SQLCipher库进行二次封装的加密库！


### 用法
1. 以前使用FMDatabase的地方替换为XPFMEncryptDatabase即可。
2. 以前使用FMDatabaseQueue的地方替换为XPFMEncryptDatabaseQueue即可。
3. 可以使用XPFMDBEncryptHelper对数据库文件进行加密、解密。


```
本加密、解密库需要FMDB、SQLCipher支撑，推荐使用Cocoapods导入：
pod 'FMDB/SQLCipher'
```