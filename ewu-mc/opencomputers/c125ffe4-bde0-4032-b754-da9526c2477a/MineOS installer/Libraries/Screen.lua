
local color = require("Color")
local image = require("Image")

--------------------------------------------------------------------------------

local bufferWidth, bufferHeight
local currentFrameBackgrounds, currentFrameForegrounds, currentFrameSymbols, newFrameBackgrounds, newFrameForegrounds, newFrameSymbols
local drawLimitX1, drawLimitX2, drawLimitY1, drawLimitY2
local GPUProxy, GPUProxyGetResolution, GPUProxySetResolution, GPUProxyGetBackground, GPUProxyGetForeground, GPUProxySetBackground, GPUProxySetForeground, GPUProxyGet, GPUProxySet, GPUProxyFill

local mathCeil, mathFloor, mathModf, mathAbs, mathMin, mathMax = math.ceil, math.floor, math.modf, math.abs, math.min, math.max
local tableInsert, tableConcat = table.insert, table.concat
local colorBlend, colorRGBToInteger, colorIntegerToRGB = color.blend, color.RGBToInteger, color.integerToRGB
local unicodeLen, unicodeSub = unicode.len, unicode.sub

--------------------------------------------------------------------------------

local function getIndex(x, y)
	return bufferWidth * (y - 1) + x
end

local function getCurrentFrameTables()
	return currentFrameBackgrounds, currentFrameForegrounds, currentFrameSymbols
end

local function getNewFrameTables()
	return newFrameBackgrounds, newFrameForegrounds, newFrameSymbols
end

--------------------------------------------------------------------------------

local function setDrawLimit(x1, y1, x2, y2)
	drawLimitX1, drawLimitY1, drawLimitX2, drawLimitY2 = x1, y1, x2, y2
end

local function resetDrawLimit()
	drawLimitX1, drawLimitY1, drawLimitX2, drawLimitY2 = 1, 1, bufferWidth, bufferHeight
end

local function getDrawLimit()
	return drawLimitX1, drawLimitY1, drawLimitX2, drawLimitY2
end

--------------------------------------------------------------------------------

local function flush(width, height)
	if not width or not height then
		width, height = GPUProxyGetResolution()
	end

	currentFrameBackgrounds, currentFrameForegrounds, currentFrameSymbols, newFrameBackgrounds, newFrameForegrounds, newFrameSymbols = {}, {}, {}, {}, {}, {}
	bufferWidth = width
	bufferHeight = height
	resetDrawLimit()

	for y = 1, bufferHeight do
		for x = 1, bufferWidth do
			tableInsert(currentFrameBackgrounds, 0x010101)
			tableInsert(currentFrameForegrounds, 0xFEFEFE)
			tableInsert(currentFrameSymbols, " ")

			tableInsert(newFrameBackgrounds, 0x010101)
			tableInsert(newFrameForegrounds, 0xFEFEFE)
			tableInsert(newFrameSymbols, " ")
		end
	end
end

local function setResolution(width, height)
	GPUProxySetResolution(width, height)
	flush(width, height)
end

local function getResolution()
	return bufferWidth, bufferHeight
end

local function getWidth()
	return bufferWidth
end

local function getHeight()
	return bufferHeight
end

local function bind(address, reset)
	local success, reason = GPUProxy.bind(address, reset)
	if success then
		if reset then
			setResolution(GPUProxy.maxResolution())
		else
			setResolution(bufferWidth, bufferHeight)
		end
	else
		return success, reason
	end
end

local function getGPUProxy()
	return GPUProxy
end

local function updateGPUProxyMethods()
	GPUProxyGet = GPUProxy.get
	GPUProxyGetResolution = GPUProxy.getResolution
	GPUProxyGetBackground = GPUProxy.getBackground
	GPUProxyGetForeground = GPUProxy.getForeground

	GPUProxySet = GPUProxy.set
	GPUProxySetResolution = GPUProxy.setResolution
	GPUProxySetBackground = GPUProxy.setBackground
	GPUProxySetForeground = GPUProxy.setForeground

	GPUProxyFill = GPUProxy.fill
end

local function setGPUProxy(proxy)
	GPUProxy = proxy
	updateGPUProxyMethods()
	flush()
end

local function getScaledResolution(scale)
	if not scale or scale > 1 then
		scale = 1
	elseif scale < 0.1 then
		scale = 0.1
	end

	local aspectWidth, aspectHeight = component.proxy(GPUProxy.getScreen()).getAspectRatio()
	local maxWidth, maxHeight = GPUProxy.maxResolution()
	local proportion = 2 * (16 * aspectWidth - 4.5) / (16 * aspectHeight - 4.5)
	 
	local height = scale * mathMin(
		maxWidth / proportion,
		maxWidth,
		math.sqrt(maxWidth * maxHeight / proportion)
	)

	return math.floor(height * proportion), math.floor(height)
end

--------------------------------------------------------------------------------

local function rawSet(index, background, foreground, symbol)
	newFrameBackgrounds[index], newFrameForegrounds[index], newFrameSymbols[index] = background, foreground, symbol
end

local function rawGet(index)
	return newFrameBackgrounds[index], newFrameForegrounds[index], newFrameSymbols[index]
end

local function get(x, y)
	if x >= 1 and y >= 1 and x <= bufferWidth and y <= bufferHeight then
		local index = bufferWidth * (y - 1) + x
		return newFrameBackgrounds[index], newFrameForegrounds[index], newFrameSymbols[index]
	else
		return 0x000000, 0x000000, " "
	end
end

local function set(x, y, background, foreground, symbol)
	if x >= drawLimitX1 and y >= drawLimitY1 and x <= drawLimitX2 and y <= drawLimitY2 then
		local index = bufferWidth * (y - 1) + x
		newFrameBackgrounds[index], newFrameForegrounds[index], newFrameSymbols[index] = background, foreground, symbol
	end
end

local function drawRectangle(x, y, width, height, background, foreground, symbol, transparency)
	local temp

	-- Clipping left
	if x < drawLimitX1 then
		width = width - drawLimitX1 + x
		x = drawLimitX1
	end

	-- Right
	temp = x + width - 1
	if temp > drawLimitX2 then
		width = width - temp + drawLimitX2
	end

	-- Top
	if y < drawLimitY1 then
		height = height - drawLimitY1 + y
		y = drawLimitY1
	end

	-- Bottom
	temp = y + height - 1
	if temp > drawLimitY2 then
		height = height - temp + drawLimitY2
	end

	temp = bufferWidth * (y - 1) + x
	local indexStepOnEveryLine = bufferWidth - width

	if transparency then
		for j = 1, height do
			for i = 1, width do
				newFrameBackgrounds[temp],
				newFrameForegrounds[temp] =
					colorBlend(newFrameBackgrounds[temp], background, transparency),
					colorBlend(newFrameForegrounds[temp], background, transparency)

				temp = temp + 1
			end

			temp = temp + indexStepOnEveryLine
		end
	else
		for j = 1, height do
			for i = 1, width do
				newFrameBackgrounds[temp],
				newFrameForegrounds[tem