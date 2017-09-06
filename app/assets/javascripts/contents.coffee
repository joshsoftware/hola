# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



jQuery ->
  index = 0
  $("#add_textarea").click ->
     # console.log('old index: ', index)
     index = index + 1
     t = $(".row:first").html()
     $(".contents").append("<div class='row' id='temp#{index}'>" + t+ "</div>")
     return

  $(document).on 'click', '#remove', ->
    alert 'do you want to remove'
    $($(this).parent()).parent().remove()
    index--
    return


  $(document).on "click", ".save_as_template", ->
    #v = $(this).parent().find("textarea").val()
    #console.log("yeee", v)
    #$('.templates').append("<option value=" + v + ">" + v + "</option>")
    #return
    description = $(this).parent().find("textarea").val()
    console.log("#{description}")
    $("#myModal").val(description)
    console.log(description)

    $("#myModal").modal()
    return 

  

  $("#modal_submit").click  ->

    heading = $("#Heading").val()
    ans = $("#myModal").val()

    $('.templates').append("<option>#{heading}</option>")
    $.ajax({
      url: "/templates",
      data: {template: {title:"#{heading}",description:"#{ans}"} },
      type: "post",
      dataType: "script"
    })
    #$.post("/templates",{template:{title:"#{heading}",description:"#{ans}"}})
    return

  

  
  $(document).on "change", "#template", ->
    selectedid = $(this).find("option:selected").val()
    obj = $(this).parent().parent().find('.description')
    console.log(obj)
    $.ajax "/templates/"+selectedid,
      type: "get"
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        console.log(data["description"])
        obj.val(data["description"])

    return

  nextTab = (elem) ->
    $(elem).next().find('a[data-toggle="tab"]').click()
    return

  prevTab = (elem) ->
    $(elem).prev().find('a[data-toggle="tab"]').click()
    return
 
  $('.nav-tabs > li a[title]').tooltip()
 
  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    $target = $(e.target)
    if $target.parent().hasClass('disabled')
      return false
    return

  $('#btn1').click ->
    $('#btn1').hide()
    return

  $('#btn2').click ->
    $('#btn2').hide()
    return
  
  $('#form_1').submit (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active
    return

  $('#form_2').submit (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active
    return

  $('.nextcontent').click (e) ->
    $active = $('.wizard .nav-tabs li.active')
    $active.next().removeClass 'disabled'
    nextTab $active

    return

  $('a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
    $target = $(e.target)
    if $target.parent().hasClass('disabled')
      return false
    return

  $('.prev-step').click (e) ->
    $active = $('.wizard .nav-tabs li.active')
    prevTab $active
    return

return




