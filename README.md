# PlayerView


[![Swift5 compatible][Swift5Badge]][Swift5Link]
[![SPM compatible][SPMBadge]][SPMLink]

[Swift5Badge]: https://img.shields.io/badge/swift-5-orange.svg?style=flat
[Swift5Link]: https://developer.apple.com/swift/

[SPMBadge]: https://img.shields.io/badge/SPM-compatible-brightgreen.svg
[SPMLink]: https://github.com/apple/swift-package-manager


iOS music player view

# Screen

<img src="https://github.com/SoundcloudUnofficialApp/PlayerView/blob/master/PlayerView/Example/PlayerViewExample/Screen.png"/>

### About
PlayerView is an IBDesignableView (Custom View) which has its own progress,cover image and action buttons.


## Installation
  [Download](https://github.com/AhmettKeskin/PlayerView/archive/master.zip) the project and copy the PlayerView folder into your project and then simply you can use it in any file

## Requirements

- iOS 12.0+
- Xcode 10.0+
- Swift 5.0+


## Usage
- Add your view in storyboard
- Arrange your view's size square (It looks better this way)
- Set your view's class PlayerView
- Wait until it built in storyboard and set variables
- Then create your property of view and set it's delegate to self to use it's delegation methods and good to go !

``` swift
  @IBOutlet var ipv: PlayerView!
  
  // set delegation
  self.ipv!.delegate = self

  // duration of music
  self.ipv.progress = 120.0
  
  // start - stop player
  self.ipv.start()
  self.ipv.stop()
  
  // restart player with duration
  self.ipv.restartWithProgress(duration: 50)

  /* PlayerViewDelegate METHODS */
    func actionOneButtonTapped(sender: UIButton, isSelected: Bool) {
        println("ActionOneButton tapped")
    }
    
    func actionTwoButtonTapped(sender: UIButton, isSelected: Bool) {
        println("ActionTwoButton tapped")
    }
    
    func actionThreeButtonTapped(sender: UIButton, isSelected: Bool) {
        println("ActionThreeButton tapped")

    }

```

## Useful Methods

``` swift
  // set progress colors
  self.ipv.progressEmptyColor = UIColor.yellowColor()
  self.ipv.progressFullColor = UIColor.redColor()

```
``` swift
  // get and set isSelected value of action buttons
  let isSelected = self.ipv.isActionOneSelected
  self.ipv.isActionOneSelected = true
```
```swift
  // Buttons are also square and setting one value to width and height is enough. And also you can set action button's images
  self.ipv.buttonSizes = 30.0

  self.ipv.actionOne_icon_selected = UIImage(named: "shuffle_selected.png")
  self.ipv.actionOne_icon_unselected = UIImage(named: "shuffle_unselected.png")

  self.ipv.coverImage = UIImage(named: "imagetest.png")

```


## Design

[Here is original design](https://www.pinterest.com/pin/400187116866664878/)

License
--------


    Copyright 2015 Ahmet Keskin.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

