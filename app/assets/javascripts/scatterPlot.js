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

      let flattenedPrices = [];
      prices[0].forEach((price, index) => {
        let formattedPrice = parseInt(price[1].price.replace('$', ''));
        flattenedPrices.push(formattedPrice);
      });

      let sum = flattenedPrices.reduce((a, b) => a + b, 0);
      let mean = sum / flattenedPrices.length;
      let squaredPrices = [];
      flattenedPrices.forEach((price) => {
        squaredPrices.push(Math.pow((price - mean), 2));
      });
      let squaredSum = squaredPrices.reduce((a, b) => a + b, 0);
      let squaredMean = squaredSum / squaredPrices.length;
      let stdDeviation = Math.sqrt(squaredMean);

      let data = {
        datasets: [{
          label: 'Prices',
          borderColor: '#1468A0',
          pointBorderColor: '#C244C1',
          pointRadius: 5,
          pointBorderWidth: 2.5,
          data: [
            {
              x: mean - (3 * stdDeviation),
              y: 0.1
            },
            {
              x: mean - (2 * stdDeviation),
              y: 2
            },
            {
              x: mean - stdDeviation,
              y: 14
            },
            {
              x: mean,
              y: 34
            },
            {
              x: mean + stdDeviation,
              y: 14
            },
            {
              x: mean + (2 * stdDeviation),
              y: 2
            },
            {
              x: mean + (3 * stdDeviation),
              y: 0.1
            }
          ]
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
