import React, { Component } from 'react';

class Info extends Component {
  constructor(props){
    super(props);
    this.state = {
      sites: []
    }
    this.getSites = this.getSites.bind(this);
  }

  getSites() {
    fetch('http://localhost:3000/api/v1/sites.json', {
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
        this.setState({ sites: body });
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  componentDidMount() {
    this.getSites();
  }

  render() {
    let sites = this.state.sites.map((site) => {
      return(
        <div className='price'>
          {site.name}<br />
          {site.url}
        </div>
      )
    });

    return(
      <div className='book'>
        <img src={this.props.image} />
        <div className='name'>
          {this.props.name}
        </div>
        <div className='author'>
          {this.props.author}
        </div>
        {sites}
        <button className='button' type='button' onClick={this.props.onClick}>See All</button>
      </div>
    );
  }
}

export default Info;
