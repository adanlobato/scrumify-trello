class Application
  constructor: ->
    version = '1.0.0'
    
  convertProjects: ->
    iconUrl = chrome.extension.getURL('images/tag.png')
    $('.list-card-title').each ->
      title = $(@).text()
      tags = title.match /\[(.+?)\]/gi
      if tags
        $(@).html(title.replace(tags[0], ''))
        card = $(@).parents('.list-card')
        card.append('<ul class="list-card-tags" />')
        tags = tags[0].replace('[','').replace(']','').split(',')
        for tag in tags
          card.find('ul').append('<li class="badge" style="background-image: url('+iconUrl+'?1)">' + $.trim(tag) + '</li>')
    
  refresh: ->
    if !$('.list-card-title').length
      console.log 'Waiting for ready...'
      return
    @convertProjects()

app = new Application()
callback = => app.refresh()
setInterval callback, 500
