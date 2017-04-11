import React, { Component } from 'react';
import Book from './Book';

class BookList extends Component {
  constructor(props){
    super(props);
    this.state = {
      toggle: false
    }
    this.handleClick = this.handleClick.bind(this);
    this.seeAll = this.seeAll.bind(this);
  }

  handleClick() {
    this.setState ({ toggle: true })
    let books = document.getElementsByClassName('book');
    for (let i = 0; i < books.length; i++) {
      document.getElementsByClassName('book')[i].style.display = 'none';
    }
    document.getElementsByClassName('paginate')[0].style.display = 'none';
  }

  seeAll() {
    this.setState ({ toggle: false })
    let books = document.getElementsByClassName('book');
    for (let i = 0; i < books.length; i++) {
      document.getElementsByClassName('book')[i].style.display = 'block';
    }
    document.getElementsByClassName('paginate')[0].style.display = 'block';
  }

  render() {
    if (this.state.toggle === true) {
      return(
        <Book
          name={this.props.name}
          author={this.props.author}
          isbn={this.props.isbn}
          image={this.props.image}
          onClick={this.seeAll}
        />
      )
    } else {
      return(
        <div onClick={this.handleClick} className='book'>
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
