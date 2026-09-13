function build(directory, config, parameters, level, seed)
  config.tooltipFields = config.tooltipFields or {}

  config.tooltipFields.reelNameLabel = parameters.reelName or config.reelName
  config.tooltipFields.reelIconImage = parameters.reelIcon or config.reelIcon

  config.tooltipFields.lureNameLabel = parameters.lureName or config.lureName
  config.tooltipFields.lureIconImage = parameters.lureIcon or config.lureIcon

	if config.tooltipFields ~= nil then
		--Рідкість
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
