local q = function()print('----------')end

local Menu = {}
Menu.__index = Menu
Menu.__metatable = 'Menu'
Menu.__empty = function()end;
--menu controller
local root = nil;

function Menu.new(text,callback)
	local self = setmetatable({},Menu)
	self.text = text
	self.parent = nil
	self.child = {}

	function self:addChild(node)
		table.insert(self.child,node)
		node:setParent(self)
	end
	function self:getChild()
		return self.child
	end
	function self:setParent(parent)
		self.parent = parent
	end
	function self:getParent()
		return self.parent
	end
	function self:printSelf()
		local str = '['..self.text..']\n'
		local s =''

		if #self.child>=0 then
			if self:getParent()~=nil then
			print('should be over here')
				str=str..'  0. Back\n'
			end
			for i=1,#self.child do
				s = string.format('  %i. %s\n',i,self.child[i].text)
				str = str..s
			end
		end
		return str
	end
	Menu.__tostring = self.printSelf
	if callback == nil then
		self.callback = function()print(self)end
	else
		self.callback = callback
	end

	function self:choose(i)
		root = self
		if i==nil then
			self.callback()
		elseif i==0 then
			self:back()
		else
			root = self.child[i]
			self.child[i].callback()
		end
	end
	function self:back()
		if root:getParent()~=nil then
			root:getParent():choose()
		end
	end
	return self
end



local m = Menu.new('Main Menu')
root = m
m:choose()
local s1 = Menu.new('submenu1',nil)
local s2 = Menu.new('submenu2',nil)
m:addChild(s1)
m:addChild(s2)

while(true) do
	q()
	root:choose()
	local s = io.read()
	if tonumber(s)~=nil and tonumber(s)<=#root:getChild() then
		root:choose(tonumber(s))
	else
		print ('do you wanna break:\n  1. No\n ')
		local breaker = io.read()
		if tonumber(breaker) ~= 1 then
			break
		end
	end
	q()
end
