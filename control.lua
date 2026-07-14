-- Adjustable brake settings
local SPEED_LIMIT = 0.08  -- Maximum speed allowed in hazard zones (tiles per tick)
local CHECK_INTERVAL = 5  -- How often to check vehicles (ticks) - 5 = 12 times per second
local REGULAR_BRAKE_COUNT = 1  -- Emergency brakes on regular hazard concrete
local REFINED_BRAKE_COUNT = 10  -- Emergency brakes on refined hazard concrete

script.on_event(defines.events.on_tick, function(event)
  if event.tick % CHECK_INTERVAL ~= 0 then return end
  
  -- Only check player-driven vehicles for performance
  for _, player in pairs(game.players) do
    if player.vehicle and player.vehicle.type == "car" then
      local car = player.vehicle
      local surface = car.surface
      
      local tile = surface.get_tile(car.position)
      local is_hazard = (tile.name == "hazard-concrete-left" or 
                         tile.name == "hazard-concrete-right")
      local is_refined_hazard = (tile.name == "refined-hazard-concrete-left" or
                                 tile.name == "refined-hazard-concrete-right")
      
      if is_hazard or is_refined_hazard then
        -- Apply speed limit sticker (no checking, just apply)
        surface.create_entity{
          name = "hazard-zone-speed-limit",
          position = car.position,
          target = car,
          force = car.force
        }
        
        -- Apply emergency brake if going too fast
        if math.abs(car.speed) > SPEED_LIMIT then
          local brake_count = is_refined_hazard and REFINED_BRAKE_COUNT or REGULAR_BRAKE_COUNT
          
          for i = 1, brake_count do
            surface.create_entity{
              name = "hazard-zone-emergency-brake",
              position = car.position,
              target = car,
              force = car.force
            }
          end
        end
      end
    end
  end
end)