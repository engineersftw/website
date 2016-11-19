var Presenter = React.createClass({
  render: function() {
    return (
      <div className="col s12 m4 l3">
        <a href={"/presenters/" + this.props.id}>
          <h6 className="truncate">{this.props.name}</h6>
          <div className="thumbnail">
            <img className="responsive-img" src={this.props.avatar} />
          </div>
        </a>
      </div>
    );
  }
});