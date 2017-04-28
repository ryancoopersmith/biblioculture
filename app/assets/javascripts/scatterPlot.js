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

      // let sum = flattenedPrices.reduce((prev, curr) => {
      //   prev + curr;
      // }, 0);
      //
      // console.log(sum)

      let sortedPrices = [];
      let pricesLength = flattenedPrices.length;
      for (let i = 1; i < pricesLength + 1; i++) {
        let max = Math.max(...flattenedPrices); // spread operator treats [1,2,3] as 1,2,3
        if (i % 2 === 0) {
          sortedPrices.push(max);
        } else {
          sortedPrices.unshift(max);
        }
        let index = flattenedPrices.indexOf(max);
        flattenedPrices.splice(index, 1);
      }

      let points = [];
      sortedPrices.forEach((price, index) => {
        points.push({
          x: index,
          y: price
        });
      });

      let data = {
        datasets: [{
          label: 'Prices',
          borderColor: '#1468A0',
          pointBorderColor: '#C244C1',
          pointRadius: 5,
          pointBorderWidth: 2.5,
          data: points
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
