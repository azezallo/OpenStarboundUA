require "/scripts/util.lua"

function build(directory, config, parameters, level, seed)
  if not parameters.stemName then
    -- a pine tree isn't PERFECTLY generic but it's close enough
    parameters.stemName = "pineytree"
    parameters.foliageName = parameters.foliageName or "pinefoliage"
  end

  config.inventoryIcon = jarray()

  table.insert(config.inventoryIcon, {
      image = string.format("%s?hueshift=%s", util.absolutePath(root.treeStemDirectory(parameters.stemName), "saplingicon.png"), parameters.stemHueShift or 0)
    })

  if parameters.foliageName then
    table.insert(config.inventoryIcon, {
        image = string.format("%s?hueshift=%s", util.absolutePath(root.treeFoliageDirectory(parameters.foliageName), "saplingicon.png"), parameters.foliageHueShift or 0)
      })
  end

	config.tooltipFields = config.tooltipFields or {}
	--Рідкісність
	if config.rarity == "common" or config.rarity == "Common" then config.tooltipFields.rarityLabel = "Звичайний" end
	if config.rarity == "uncommon" or config.rarity == "Uncommon" then config.tooltipFields.rarityLabel = "Незвичний" end
	if config.rarity == "rare" or config.rarity == "Rare" then config.tooltipFields.rarityLabel = "Рідкісний" end
	if config.rarity == "legendary" or config.rarity == "Legendary" then config.tooltipFields.rarityLabel = "Легендарний" end
	if config.rarity == "essential" or config.rarity == "Essential" then config.tooltipFields.rarityLabel = "Важливий" end

  return config, parameters
end
