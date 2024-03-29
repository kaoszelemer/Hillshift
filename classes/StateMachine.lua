local StateMachine = class('StateMachine')

function StateMachine:init(states, startingState)
    self.state = states[startingState]
    self.states = states
end

function StateMachine:changeState(targetState)
    
    local validTransitionFound = false

    for index, stateName in ipairs(self.state.transitions) do

        if stateName == targetState.name then        
            self.state = self.states[targetState.name]
          --  if self.state.name ~= self.states.waitingState.name then
            print("[STATE]: "..self.state.name)
          --  end
            --if self.state.name == self.states.waitingState.name then


            --end
               
            return
        end

       
    end

    if not validTransitionFound then
        error("not valid transition from "..self.state.name.." to "..targetState.name)
    end


   
end

return StateMachine