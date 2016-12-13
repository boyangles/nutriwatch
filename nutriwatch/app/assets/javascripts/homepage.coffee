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
      $('#cal_data1').val ui.values[0]
      $('#cal_data2').val ui.values[1]
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
      $('#rate_data1').val ui.values[0]
      $('#rate_data2').val ui.values[1]
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
      $('#price_data1').val ui.values[0]
      $('#price_data2').val ui.values[1]
      return
  )

  $('#cal_data1').val slider.slider('values')[0]
  $('#cal_data2').val slider.slider('values')[1]
  $('#rate_data1').val slider.slider('values')[0]
  $('#rate_data2').val slider.slider('values')[1]
  $('#price_data1').val slider.slider('values')[0]
  $('#price_data2').val slider.slider('values')[1]
  return