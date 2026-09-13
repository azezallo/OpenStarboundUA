require "/scripts/util.lua"
require "/items/buildscripts/abilities.lua"

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

  setupAbility(config, parameters, "primary")
  setupAbility(config, parameters, "alt")

  -- calculate damage level multiplier
  config.damageLevelMultiplier = root.evalFunction("weaponDamageLevelMultiplier", configParameter("level", 1))

  config.tooltipFields = {}
  config.tooltipFields.subtitle = parameters.category
  config.tooltipFields.speedLabel = util.round(1 / config.primaryAbility.fireTime, 1)
  config.tooltipFields.damagePerShotLabel = util.round(
      (config.primaryAbility.crackDps + config.primaryAbility.chainDps) * config.primaryAbility.fireTime * config.damageLevelMultiplier, 1)
  if config.elementalType and config.elementalType ~= "physical" then
    config.tooltipFields.damageKindImage = "/interface/elements/"..config.elementalType..".png"
  end
  if config.altAbility then
    config.tooltipFields.altAbilityTitleLabel = "Особливе:"
    config.tooltipFields.altAbilityLabel = config.altAbility.name or "Невідомо"
  end

  -- set price
  config.price = (config.price or 0) * root.evalFunction("itemLevelPriceMultiplier", configParameter("level", 1))

	--Рідкість
	if config.rarity == "common" or config.rarity == "Common" then config.tooltipFields.rarityLabel = "Звичайний" end
	if config.rarity == "uncommon" or config.rarity == "Uncommon" then config.tooltipFields.rarityLabel = "Незвичний" end
	if config.rarity == "rare" or config.rarity == "Rare" then config.tooltipFields.rarityLabel = "Рідкісний" end
	if config.rarity == "legendary" or config.rarity == "Legendary" then config.tooltipFields.rarityLabel = "Легендарний" end
	if config.rarity == "essential" or config.rarity == "Essential" then config.tooltipFields.rarityLabel = "Важливий" end
	--Тип предмета
	if config.twoHanded then config.tooltipFields.handednessLabel = "2-Ручний" else config.tooltipFields.handednessLabel = "1-Ручний" end

  return config, parameters
end
