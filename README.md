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
];

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

<img src="https://raw.githubusercontent.com/turley/react-native-asciimage/master/example.png" height="27" alt="Example Result" />

## Alternate Usage

In some situations it's useful to work with an image URI rather than an `Image` component (e.g., for use in `TabBarIOS.Item` or `NavigatorIOS`). To generate a (local) image URI, do the following:

```
...
var ASCIImage = require('react-native-asciimage');
var ASCIImageWriter = ASCIImage.Writer;

ASCIImageWriter.createImageFromASCII(myImage, '#ffffff', 40, function(imageURI) {
  // Use the imageURI wherever it's needed
  console.log(imageURI);
});
```

This will create an image saved in your application's `Caches` directory for the specified color (example: `#ffffff`) and width (example: `40`). It will automatically generate standard, @2x, and @3x sizes of the image, and will use cached images when they exist.

For advanced options (which would normally be passed in via the `contextOptions` prop), you can use the expanded form:

```
var options = [
  { fillColor: "rgba(0, 0, 0, 0)", lineWidth: 5 }, // First shape
  { fillColor: "#0000ff" } // Second shape
];

ASCIImageWriter.createImageFromASCIIWithOptions(myImage, '#ffffff', 40, options, function(imageURI) {
  console.log(imageURI);
}
```

## Props

The following props are used:

- **`ascii`** _(Array)_ REQUIRED - an array of strings representing rows of the image (see the ASCIImage [documention](https://github.com/cparnot/ASCIImage) for details)
- **`color`** _(String)_ the color value to use for the foreground, e.g. `#0000FF` or `rgba(0, 255, 0, 0.5)`. Default: `#000000`
- **`contextOptions`** _(Array)_ Array of options for advanced control over the drawing of each shape. Array indices correspond to the `ASCIIContextShapeIndex` for each shape passed to the underlying `contextHandler` block. Array values should be plain JavaScript objects with any of the following keys: `fillColor`, `strokeColor`, `lineWidth`, `shouldClose`, or `shouldAntialias`.


---

## License

Available under the MIT license. See the LICENSE file for more informatiion.

[ASCIImage](https://github.com/cparnot/ASCIImage) (redistributed here) is also [MIT licensed](https://github.com/cparnot/ASCIImage/blob/master/LICENSE) by Charles Parnot
