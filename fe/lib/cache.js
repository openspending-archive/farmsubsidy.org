var _ = require('underscore'),
    sha1 = require('sha1'),
    redis = require('redis');

exports.Cache = function() {
  var self = this;
  self.client = redis.createClient();

  this.keyfunc = function(query) {
    var els = [];
    _.each(query, function(v,k) {
      els.push(k+'%%%'+v);
    });
    return sha1(els.sort().join('$$$'));
  };

  this.lookup = function(query, fetchCallback, dataCallback) {
    self.client.get(self.keyfunc(query), function(err, reply) {
      if (reply===null) {
        fetchCallback();
      } else {
        dataCallback(JSON.parse(reply.toString()));
      }
    });
  };

  this.store = function(query, data, dataCallback) {
    self.client.set(self.keyfunc(query), JSON.stringify(data), function() {
      dataCallback(data);
    });
  };
};

