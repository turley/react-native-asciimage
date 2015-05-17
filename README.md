## react-native-asciimage

Provides an `<ASCIImage />` component for React Native, powered by the excellent [ASCIImage](http://asciimage.org/) by @cparnot. It allows you to generate and insert images into your react-native app using ASCII art to describe the images (useful for small icons in UI elements).

Only iOS is currently supported.


## Installation


1. Run `npm install react-native-asciimage --save`
2. Open your project in XCode, right click on `Libraries` and click `Add
   Files to "Your Project Name"` then choose the `RNASCIImage.xcodeproj`.
3. Add `libRNASCIImage.a` to `Build Phases -> Link Binary With Libraries`.
3. `var ASCIImage = require('react-native-asciimage');`
4. Use the `<ASCIImage/>` element wherever you want to insert an image described by the `ascii` prop and optional `color` prop.

## Usage

```javascript
'use strict';

var React = require('react-native');
var ASCIImage = require('react-native-asciimage');
var { AppRegistry, View, Text } = React;

var myImage = [
  '· · · 1 2 · · · · · ',
  '· · · A # # · · · · ',
  '· · · · # # # · · · ',
  '· · · · · # # # · · ',
  '· · · · · · 9 # 3 · ',
  '· · · · · · 8 # 4 · ',
  '· · · · · # # # · · ',
  '· · · · # # # · · · ',
  '· · · 7 # # · · · · ',
  '· · · 6 5 · · · · · '
]

var App = React.createClass({

  render: function() {
    return (
      <View>
        <Text>
          ASCIImage Example:
        </Text>
        <ASCIImage ascii={myImage} />
      </View>
    );
  }

});

AppRegistry.registerComponent('App', () => App);
```

Result:

![Example image](https://raw.githubusercontent.com/turley/react-native-asciimage/master/example.png)


## Props

The following properties are used:

- **`ascii`** _(Array)_ REQUIRED - an array of strings representing rows of the image (see the ASCIImage [documention](https://github.com/cparnot/ASCIImage) for details)
- **`color`** _(String)_ the color value to use for the foreground, e.g. `#0000FF` or `rgba(0, 255, 0, 0.5)`. Default: `#000000`


---

## License

Available under the MIT license. See the LICENSE file for more informatiion.

[ASCIImage](https://github.com/cparnot/ASCIImage) (redistributed here) is also [MIT licensed](https://github.com/cparnot/ASCIImage/blob/master/LICENSE) by Charles Parnot
