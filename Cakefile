fs = require 'fs'
{exec} = require 'child_process'

task 'spec', 'test all specs', (option) ->
  exec "mocha -r should --compilers coffee:coffee-script specs/*.coffee", (err, stdout, stderr) ->
    console.log stdout if stdout?
    console.log stderr if stderr?
