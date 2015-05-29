var React = require('react-native');

var ASCIImage = React.createClass({

  propTypes: {
    ascii: React.PropTypes.arrayOf(React.PropTypes.string),
    color: React.PropTypes.string,
    contextOptions: React.PropTypes.arrayOf(React.PropTypes.object),
    style: React.View.propTypes.style,
  },

  getInitialState: function() {
    return { defaultDimensions: [0, 0] }
  },

  updateDimensions: function(dimensions) {
    this.setState({ defaultDimensions: dimensions });
  },

  componentWillMount: function() {
    ASCIImage.Common.defaultImageDimensionsFromASCII(this.props.ascii, this.updateDimensions);
  },

  render: function() {
    return (
      <RNASCIImage
        style={[{ width: this.state.defaultDimensions[0], height: this.state.defaultDimensions[1]}, this.props.style]}
        ascii={this.props.ascii}
        color={this.props.color}
        contextOptions={this.props.contextOptions}
      />
    );
  }

});

var RNASCIImage = React.requireNativeComponent('RCTASCIImage', ASCIImage);
ASCIImage.Writer = require('NativeModules').ASCIImageWriter;
ASCIImage.Common = require('NativeModules').ASCIImageCommon;

module.exports = ASCIImage;