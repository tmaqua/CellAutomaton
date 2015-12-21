# rowNum = gon.rowNum
# columnNum = gon.columnNum
# step = gon.step
# array = gon.array
# playingStep = 0
# wait = 0

$('.cell_automatons.show_cell').ready -> 
  rowNum = gon.rowNum
  columnNum = gon.columnNum
  step = gon.step
  array = gon.array
  playingStep = 0
  wait = 0
  createCellTable(rowNum,columnNum)
  $('#playButton').click ->
    playAutomatonAll(step, playingStep)
  $('#stopButton').click ->
    clearInterval(wait)
    playingStep = 0
    $('#playButton').attr("disabled", false)
    playAutomaton(playingStep)
  $('#nextButton').click ->
    clearInterval(wait)
    $('#playButton').attr("disabled", false)
    playAutomaton(playingStep+1) if playingStep < step
  $('#backButton').click ->
    clearInterval(wait)
    $('#playButton').attr("disabled", false)
    playAutomaton(playingStep-1) if playingStep > 0
  $('#pauseButton').click ->
    clearInterval(wait)
    $('#playButton').attr("disabled", false)
    playAutomaton(playingStep)



createCellTable = (rowNum, columnNum) ->
  table = $('#cells')
  tbody = $('<tbody>')
  for i in [0..rowNum-1]
    td = $('<tr>')
    for j in [0..columnNum-1]
      td.append('<td>' + "" + '</td>')
    tbody.append(td)
  table.append(tbody)

playAutomaton = (arrayIndex) ->
  playingStep = arrayIndex

  tr = $('#cells tbody tr')
  tempArray = array[arrayIndex]
  for i in [0..rowNum-1]
    row = tr.eq(i).children()
    for j in [0..columnNum-1]
      if tempArray[i][j] == 0
        td = row.eq(j).text();
        row.eq(j).css('background-color', 'white')
      else
        td = row.eq(j).text()
        row.eq(j).css('background-color', 'gray')

playAutomatonAll = (step, playingStep) ->
  button = $('#playButton')
  button.attr("disabled", true)
  wait = setInterval (()-> 
      playAutomaton(playingStep)
      playingStep++
      if playingStep == step
        clearInterval(wait) 
        button.attr("disabled", false)
    ), 500


