rowNum = 0
columnNum = 0
step = 0
array = null
playingStep = 0
wait = 0
stateNum = 3
colors = ['white', 'gray', 'red']
logs = []


$('.cell_automatons.show').ready -> 
  rowNum = gon.rowNum
  columnNum = gon.columnNum
  step = gon.step
  array = gon.array
  stateNum = gon.stateNum
  playingStep = 0
  wait = 0
  colors = gon.colors
  logs = gon.logs
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

  showLogs(playingStep)
  tr = $('#cells tbody tr')
  tempArray = array[arrayIndex]
  for i in [0..rowNum-1]
    row = tr.eq(i).children()
    for j in [0..columnNum-1]
      td = row.eq(j).text();
      for k in [0..stateNum-1]
        if k == tempArray[i][j]
          row.eq(j).css('background-color', colors[k])

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

showLogs = (playingStep) ->
  logArea = $("#logs")
  logg = logs[playingStep]
  logStr = "ステップ数: #{playingStep}\n"

  for i in [0...stateNum]
    temp = logg["#{i}"]
    logStr = logStr + "状態#{i}の数: #{temp}\n"

  logArea.val(logStr)

