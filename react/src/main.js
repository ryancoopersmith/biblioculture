import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import Search from './components/Search';

$(function() {
  ReactDOM.render(
    <Search />,
    document.getElementById('main')
  );
});
