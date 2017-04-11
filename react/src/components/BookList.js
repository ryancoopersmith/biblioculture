import React, { Component } from 'react';
import Book from './Book';

class BookList extends Component {
  constructor(props){
    super(props);
  }

  render() {
    return(
      <div>
        <Book />
      </div>
    );
  }
}

export default BookList;
