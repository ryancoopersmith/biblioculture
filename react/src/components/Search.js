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
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getBooks();
  }

  render() {
    let classNames = require('classnames');

    let paginateClasses = classNames({
      'button': true,
      'paginate': true
    });

    let groupSize = 5;
    let pageSize = Math.ceil(this.state.books.length / 5);
    let books = this.state.books.map((book, index) => {
      if ((book.name.toLowerCase().indexOf(this.state.search.toLowerCase()) !== -1 || book.author.toLowerCase().indexOf(this.state.search.toLowerCase()) !== -1 || book.isbn === this.state.search) && this.state.search !== '') {
        return (
          <BookList
            key={index + 1}
            image={book.image}
            name={book.name}
            author={book.author}
          />
        );
      }
    }).reduce((r, element, index) => {
      index % groupSize === 0 && r.push([]);
      r[r.length - 1].push(element);
      return r;
    }, []).reduce((r, element, index) => {
      index % pageSize === 0 && r.push([]);
      r[r.length - 1].push(element);
      return r;
    }, []).map((bookContent) => {
      return(
        <div className="row">
          {bookContent[this.state.group - 1]}
        </div>
      );
    });

    let page;
    if (this.state.search !== '') {
      if (this.state.group > 1 && this.state.group < pageSize) {
        page = <div className="center">
        <button type="button" onClick={() => this.updateGroup(-1)} className={paginateClasses}>Previous</button>
        <button type="button" onClick={() => this.updateGroup(1)} className={paginateClasses}>Next</button>
        </div>;
      } else if (this.state.group === pageSize){
        page = <div className="center">
        <button type="button" onClick={() => this.updateGroup(-1)} className={paginateClasses}>Previous</button>
        </div>;
      } else {
        page = <div className="center">
        <button type="button" onClick={() => this.updateGroup(1)} className={paginateClasses}>Next</button>
        </div>;
      }
    }

    return(
      <div>
        <input type="text" className="search" placeholder="Search"
        value={this.state.search}
        onChange={this.updateSearch}/>
        {books}
        {page}
      </div>
    );
  }
}

export default Search;
