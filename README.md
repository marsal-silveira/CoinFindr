# CoinFindr
App to find the top 10 cryptocurrency using the coinmarketcap.com as reference.

[![Build Status](https://travis-ci.org/marsal-silveira/CoinFindr.svg?branch=master)](https://travis-ci.org/marsal-silveira/CoinFindr)

## Development Stack

- xCode 9.2
- Swift 4
- CocoaPods as Dependency Manager
- Git Flow
- Architecture: VIPER + MVVM + Reactive (RxSwift)
- Moya + Alamofire + ObjectMapper
- No Storyboard (.xib and Programmatically)

## Setup
 
### Cloning

1. On GitHub, navigate to the main page of the repository.

2. Under the repository name, click **Clone or download**.

3. In the Clone with HTTPs section, click under copy icon to copy the clone URL for the repository.

4. Open Terminal.

5. Change the current working directory to the location where you want the cloned directory to be made.

6. Type `git clone`, and then paste the URL you copied in Step 2.

```
$ git clone https://github.com/marsal-silveira/CoinFindr.git
```

7. Press **Enter**. Your local clone will be created.

**or**

### Downloading

1. On GitHub, navigate to the main page of the repository.

2. Under the repository name, click **Clone or download**.

3. In the Clone with HTTPs section, click under `Download Zip` button to download it.

**or**

Download the [latest code version](https://github.com/marsal-silveira/CoinFindr/archive/master.zip) and extract it into workspace.

### Setup CocoaPods

We use [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) as Dependecy Manager, so make sure you have this tool instaled and configured in you system.

1. Open Terminal.

2. Change the current working directory to the project directory.

3. Type `pod install`.

```
$ pod install
```

4. Wait until all dependencies are downloaded.

5. In **xCode** open project using **CoinFindr.xcworkspace**.
