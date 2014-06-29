local Player = {}
Player.__index = Player
Player.__metatable = "[Player]"
function Player.new(name,hp,atk,def)
	local mt = {}

	local self = setmetatable(mt,Player)

	self['name'] = name
	self['hp'] = hp
	self['maxhp'] = hp
	self['atk'] = atk
	self['def'] = def

	--[[
	GETTERS AND SETTERS
	--]]
	function self:getName()
		return self.name
	end
	function self:setName(name)
		self.name = name
	end

	function self:getAttack()
		return self.atk
	end
	function self:setAttack(atk)
		self.atk = atk
	end

	function self:getHitpoints()
		return self.hp
	end
	function self:setHitpoints(hp)
		self.hp = hp
	end
	function self:getMaxHp()
		return self.maxhp
	end
	function self:setMaxHp(maxhp)
		self.maxhp = maxhp
	end
	function self:getDefence()
		return self.def
	end
	function self:setDefence(def)
		self.def = def
	end
	--[[
	Complicated interactions
	]]
	function self:attack(p2)
		if getmetatable(p2)==getmetatable(self) then
			local damage = self:getAttack()-p2:getDefence()
			local hp = p2:getHitpoints()-damage
			if hp<=0 then
				hp = 0
			end
			p2:setHitpoints(hp)
			local n2 = self.name
			local n1 = p2:getName()
			if self~=p2 then
				print(n2..' hit '..n1..' for '..damage..'\n'
				..n1..' hitpoints:'..hp..'/'..self.maxhp)
			else
				print (n1..' attacked himself for '..damage..'\n'
				..'Poor idiot...\n'..
				n1..' hitpoints:'..hp..'/'..self.maxhp)
			end
		else
			error("You can't attack non-player")
		end
		print()
	end
	return self
end
---------------------------------------
--[[
RUNTIME SECTION
--]]
---------------------------------------
local p1 = Player.new("Adam",100,50,10)
local p2 = Player.new("Sathor",100,50,10)
print(getmetatable(p1))
p1:attack(p2)
p1:attack(p1)
