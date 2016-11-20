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
      $('img[usemap]').rwdImageMaps();
    });

    var that = this;
    this.timerID = setInterval(
      function(){ that.fetchScreenshotInfo() },
      5000
    );
  },

  componentWillMount: function () {
    document.addEventListener("keydown", this.handleKeyUp, false);
  },

  componentWillUnmount: function() {
    clearInterval(this.timerID);
    document.removeEventListener("keydown", this.handleKeyUp, false);
  },

  handleKeyUp: function(e) {
    if (e.keyCode == 37) {
      e.preventDefault();
      this.prevImage();
    }
    if (e.keyCode == 39) {
      e.preventDefault();
      this.nextImage();
    }
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
      imgBlock = <img className="screen-snapshot responsive-img" useMap="#navmap" src={this.props.baseUrl + "snapshot" + this.lpad(this.state.currentIndex, 5) + "." + this.state.imgExtension} />;
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

  goLatest: function() {
    var newIndex = this.state.maxIndex;
    this.setState({currentIndex: newIndex});
  },

  render: function() {
    return <div className="screenshots">
      <div className="curent-screen">
        <map name="navmap">
          <area href="javascript:;" shape="rect" coords="0,0,960,1080" alt="Previous Screenshot" title="Previous Screenshot" onClick={this.prevImage} />
          <area href="javascript:;" shape="rect" coords="960,0,1920,1080" alt="Next Screenshot" title="Previous Screenshot" onClick={this.nextImage} />
        </map>
        {this.currentImage()}
      </div>
      <div className="screen-navs center-align">
        <button className="btn" onClick={this.prevImage}>&laquo; Previous</button>
        &nbsp;
        <button className="btn" onClick={this.goLatest}>Latest Screenshot</button>
        &nbsp;
        <button className="btn" onClick={this.nextImage}>Next &raquo;</button>
      </div>
    </div>;
  }
});