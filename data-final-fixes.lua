data.raw["tile"]["hazard-concrete-left"].walking_speed_modifier = 0.6
data.raw["tile"]["hazard-concrete-right"].walking_speed_modifier = 0.6
data.raw["tile"]["refined-hazard-concrete-left"].walking_speed_modifier = 0.3
data.raw["tile"]["refined-hazard-concrete-right"].walking_speed_modifier = 0.3

data:extend({
-- Sticker 1: Maintains slow controllable speed in hazard zones
  {
    type = "sticker",
    name = "hazard-zone-speed-limit",
    flags = {"not-on-map"},
    duration_in_ticks = 60,
    
    damage_per_tick = {
      amount = 0,
      type = "physical"
    },
    
    vehicle_speed_modifier = 0.3,
    vehicle_speed_max_from = 0.08,
    vehicle_speed_max_to = 0.08,
    vehicle_friction_modifier = 2.0,
    
    animation = {
      filename = "__core__/graphics/empty.png",
      width = 1,
      height = 1,
      frame_count = 1,
      line_length = 1,
      animation_speed = 1
    }
  },
  -- Sticker 2: Aggressive braking for vehicles entering too fast
  {
    type = "sticker",
    name = "hazard-zone-emergency-brake",
    flags = {"not-on-map"},
    duration_in_ticks = 10,  -- Short duration for quick brake
    
    damage_per_tick = {
      amount = 0,
      type = "physical"
    },
    
    vehicle_speed_modifier = 0.1,  -- Drastically reduce power
    vehicle_speed_max_from = 1.0,  -- Accept any speed
    vehicle_speed_max_to = 0.08,   -- Force down to limit
    vehicle_friction_modifier = 8.0,  -- Massive friction for hard brake
    
    animation = {
      filename = "__core__/graphics/empty.png",
      width = 1,
      height = 1,
      frame_count = 1,
      line_length = 1,
      animation_speed = 1
    }
  }
})