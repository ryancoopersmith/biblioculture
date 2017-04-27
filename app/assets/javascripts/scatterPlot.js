window.onload = () => {
  let bookID = document.getElementById('bookID').innerHTML;
  let prices = [];
  fetch(`http://localhost:3000/api/v1/books/${bookID}/prices.json`, {
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
      prices.push(body);
    })
    .catch(error => console.error(`Error in fetch: ${error.message}`));

  let check = () => {
    if (prices[0]) {
      let ctx = document.getElementById('scatterPlot');
      ctx.width = 300;
      ctx.height = 300;

      let data = {
        datasets: [{
          label: 'Prices',
          borderColor: '#1468A0',
          pointBorderColor: '#C244C1',
          pointRadius: 5,
          pointBorderWidth: 2.5,
          data: [{
            x: -10,
            y: 0
          }, {
            x: 0,
            y: 10
          }, {
            x: 10,
            y: 5
          }]
        }]
      };

      let scatterChart = new Chart(ctx, {
        type: 'line',
        data: data,
        options: {
          responsive: false,
          scales: {
            xAxes: [{
              type: 'linear',
              position: 'bottom'
            }]
          }
        }
      });
    } else {
      setTimeout(check, 100);
    }
  };

  check();
};
