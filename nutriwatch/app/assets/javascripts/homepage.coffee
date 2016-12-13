# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  slider = $('#calorie_slider').slider(
    range: true
    min: 0
    max: 5000
    values: [
      0
      5000
    ]
    slide: (event, ui) ->
      $('#c_min').val ui.values[0]
      $('#c_max').val ui.values[1]
      return
  )

  rate_slider = $('#rating_slider').slider(
    range: true
    min: 0
    max: 5
    values: [
      0
      5
    ]
    slide: (event, ui) ->
      $('#r_min').val ui.values[0]
      $('#r_max').val ui.values[1]
      return
  )

  price_slider = $('#price_slider').slider(
    range: true
    min: 0
    max: 50
    values: [
      0
      50
    ]
    slide: (event, ui) ->
      $('#p_min').val ui.values[0]
      $('#p_max').val ui.values[1]
      return
  )

  $('#c_min').val slider.slider('values')[0]
  $('#c_max').val slider.slider('values')[1]
  $('#r_min').val slider.slider('values')[0]
  $('#r_max').val slider.slider('values')[1]
  $('#p_min').val slider.slider('values')[0]
  $('#p_max').val slider.slider('values')[1]
  return