--Заміна функції sb.replaceTags()
function RepTags(text, tags)
  --sb.logInfo("Рядок: %s", text)
  --sb.logInfo("Теги: %s", tags)
  
  local str = text
  
  for key, x in pairs(tags) do
	--sb.logInfo("Ключ: %s", key)
	--sb.logInfo("Значення: %s", x)
	str = str:gsub("<" ..key.. ">",x);
	--sb.logInfo("Test: %s", str)
  end
  return str
end