fs = require('fs')
express = require('express')
app = express()
port = 4000

app.use express.static(__dirname + '/..')
app.use express.favicon(__dirname + '/../app/favicon.ico')
app.use express.directory(__dirname + '/..')
app.use express.errorHandler()

# simple logger
app.use (req, res, next) ->
  console.log '%s %s', req.method, req.url
  next()

app.use(app.router)
app.listen(port)

console.log 'Server listening on http://localhost:' + port
