var ScreenshotBlock = React.createClass({
  getInitialState: function() {
    return {currentIndex: 0, maxIndex: 100, imgExtension: 'png'};
  },

  componentDidMount: function() {
    this.fetchScreenshotInfo(function(data) {
      console.log("First call...");
      that.setState({
        currentIndex: Number(data.last)
      });
    });

    var that = this;
    this.timerID = setInterval(
      function(){ that.fetchScreenshotInfo() },
      5000
    );
  },

  componentWillUnmount: function() {
    clearInterval(this.timerID);
  },

  fetchScreenshotInfo: function(callback) {
    var that = this;
    $.getJSON(this.props.baseUrl, function(data){
      console.log(data);
      that.setState({
        maxIndex: Number(data.last),
        imgExtension: data.extension
      });
      if (callback) {
        callback(data);
      }
    })
  },

  lpad: function(n, width=3, z=0) {
    return (String(z).repeat(width) + String(n)).slice(String(n).length)
  },

  currentImage: function() {
    var imgBlock = "";
    if (this.state.currentIndex > 0) {
      imgBlock = <div className="curent-screen">
        <img className="responsive-img" src={this.props.baseUrl + "snapshot" + this.lpad(this.state.currentIndex, 5) + "." + this.state.imgExtension} />
      </div>;
    }
    return imgBlock;
  },

  nextImage: function() {
    var newIndex = this.state.currentIndex;
    if (this.state.currentIndex < this.state.maxIndex) {
      newIndex++;
    }

    this.setState({currentIndex: newIndex});
  },

  prevImage: function() {
    var newIndex = this.state.currentIndex;
    if (this.state.currentIndex > 2) {
      newIndex--;
    }
    this.setState({currentIndex: newIndex});
  },

  render: function() {
    return <div className="screenshots">
      {this.currentImage()}
      <div className="screen-navs center-align">
        <button className="btn" onClick={this.prevImage}>&laquo; Previous</button>
        &nbsp;
        <button className="btn" onClick={this.nextImage}>Next &raquo;</button>
      </div>
    </div>;
  }
});