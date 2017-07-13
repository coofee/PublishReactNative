### 使用rn-packager拆分Bundle

[TestBundleSplit](https://github.com/coofee/TestBundleSplit)


### 1. bundleReleaseJsAndAssets not found or does not run.

如果找不到`bundleDebugJsAndAssets`、`bundleReleaseJsAndAssets`这两个task的话，则需要在gradle.properties文件中设置
org.gradle.configureondemand=false,

You said exactly right. In Android Studio, go to `File | Settings | Build, Execution, Deployment | Compiler`, the option `Configure on demand` is checked by default for speeding up builds, uncheck it then everything is ok now.


### 2. unbundle 
将代码中的bundle替换为unbundle即可.

```groovy
if (Os.isFamily(Os.FAMILY_WINDOWS)) {
    commandLine "cmd", "/c", "node", "./local-cli/cli.js", "unbundle", "--platform", "android", "--dev", "${devEnabled}",
            "--entry-file", entryFile, "--bundle-output", jsBundleFile, "--assets-dest", resourcesDir
} else {
    commandLine "node", "./local-cli/cli.js", "unbundle", "--platform", "android", "--dev", "${devEnabled}",
            "--entry-file", entryFile, "--bundle-output", jsBundleFile, "--assets-dest", resourcesDir
}
```


### 3. SyntaxError: Strict mode does not allow function declarations in a lexically nested statement on a newly created app

open node_modules\react-native\Libraries\Core\InitializeCore.js line 112

change function handleError(e, isFatal) to var handleError = function(e, isFatal)

[issue](https://github.com/facebook/react-native/issues/11389)

### 4. jcenter missing react-native

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

### 5. "No dimensions set for key window" error after fresh 0.44.0 install 

[No dimensions set for key window](https://github.com/facebook/react-native/issues/13758)


### 6. Chrome Debug

props = component input params;

state = component self view state, only contains that used in render method;

mapDispatchToProps
presentational components -> dispatch action -> reducer handle action and generate new state -> 

* DevTools & Debug


react webpack debug devtools:
[dev tools](http://stackoverflow.com/questions/27626764/configure-webpack-to-allow-browser-debugging)

redex devtools:
[devTools](https://github.com/zalmoxisus/redux-devtools-extension)