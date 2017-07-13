#!/usr/bin/env bash

function error() {
	printf "\033[0;31m$1\033[m\n"
}

function info() {
    printf "\033[0;32m$1\033[m\n"
}

if [[ $# -eq 0 ]]; then
	error "version require."
	echo "Usage:
	./publish version
	example: ./publish.sh 0.41.2
	"
	exit
fi

tagName="v$1"
branchName="branch-$tagName"

info "version=$1, tagName=$tagName, branchName=$branchName"


publishGradle="${PWD}/publish.gradle"
reactNativeDir="${PWD}/react-native"
reactAndroidDir="$reactNativeDir/ReactAndroid"


if [[ -d "$reactNativeDir" ]]; then
	info "$reactNativeDir exist."
else
	info "$reactNativeDir not exist, clone it."
	git clone https://github.com/facebook/react-native
fi

cd $reactNativeDir
git checkout master
git pull

if [[ $(git branch | grep $branchName | grep '*') ]]; then
	info "on current branch $branchName."

elif [[ $(git branch | grep $branchName) ]]; then
	info "checkout local branch $branchName."
	git checkout $branchName

elif [[ $(git tag | grep $tagName) ]]; then
	info "checkout branch=$branchName from tag=$tagName."
	git checkout -b $branchName $tagName

else
	error "cannot found tag named $tagName in $reactNativeDir."
    exit -1
fi

cp $publishGradle $reactAndroidDir/

echo "apply from: 'publish.gradle'" >> $reactAndroidDir/build.gradle

info "clean project"
./gradlew clean --info

info "try publish aar"
./gradlew :ReactAndroid:publish --info
code="$?"
if [[ $code -eq 0 ]]; then
    info "publish aar success."
else
    error "publish aar error."
fi

rm -f $reactAndroidDir/publish.gradle
git checkout $reactAndroidDir/build.gradle

exit $code

