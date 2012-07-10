class Application
  constructor: ->
    version = '1.0.0'
    @convertTags()
    
  convertProjects: ->
    $('.list-card-title').each ->
      text = $(this).text()
      text = text.replace /\[(.+?)\]/gi, '<span class="label">$1</span>'
      $(this).html(text)
    
  convertTags: ->
    $('.list-card-title').each ->
      text = $(this).text()
      text = text.replace /\[tags\](.+?)\[\/tags]/gi, "<strong>$1</strong>"
      tags = $('<ul class="tags"></ul>').append('<li>' + text + '</li>')
      $(this).parent().append(tags)
    
  refresh: ->
    if !$('.list-card-title').length
      return
    @convertProjects()
    @convertTags()

$(document).ready( ->
  app = new Application()
  setInterval app.refresh(), 500
)
