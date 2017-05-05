import 'babel-polyfill';
import React from 'react';
import ReactDOM from 'react-dom';
import BookList from './components/BookList';

$(document).ready(function () {
  ReactDOM.render(
    <BookList />,
    document.getElementById('main')
  );
});
