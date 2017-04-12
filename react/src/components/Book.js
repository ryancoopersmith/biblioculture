import React, { Component } from 'react';
import Info from './Info';

class Book extends Component {
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
    let classNames = require('classnames');

    let gridClasses = classNames({
      'card': true,
      'small-2': true,
      'columns': true,
      'book': true
    });

    if (this.state.toggle === true) {
      return(
        <Info
          id={this.props.id}
          name={this.props.name}
          author={this.props.author}
          isbn={this.props.isbn}
          image={this.props.image}
          onClick={this.seeAll}
        />
      )
    } else {
      return(
        <div onClick={this.handleClick} className={gridClasses}>
          <div className='card-divider'>
            <div className='card-section'>
              <img src={this.props.image} />
              <div className='name'>
                {this.props.name}
              </div>
              <div className='author'>
                {this.props.author}
              </div>
            </div>
          </div>
        </div>
      );
    }
  }
}

export default Book;
