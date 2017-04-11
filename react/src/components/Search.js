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
    this.getBooks = this.getBooks.bind(this);
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

  getBooks() {
    fetch('http://localhost:3000/api/v1/books.json', {
      credentials: 'same-origin'
      }).then(response => {
        if (response.ok) {
          return response;
        } else {
          let errorMessage = `${response.status} (${response.statusText})`,
              error = new Error(errorMessage);
          throw(error);
        }
      })
      .then(response => response.json())
      .then(body => {
        this.setState({ books: body });
        console.log(body)
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getBooks();
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
