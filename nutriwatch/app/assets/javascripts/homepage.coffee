# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  slider = $('#Calories').slider(
    range: true
    min: 0
    max: 5000
    values: [
      0
      5000
    ]
    slide: (event, ui) ->
      $('#cal_min_cal').val ui.values[0]
      $('#cal_max_cal').val ui.values[1]
      return
  )
  $('#cal_min_cal').val slider.slider('values')[0]
  $('#cal_max_cal').val slider.slider('values')[1]
  return