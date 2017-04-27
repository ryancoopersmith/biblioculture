import React, { Component } from 'react';
import 'whatwg-fetch';

class Info extends Component {
  constructor(props) {
    super(props);
    this.state = {
      prices: [],
      isbn_13: ''
    };
    this.getPrices = this.getPrices.bind(this);
  }

  getPrices() {
    fetch(`http://localhost:3000/api/v1/books/${this.props.id}/prices.json`, {
      credentials: 'same-origin'
    }).then(response => {
      if (response.ok) {
        return response;
      } else {
        let errorMessage = `${response.status} (${response.statusText})`;
        let error = new Error(errorMessage);
        throw(error);
      }
    }).then(response => response.json())
      .then(body => {
        this.setState({ prices: body });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getPrices();
    if (this.props.isbn_13 !== null) {
      this.setState({ isbn_13: `ISBN-13: ${this.props.isbn_13}` });
    }
  }

  render() {
    let prices = [];
    this.state.prices.forEach((price) => {
      prices.push(
        <div className='price'>
          <p className='siteName'>Site: {price[0].name}</p>
          <p className='siteName'>Best Price: {price[1].price}</p>
        </div>
      );
    });

    return(
      <div className='book'>
        <img src={this.props.image} />
        <div className='name'>
          {this.props.name}
        </div>
        <div className='author'>
          By: {this.props.author}
        </div>
        <div className='isbn'>
          ISBN-10: {this.props.isbn_10}
        </div>
        <div className='isbn'>
          {this.state.isbn_13}
        </div>
        {prices}
        <button className='button' type='button' onClick={this.props.onClick}>See All</button>
      </div>
    );
  }
}

export default Info;
