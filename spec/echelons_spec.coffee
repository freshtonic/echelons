
echelons = require '../lib/echelons'
Env      = require('lazylet').Env
Q        = require 'q'


describe "Echelons", ->

  describe "a basic example", ->

    data = output = undefined

    beforeEach (done) ->

      peopleTemplate = echelons.template [
        name: -> @name.toUpperCase()
      ]

      people = [
        name: 'James'
      , name: 'Kellie'
      ]

      peopleTemplate(people).then (result) ->
        output = result
      .finally done

    it 'should render it', ->
      expect(output).toEqual [
        name: 'JAMES'
      , name: 'KELLIE'
      ]



