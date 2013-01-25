var request = require('request'),
    qs = require('querystring'),
    cache = require('./cache'),
    _ = require('underscore');

exports.aggregate = function(dataset_name) {
  cache = new cache.Cache();

  var spec = function(state) {
    var self = this;
    self.cache = cache;
    self.state = state;

    self.extendState = function(key, obj) {
      if (_.has(self.state, key) && _.isArray(self.state[key])) {
        obj = _.union(self.state[key], [obj]);
      }
      var newState = _.clone(self.state);
      newState[key] = obj;
      return new spec(newState);
    };

    self.query = function() {
      var q = {};
      _.each(self.state, function(v, k) {
        if (_.isArray(v)) v = v.join('|');
        if (!_.isEmpty(v+"")) q[k]=v;
      });
      return q;
    }

    self.fetch = function(callback) {
      var query = self.query();
      var fetchCallback = function() {
        var url = 'http://openspending.org/api/2/aggregate?' + qs.stringify(query);
        console.log(url);
        request.get({url: url, json: true}, function(e, r, body) {
          self.cache.store(query, body, callback);
        });
      };
      self.cache.lookup(query, fetchCallback, callback);
    };

    self.cut = function(key, value) {
      return self.extendState('cut', key + ':' + value);
    };

    self.drilldown = function(key) {
      return self.extendState('drilldown', key);
    };

    self.page = function(page) {
      return self.extendState('page', page);
    };

    self.pagesize = function(pagesize) {
      return self.extendState('pagesize', pagesize);
    };

    self.order = function(key, dir) {
      return self.extendState('order', key + ':' + dir);
    };
  };

  return new spec({'dataset': dataset_name, 'cut': [], 'drilldown': []});
};


