function build(directory, config, parameters, level, seed)
  if not parameters.timeToRot then
    local rottingMultiplier = parameters.rottingMultiplier or config.rottingMultiplier or 1.0
    parameters.timeToRot = root.assetJson("/items/rotting.config:baseTimeToRot") * rottingMultiplier
  end

  config.tooltipFields = config.tooltipFields or {}
  config.tooltipFields.rotTimeLabel = getRotTimeDescription(parameters.timeToRot)
  
  if config.tooltipFields ~= nil then
    --Рідкісність
	if config.rarity == "common" or config.rarity == "Common" then config.tooltipFields.rarityLabel = "Звичайний" end
	if config.rarity == "uncommon" or config.rarity == "Uncommon" then config.tooltipFields.rarityLabel = "Незвичний" end
	if config.rarity == "rare" or config.rarity == "Rare" then config.tooltipFields.rarityLabel = "Рідкісний" end
	if config.rarity == "legendary" or config.rarity == "Legendary" then config.tooltipFields.rarityLabel = "Легендарний" end
	if config.rarity == "essential" or config.rarity == "Essential" then config.tooltipFields.rarityLabel = "Важливий" end
  end

  return config, parameters
end

function getRotTimeDescription(rotTime)
  local descList = root.assetJson("/items/rotting.config:rotTimeDescriptions")
  for i, desc in ipairs(descList) do
    if rotTime <= desc[1] then return desc[2] end
  end
  return descList[#descList]
end
