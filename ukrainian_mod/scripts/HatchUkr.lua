function update(dt)
  
  local Hatch = pane.containerEntityId()			--ID баку
  local fuelAmount = world.getProperty("ship.fuel") --Поточне паливо корабля
  
  local ES = 0			--Паливо в предметах
  local Count = 0		--Кількість палива
  local CF = nil		--Одне паливо
  for i = 0, 5 do
    CF = world.containerItemAt(Hatch, i)
    if CF ~= nil then
      Count = CF.count
      CF = root.itemConfig(CF.name)
      if CF.config.fuelAmount ~= nil then ES = ES + (Count * CF.config.fuelAmount) end
    end
  end
  if (fuelAmount + ES) == 0 then Text = "^red;Паливо: " ..string.format("%.0f", fuelAmount + ES).. "/" ..player.shipUpgrades().maxFuel.. "^reset;" end
  if (fuelAmount + ES) >= player.shipUpgrades().maxFuel then Text = "^green;Паливо: " ..player.shipUpgrades().maxFuel.. "/" ..player.shipUpgrades().maxFuel.. "^reset;" end
  if ((fuelAmount + ES) > 0) and ((fuelAmount + ES) < player.shipUpgrades().maxFuel) then Text = "Паливо: " ..string.format("%.0f", fuelAmount + ES).. "/" ..player.shipUpgrades().maxFuel end
  widget.setText("FuelLabel", Text)  
end