Pre-Requisites:

a) Xcode v9.3
b) Pods v1.4.0 (https://guides.cocoapods.org/using/getting-started.html)

Installation:

a) Open terminal
b) cd path-to-project
c) pod install
d) open CookPinterest.xcworkspace
e) Select 'Simulator/Device' in Xcode, & hit command+R

Known Issues:

a) Project rely on third party pod `PinterestLayout` (https://github.com/MagicLab-team/PinterestLayout) which requires version Swift 3.+. After successfull `pod install` on hitting run if you see error in specific to `PinterestLayout` pod project, kindly update its language version to Swift 3.3 from 4.1. Here are the steps,
    * Open CookPinterest.xcworkspace
    * Select 'Pods.xcodeproj'
    * Select 'PinterestLayout' from targets.
    * In Build Settings > Swift Language Version > Update to 3.3
    * Hit command+R
