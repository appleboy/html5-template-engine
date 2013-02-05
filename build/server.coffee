fs = require("fs")
express = require("express")
app = express()

app.use(express.static(__dirname + '/..'))

app.get "*", (req, res) ->
    fs.createReadStream("./index.html").pipe(res)

app.use(app.router)
app.listen(3000)

console.log "Server listening on http://localhost:3000"
