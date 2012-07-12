class Application
  constructor: ->
    version = '1.0.0'
    
  convertPoints: ->
    $('.list-card-title').each ->
      title = $(@).html()
      points = title.match(/\((0|.5|1|2|3|5|8|13|20|40|100|\?)(\/(0|.5|1|2|3|5|8|13|20|40|100|\?))?\)/gi)
      if points
        title = title.replace(points[0], '')
        $(@).html(title)
        
        card = $(@).parents('.list-card')
        card.append('<ul class="list-card-points" />')
        points = points[0].replace('(','').replace(')','').split(',')
        for point in points
          cardLi = $('<li/>')
            .attr('class', 'badge')
            .text($.trim(point))
            
          card.find('ul.list-card-points').append(cardLi)
    
  convertTags: ->
    iconUrl = chrome.extension.getURL('images/tag.png')
    $('.list-card-title').each ->
      title = $(@).html()
      tags = title.match /\[(.+?)\]/gi
      if tags
        title = title.replace(tags[0], '')
        tags = tags[0].replace('[','').replace(']','').split(',')
        $(@).html(title).prepend('<span style="display:none">' + tags.join(',') + '</span>')
        
        card = $(@).parents('.list-card')
        card.append('<ul class="list-card-tags" />')
        
        for tag in tags
          cardLi = $('<li/>')
            .attr('class', 'badge')
            .attr('style', 'background-image: url('+iconUrl+'?1)')
            .text($.trim(tag)).click( (e) ->
              e.stopPropagation()
            )
            
          card.find('ul.list-card-tags').append(cardLi)
          
  colorizeTags: ->
    $('.list-card').each ->
      bgColor = $(@).find('.card-label').first().css('backgroundColor')
      borderColor = $(@).find('.card-label').last().css('backgroundColor')
      if bgColor
        if borderColor != bgColor
          $(@).css('border-color', borderColor).css('border-width', '3px')
          
        bgColor = bgColor.replace('rgb', 'rgba').replace(')',', 0.1)')
        $(@).css('backgroundColor', bgColor)
    
  refresh: ->
    if !$('.list-card-title').length || !$('.js-filter-cards').length
      console.log 'Waiting for ready...'
      return
    @convertPoints()
    @convertTags()
    @colorizeTags()

app = new Application()
callback = => app.refresh()
setInterval callback, 0.005