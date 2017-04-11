import React, { Component } from 'react';
import BookList from './BookList';

class Search extends Component {
  constructor(props){
    super(props);
    this.state = {
      books: [],
      search: '',
      prevSearch: '',
      group: 1
    }
    this.updateSearch = this.updateSearch.bind(this);
    this.updateGroup = this.updateGroup.bind(this);
  }

  updateSearch(event) {
    let prevSearch = this.state.search;
    this.setState({ prevSearch: prevSearch });
    this.setState({search: event.target.value.substr(0, 100)});
    if(this.state.search.length === 1 && this.state.prevSearch > this.state.search) {
      this.setState({ group: 1 });
    } else if(this.state.search.length > -1){
      this.setState({ group: 0 });
    }
  }

  updateGroup(page) {
    let nextGroup = this.state.group + page;
    this.setState({ group: nextGroup });
  }

  render() {
    return(
      <div>
        <input type="text" className="search" placeholder="Search"
        value={this.state.search}
        onChange={this.updateSearch}/>
        <BookList />
      </div>
    );
  }
}

export default Search;
