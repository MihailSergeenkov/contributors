$(document).on 'keyup', '#search_url', () ->
  $(this).removeClass('is-invalid')
  $('.search-errors').hide()
