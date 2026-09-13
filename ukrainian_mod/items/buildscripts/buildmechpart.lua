partFrames = {
  arm = {
    {"<armName>", ":idle"},
    {"<armName>Fullbright", ":idle"}
  },
  body = {
    {"bodyBack", ":active"},
    {"bodyFront", ":active"},
    {"bodyFullbright", ":active"}
  },
  booster = {
    {"frontBoosterBack", ":idle"},
    {"frontBoosterFront", ":idle"}
  },
  legs = {
    {"backLeg", ":flat", {11, -4}},
    {"backLegJoint", ":default", {5, -1}},
    {"hips", ":default", {2, 3}},
    {"frontLegJoint", ":default", {-6, -1}},
    {"frontLeg", ":flat", {-10, -4}}
  }
}

function build(directory, config, parameters, level, seed)
  if config.mechPart and partFrames[config.mechPart[1]] then
    local partFile = root.assetJson("/vehicles/modularmech/mechparts_" .. config.mechPart[1] .. ".config")
    local partConfig = partFile[config.mechPart[2]]

    local paletteConfig = root.assetJson("/vehicles/modularmech/mechpalettes.config")
    local directives = directiveString(paletteConfig, partConfig.defaultPrimaryColors, partConfig.defaultSecondaryColors)

    local basePath = "/vehicles/modularmech/"
    local drawables = {}

    for _, frameConfig in ipairs(partFrames[config.mechPart[1]]) do
      local baseImage = partConfig.partImages[frameConfig[1]]
      if baseImage and baseImage ~= "" then
        table.insert(drawables, {
            image = basePath .. baseImage .. frameConfig[2] .. directives,
            centered = true,
            position = frameConfig[3]
          })
      end
    end

    config.tooltipFields = config.tooltipFields or {}
    config.tooltipFields.objectImage = drawables

    if partConfig.stats then
      for statName, statValue in pairs(partConfig.stats) do
        local clampedValue = math.max(3, math.min(7, math.floor(statValue)))
        config.tooltipFields[statName .. "StatImage"] = "/interface/tooltips/statbar.png:" .. clampedValue
      end
    end

    if config.mechPart[1] == "arm" then
      local energyDrain = root.evalFunction("mechArmEnergyDrain", partConfig.stats.energy or 0)
      config.tooltipFields.energyDrainStatLabel = string.format("%.02f МДж/с", energyDrain)
    end
  end

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

function directiveString(paletteConfig, primaryColors, secondaryColors)
  local result = ""
  for i, fromColor in ipairs(paletteConfig.primaryMagicColors) do
    result = string.format("%s?replace=%s=%s", result, fromColor, primaryColors[i])
  end
  for i, fromColor in ipairs(paletteConfig.secondaryMagicColors) do
    result = string.format("%s?replace=%s=%s", result, fromColor, secondaryColors[i])
  end
  return result
end
