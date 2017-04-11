import React, { Component } from 'react';
import Book from './Book';

class BookList extends Component {
  constructor(props){
    super(props);
  }

  render() {
    return(
      <div>
        <img src={this.props.image} />
        <div className='name'>
          {this.props.name}
        </div>
        <div className='author'>
          {this.props.author}
        </div>
      </div>
    );
  }
}

export default BookList;
