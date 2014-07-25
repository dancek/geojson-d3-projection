traverse = require 'traverse'
d3 = require 'd3'
fs = require 'fs'
argv = require('minimist')(process.argv.slice(2))

require("d3-geo-projection")(d3)

main = ->
    data = require('./' + argv._[0])
    outfile = argv._[1]

    projection = eval(argv['projection'] ? 'd3.geo.winkel3()')
    
    traverse(data).forEach (x) ->
        if ('coordinates' in @path) and x.length == 2 and parseFloat(x[0]) == x[0]
            this.update projection(x[0], x[1])

    fs.writeFile outfile, JSON.stringify(data, null, 4), (err) ->
        if(err)
            console.log(err)
        else
            console.log("JSON saved to " + outfile)

main()
