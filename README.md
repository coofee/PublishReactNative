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

* 安装android sdk + ndk环境

ndk: android-ndk-r10e


* 下载脚本代码:

```bash
git clone https://github.com/coofee/PublishReactNative
```

* 修改基本配置

```groovy
ext {
    MAVEN_USERNAME = ''
    MAVEN_PASSWORD = ''
    // maven url
    URL = ''
    // move libs.so from armeabi-v7a to armeabi
    moveToArmeabi = true;
    // true: if you want publish aar without pom dependencies,  default is false.
    removeDependencies = false;
}
```

* 发布react-native的aar.

```bash
# 如：./publish.sh 0.44
./publish.sh version 
```