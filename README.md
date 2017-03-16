# react-native-sample-module
A sample native module to integrate react-native application

# Installation
First, install the library from npm
```
npm install --save react-native-sample-module
```
Second, Link the native dependencies
```
react-native link react-native-sample-module
```

# Imperative APIs
| Name      | Parameters | Description.                    |     Note                 |
|-----------|------------|---------------------------------|--------------------------|
| play      | stream uri | play streaming uri              |                          |
| pause     | X          | pause current music             |                          |
| isPlaying | callback.  | check if music plays now or not | callback contains result |
 
# Example Setup
1. Start emulator
2. Install npm packages
```
cd Example
npm install
```
3. Run example
```
react-native run-ios or react-native run-android
```

