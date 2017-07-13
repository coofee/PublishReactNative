## 0x00 为什么要自己发布react-native的aar？

众所周知，react-native自0.20版本以后就不在发布到jcenter上面了，而是随着react-native整体发版。当新创建一个项目时，react-native.aar会和其他依赖一样从npm下载下来，然后在gradle中添加如下代码来依赖:

```groovy
allprojects {
    repositories {
        mavenLocal()
        jcenter()
        maven {
            // All of React Native (JS, Obj-C sources, Android binaries) is installed from npm
            url "$rootDir/../node_modules/react-native/android"
        }
    }
}
```
这样的话，当android项目需要依赖react-native依赖时，就非常的不方便。

## 0x01 一键发布react-native的aar.

```bash
git clone https://github.com/coofee/PublishReactNative
# 如：./publish.sh 0.44
./publish.sh version 
```