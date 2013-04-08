IO = require './'
module.exports = class SpaceSeparatedIO extends IO
  caseParser: (c)->
    c.match /[^\s]+/g

