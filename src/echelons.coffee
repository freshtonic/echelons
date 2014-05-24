
Q = require 'q'
_ = require 'lodash'


template = (templateLiteral) ->
  if _.isArray templateLiteral
    arrayTemplate templateLiteral
  else if _.isObject templateLiteral
    objectTemplate templateLiteral
  else
    throw new Error 'unsupported template type'

arrayTemplate = (arrayTemplateLiteral) ->
  objDef = _.first arrayTemplateLiteral
  attrs = Object.keys objDef
  tmpl = objectTemplate objDef
  (arrayOrPromise) ->
    Q(arrayOrPromise).then (array) ->
      Q.all array.map (item) -> tmpl item

objectTemplate = (objectTemplateLiteral) ->
  (objOrPromise) ->
    Q(objOrPromise).then (obj) ->
      Object.keys(objectTemplateLiteral).reduce (newObj, attr) ->
        newObj[attr] = objectTemplateLiteral[attr].call obj
        newObj
      , {}





(module?.exports.template = template) or @template = template
