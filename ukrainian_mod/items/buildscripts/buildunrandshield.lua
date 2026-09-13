require "/scripts/util.lua"

function build(directory, config, parameters, level, seed)
  local configParameter = function(keyName, defaultValue)
    if parameters[keyName] ~= nil then
      return parameters[keyName]
    elseif config[keyName] ~= nil then
      return config[keyName]
    else
      return defaultValue
    end
  end

  if level and not configParameter("fixedLevel", true) then
    parameters.level = level
  end

  -- set price
  config.price = configParameter("price", 0) * root.evalFunction("itemLevelPriceMultiplier", configParameter("level", 1))

  -- tooltip fields
  config.tooltipFields = {}
  config.tooltipFields.healthLabel = util.round(configParameter("baseShieldHealth", 0) * root.evalFunction("shieldLevelMultiplier", configParameter("level", 1)), 0)
  config.tooltipFields.cooldownLabel = parameters.cooldownTime or config.cooldownTime

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
