# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  slider = $('#calorie_slider').slider(
    range: true
    min: 0
    max: 5000
    tooltip: 'always'
    step: 10
    selection: 'before'
    values: [
      0
      5000
    ]
    slide: (event, ui) ->
      $('#cal_data1').val ui.values[0]
      $('#cal_data2').val ui.values[1]
      return
  )
  $('#cal_data1').val slider.slider('values')[0]
  $('#cal_data2').val slider.slider('values')[1]
  return