var aggregate = require('./lib/aggregate').aggregate;

var de_bund = aggregate('de-bund');

de_bund.drilldown('einzelplan').cut('time.year', 2012).cut('flow', 'spending').fetch(function(data) {
  console.log(data.drilldown);
  de_bund.cache.client.quit();
});

