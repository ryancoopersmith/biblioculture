import React, { Component } from 'react';
import Book from './Book';

class BookList extends Component {
  constructor(props){
    super(props);
    this.state = {
      toggle: false
    }
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick() {
    this.setState ({ toggle: true })
  }

  render() {
    if (this.state.toggle === true) {
      return(
        <Book
          name={this.props.name}
          author={this.props.author}
          isbn={this.props.isbn}
        />
      )
    } else {
      return(
        <div onClick={this.handleClick}>
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
}

export default BookList;
