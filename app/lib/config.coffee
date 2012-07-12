config = if location.hostname is 'hoodiehq.github.com' 

  env       : 'production'
  hoodie_url: "http://cors.io/jan.iriscouch.com"
  
else 
  env       : 'development'
  hoodie_url: "http://localhost:9292/localhost:5984"

module.exports = config