AddCSLuaFile()

ENT.Base            = "rpg_npc_employer_base"
ENT.Type            = "ai"

ENT.PrintName       = "NPC Programmer Employer"
ENT.Author          = "Almighty Laxz"
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "gmRPG"

ENT.Spawnable       = true

// How much money is given for working
ENT.energyRequired  = 3
ENT.intRequired     = 10

ENT.outcomePay      = {}
ENT.outcomePay[0]   = 20
ENT.outcomePay[1]   = 30
ENT.outcomePay[2]   = 40

ENT.outcomes        = {}
ENT.outcomes[0]     = "An average shift, boring and tedious." .. "\nMoney +" .. ENT.outcomePay[0] .. "\nEnergy -" .. ENT.energyRequired
ENT.outcomes[1]     = "You work extra hard to meet a deadline." .. "\nMoney +" .. ENT.outcomePay[1] .. "\nEnergy -" .. ENT.energyRequired
ENT.outcomes[2]     = "A program you worked hard on was finally released" .. "\nMoney +" .. ENT.outcomePay[2] .. "\nEnergy -" .. ENT.energyRequired

// Text that will be passed to the client derma
local employerText = "Greetings, looking for a coding job? \n\n Requires 10 Intelligence"
local acceptText = "Work"
local titleText = "Programmer Employer"

if SERVER then
    function ENT:Initialize( )
    	self:SetModel( "models/Characters/Hostage_01.mdl" )
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