$ ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'submit', (event) ->
    cellFields = $('form').find(".cell-field:visible")
    stateNum = $('#cell_automaton_state_num').val()
    
    if cellFields.length != +stateNum
      event.preventDefault()
      alert("状態数と色の数が一致していません")