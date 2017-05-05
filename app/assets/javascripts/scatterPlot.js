jQuery(document).on('turbolinks:load', () => {
  if (window.location.href.match(/^.*\/books\/[0-9]+$/)) {
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
        ctx.width = 500;
        ctx.height = 500;

        let flattenedPrices = [];
        prices[0].forEach((price, index) => {
          let formattedPrice = parseInt(price[1].price.replace('$', ''));
          flattenedPrices.push(formattedPrice);
        });
        let outlierSum = flattenedPrices.reduce((a, b) => a + b, 0);
        let outlierMean = outlierSum / flattenedPrices.length;
        let filteredPrices = [];
        flattenedPrices.forEach((price) => {
          if (price <= outlierMean * 3 && price >= outlierMean / 3) {
            filteredPrices.push(price);
          }
        })
        let sum = filteredPrices.reduce((a, b) => a + b, 0);
        let mean = sum / filteredPrices.length;
        let squaredPrices = [];
        filteredPrices.forEach((price) => {
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
                x: (mean - (3 * stdDeviation)).toFixed(2),
                y: 0.1
              },
              {
                x: (mean - (2 * stdDeviation)).toFixed(2),
                y: 2
              },
              {
                x: (mean - stdDeviation).toFixed(2),
                y: 14
              },
              {
                x: (mean).toFixed(2),
                y: 34
              },
              {
                x: (mean + stdDeviation).toFixed(2),
                y: 14
              },
              {
                x: (mean + (2 * stdDeviation)).toFixed(2),
                y: 2
              },
              {
                x: (mean + (3 * stdDeviation)).toFixed(2),
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
                position: 'bottom',
                scaleLabel: {
                  display: true,
                  labelString: 'Prices'
                }
              }],
              yAxes: [{
                scaleLabel: {
                  display: true,
                  labelString: 'Percentages'
                }
              }]
            }
          }
        });

        let negOneStdPrice = document.createElement('li');
        let meanPrice = document.createElement('li');
        let oneStdPrice = document.createElement('li');
        negOneStdPrice.innerText = `-1σ: $${(mean - stdDeviation).toFixed(2)}`;
        meanPrice.innerText = `0σ: $${(mean).toFixed(2)}`;
        oneStdPrice.innerText = `1σ: $${(mean + stdDeviation).toFixed(2)}`;
        document.getElementById('targetPrices').appendChild(negOneStdPrice);
        document.getElementById('targetPrices').appendChild(oneStdPrice);
        document.getElementById('targetPrices').appendChild(meanPrice);
      } else {
        setTimeout(check, 100);
      }
    };

    check();
  }
});
