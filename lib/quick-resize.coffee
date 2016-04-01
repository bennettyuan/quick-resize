{CompositeDisposable} = require 'atom'

module.exports = QuickResize =
  config:
    sizeOne:
      type: 'object'
      properties:
        description:
          type: 'string'
          default: 'Medium'
        width:
          type: 'number'
          default: 846
        height:
          type: 'number'
          default: 686+22
    sizeTwo:
      type: 'object'
      properties:
        description:
          type: 'string'
          default: 'Large'
        width:
          type: 'number'
          default: 1090
        height:
          type: 'number'
          default: 740+22

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace', 'quick-resize:one': => @sizeOne()
    @subscriptions.add atom.commands.add 'atom-workspace', 'quick-resize:two': => @sizeTwo()
    @subscriptions.add atom.commands.add 'atom-workspace', 'quick-resize:save-current-size': => @saveCurrentSize()

  deactivate: ->
    @subscriptions.dispose()

  sizeOne: ->
    if not atom.isFullScreen()
      description = atom.config.get('quick-resize.sizeOne.description')
      width = atom.config.get('quick-resize.sizeOne.width')
      height = atom.config.get('quick-resize.sizeOne.height')
      atom.setSize(width, height)
      atom.notifications.addInfo "Quick Resize: #{description}"

  sizeTwo: ->
    if not atom.isFullScreen()
      description = atom.config.get('quick-resize.sizeTwo.description')
      width = atom.config.get('quick-resize.sizeTwo.width')
      height = atom.config.get('quick-resize.sizeTwo.height')
      atom.setSize(width, height)
      atom.notifications.addInfo "Quick Resize: #{description}"

  saveCurrentSize: ->
    if atom.isFullScreen()
      atom.notifications.addError "Can not save current window size in full-screen mode"
    else
      width = atom.getSize().width
      height = atom.getSize().height
      atom.config.set 'quick-resize.sizeTwo.width', width
      atom.config.set 'quick-resize.sizeTwo.height', height
      atom.config.set 'quick-resize.sizeTwo.description', 'New size with save'
      atom.notifications.addInfo "Saved"
