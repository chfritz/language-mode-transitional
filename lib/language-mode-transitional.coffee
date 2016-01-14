LanguageModeTransitionalView = require './language-mode-transitional-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageModeTransitional =
  languageModeTransitionalView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageModeTransitionalView = new LanguageModeTransitionalView(state.languageModeTransitionalViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageModeTransitionalView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-mode-transitional:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageModeTransitionalView.destroy()

  serialize: ->
    languageModeTransitionalViewState: @languageModeTransitionalView.serialize()

  toggle: ->
    console.log 'LanguageModeTransitional was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
