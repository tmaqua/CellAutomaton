
name = "seed"
board_size = 40
step = 25
state_num = 3
init_type = 0
neighbor_rule = 
  "if (now_state == 0 && (state_count >= 3 && state_count <= 3))
    1
   elsif (now_state == 1 && (state_count >= 2 && state_count <= 3))
    2
   else
    0
  end"

CellAutomaton.create(
  name: name,
  board_size: board_size,
  step: step,
  state_num: state_num,
  init_type: init_type,
  neighbor_rule: neighbor_rule
)