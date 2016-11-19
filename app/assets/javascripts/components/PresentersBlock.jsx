var PresentersBlock = React.createClass({
  getInitialState: function() {
    return {hasAvatar: [], noAvatar: [], searchTerm: ''};
  },

  componentDidMount: function() {
    var allPresenters = [];
    this.props.presenters.map(function(presenter, i){
      allPresenters.push(presenter);
    });

    var allNoAvatarPresenters = [];
    this.props.no_avatar.map(function(presenter, i){
      allNoAvatarPresenters.push(presenter);
    });

    this.setState({hasAvatar: allPresenters, noAvatar: allNoAvatarPresenters});
  },

  preparePresenters: function(){
    var row = this.state.hasAvatar.map(function(presenter, i){
      return(
        <Presenter id={presenter.id} name={presenter.name} avatar={presenter.avatar_url} />
      );
    });
    return row;
  },

  prepareNoAvatarPresenters: function () {
    var row = this.state.noAvatar.map(function(presenter, i){
      return(
        <div className="col s12 l4 m6">
          <a href={"/presenters/" + presenter.id}>
            <h5 className="truncate">{presenter.name}</h5>
          </a>
        </div>
      );
    });
    return row;
  },

  findPresenter: function(event) {
    var searchString = event.target.value.toLowerCase();

    var filteredAvatarPresenters = _.filter(this.props.presenters, function(o){ return o.name.toLowerCase().search(searchString) != -1; });
    var filteredNoAvatarPresenters = _.filter(this.props.no_avatar, function(o){ return o.name.toLowerCase().search(searchString) != -1; });

    this.setState({searchTerm: searchString, hasAvatar: filteredAvatarPresenters, noAvatar: filteredNoAvatarPresenters});
  },

  render: function() {
    return(
      <div>
        <form className="row" method="get" action="/presenters/search">
          <div className="col s12 input-field">
            <label for="search_field">Filter by name</label>
            <input type="text" name="search" value={this.state.searchTerm} onChange={this.findPresenter} />
          </div>
        </form>
        <div className="row">
          {this.preparePresenters()}
        </div>
        <div className="row">
          {this.prepareNoAvatarPresenters()}
        </div>
      </div>
    );
  }
});