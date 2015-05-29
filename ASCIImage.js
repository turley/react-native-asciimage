var React = require('react-native');

var ASCIImage = React.createClass({

  propTypes: {
    ascii: React.PropTypes.arrayOf(React.PropTypes.string),
    color: React.PropTypes.string,
    contextOptions: React.PropTypes.arrayOf(React.PropTypes.object),
    style: React.View.propTypes.style,
  },

  render: function() {
    var defaultDimensions = [0, 0];
    if (this.props.ascii && this.props.ascii.length > 0) {
      defaultDimensions[0] = this.props.ascii[0].length;
      defaultDimensions[1] = this.props.ascii.length;
    }

    return (
      <RNASCIImage
        style={[{ width: defaultDimensions[0], height: defaultDimensions[1]}, this.props.style]}
        ascii={this.props.ascii}
        color={this.props.color}
        contextOptions={this.props.contextOptions}
      />
    );
  }

});

var RNASCIImage = React.requireNativeComponent('RCTASCIImage', ASCIImage);
ASCIImage.Writer = require('NativeModules').ASCIImageWriter;

module.exports = ASCIImage;