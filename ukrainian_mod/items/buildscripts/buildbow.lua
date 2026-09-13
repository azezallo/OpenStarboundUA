require "/scripts/util.lua"
require "/scripts/versioningutils.lua"
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

  -- вибрати, завантажити та об'єднати здібності
  setupAbility(config, parameters, "alt")
  setupAbility(config, parameters, "primary")

  -- тип стихії
  local elementalType = parameters.elementalType or config.elementalType or "physical"
  replacePatternInData(config, nil, "<elementalType>", elementalType)

  -- розрахувати множник рівня пошкодження
  config.damageLevelMultiplier = root.evalFunction("weaponDamageLevelMultiplier", configParameter("level", 1))

  config.tooltipFields = {}
  config.tooltipFields.subtitle = parameters.category
  config.tooltipFields.energyPerShotLabel = config.primaryAbility.energyPerShot or 0
  local bestDrawTime = (config.primaryAbility.powerProjectileTime[1] + config.primaryAbility.powerProjectileTime[2]) / 2
  local bestDrawMultiplier = root.evalFunction(config.primaryAbility.drawPowerMultiplier, bestDrawTime)
  config.tooltipFields.maxDamageLabel = util.round(config.primaryAbility.projectileParameters.power * config.damageLevelMultiplier * bestDrawMultiplier, 1)
  if elementalType ~= "physical" then
    config.tooltipFields.damageKindImage = "/interface/elements/"..elementalType..".png"
  end

  -- встановити ціну
  config.price = (config.price or 0) * root.evalFunction("itemLevelPriceMultiplier", configParameter("level", 1))

	--Рідкісність
	if config.rarity == "common" or config.rarity == "Common" then config.tooltipFields.rarityLabel = "Звичайний" end
	if config.rarity == "uncommon" or config.rarity == "Uncommon" then config.tooltipFields.rarityLabel = "Незвичний" end
	if config.rarity == "rare" or config.rarity == "Rare" then config.tooltipFields.rarityLabel = "Рідкісний" end
	if config.rarity == "legendary" or config.rarity == "Legendary" then config.tooltipFields.rarityLabel = "Легендарний" end
	if config.rarity == "essential" or config.rarity == "Essential" then config.tooltipFields.rarityLabel = "Важливий" end
	--Тип предмета
	if config.twoHanded then config.tooltipFields.handednessLabel = "2-Ручний" else config.tooltipFields.handednessLabel = "1-Ручний" end

  return config, parameters
end
