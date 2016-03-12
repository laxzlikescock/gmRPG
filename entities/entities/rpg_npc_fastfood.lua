AddCSLuaFile()

ENT.Base            = "rpg_npc_employer_base"
ENT.Type            = "ai"

ENT.PrintName       = "NPC Fastfood Employer"
ENT.Author          = "Almighty Laxz"
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "gmRPG"

ENT.Spawnable       = true

// How much money is given for working
ENT.energyRequired  = 4
ENT.intRequired     = 5

ENT.wage            = 12

ENT.outcomeBonus    = {}
ENT.outcomeBonus[0] = 0
ENT.outcomeBonus[1] = 3
ENT.outcomeBonus[2] = 8

ENT.outcomes        = {}
ENT.outcomes[0]     = "An average shift feeding obese customers." .. "\nMoney + " .. ENT.wage * 3 .. "\nEnergy - " .. ENT.energyRequired
ENT.outcomes[1]     = "You flip patties like there's no tomorrrow." .. "\nMoney + " .. ENT.wage * 3 + ENT.outcomeBonus[1] .. "\nEnergy - " .. ENT.energyRequired
ENT.outcomes[2]     = "The boss is impressed with your hard work." .. "\nMoney + " .. ENT.wage * 3 + ENT.outcomeBonus[2] .. "\nEnergy - " .. ENT.energyRequired

// Text that will be passed to the client derma
local employerText = "Hello, looking for work? \n\nWage: $12/hour"
local acceptText = "Work"
local titleText = "Fastfood Employer"

if SERVER then
    function ENT:Initialize( )
    	self:SetModel( "models/breen.mdl" )
    	self:SetHullType( HULL_HUMAN )
    	self:SetHullSizeNormal( )
    	self:SetNPCState( NPC_STATE_SCRIPT )
    	self:SetSolid(  SOLID_BBOX )
    	self:CapabilitiesAdd( CAP_ANIMATEDFACE, CAP_TURN_HEAD )
    	self:SetUseType( SIMPLE_USE )
    	self:DropToFloor()
    end

    function ENT:AcceptInput( Name, Activator, Caller )

    	if !Activator.cantUse and Activator:IsPlayer() then
    		Activator.cantUse = true
    		net.Start("rpgEmploymentDermaStart")
                net.WriteString(employerText)
                net.WriteString(acceptText)
                net.WriteString(titleText)
                net.WriteEntity(self)
    		net.Send(Activator)
    		timer.Simple(1, function()
    			Activator.cantUse = false
    		end)
    	end
    end
end
