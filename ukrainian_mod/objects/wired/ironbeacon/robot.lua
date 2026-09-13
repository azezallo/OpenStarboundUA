function goodReception()
  if world.underground(object.position()) then
    return false
  end

  local ll = object.toAbsolutePosition({ -4.0, 1.0 })
  local tr = object.toAbsolutePosition({ 4.0, 32.0 })

  local bounds = {0, 0, 0, 0}
  bounds[1] = ll[1]
  bounds[2] = ll[2]
  bounds[3] = tr[1]
  bounds[4] = tr[2]

  return not world.rectTileCollision(bounds, {"Null", "Block", "Dynamic", "Slippery"})
end

function init()
  object.setInteractive(true)
end

function onInteraction(args)
  if not goodReception() then
    return { "ShowPopup", { message = "Я повинен винести його на поверхню планети, перш ніж вмикати його." } }
  else
    object.smash()
    world.spawnProjectile("robotwake", object.toAbsolutePosition({ 0.0, 1.0 }))
    world.spawnMonster("robotboss", object.toAbsolutePosition({ 0.0, 5.0 }), { level = 2 })
  end
end

function hasCapability(capability)
  return false
end
