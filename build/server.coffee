fs = require("fs")
express = require("express")
app = express()

app.use(express.static(__dirname + '/..'))
app.use(express.favicon("./favicon.ico"))

# simple logger
app.use (req, res, next) ->
    console.log '%s %s', req.method, req.url
    next()

app.get "*", (req, res) ->
    fs.createReadStream("./index.html").pipe(res)

app.use(app.router)
app.listen(3000)

console.log "Server listening on http://localhost:3000"
