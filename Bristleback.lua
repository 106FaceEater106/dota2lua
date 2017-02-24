-- Author: Dj-jom2x

local brstle = {}

brstle.optionEnable = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Enabled", "")
brstle.optionKey = Menu.AddKeyOption({"Hero Specific", "Bristle Back"}, "ComboKey", Enum.ButtonCode.KEY_F)
brstle.autospray = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Auto Spray", "auto spray when enemy get close to you")
brstle.autonasal = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Auto Nasal Goo", "auto goo when enemy get close to you")
brstle.useshiva = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Shiva", "use shiva if enemy is closer")
brstle.usecrimson = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Crimson", "")
brstle.usepipe = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Pipe", "")
brstle.usehood = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Hood", "")
brstle.usemail = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use BladeMail", "")
brstle.usebkb = Menu.AddOption({"Hero Specific", "Bristle Back"}, "Use Black King Bar", "")


 
function brstle.OnUpdate()
 if not Menu.IsEnabled(brstle.optionEnable) then return true end
 brstle.StartCombo()
end


function brstle.StartCombo()
  
  local getMyChamp = Heroes.GetLocal()
  if NPC.GetUnitName(getMyChamp) ~= "npc_dota_hero_bristleback" then return end
  local hero = Input.GetNearestHeroToCursor(Entity.GetTeamNum(getMyChamp), Enum.TeamType.TEAM_ENEMY) 
  if not hero then return end
  
  -- own abilities
  
  local heroPos = NPC.GetAbsOrigin(hero)
  local nasalgoo = NPC.GetAbilityByIndex(getMyChamp,0)
  local spray = NPC.GetAbilityByIndex(getMyChamp,1)
  local champMana = NPC.GetMana(getMyChamp)
  
  -- 3rd party abilities
  
  local shiva = NPC.GetItem(getMyChamp, "item_shivas_guard", true)
  local crson = NPC.GetItem(getMyChamp, "item_crimson_guard", true)
  local pipe = NPC.GetItem(getMyChamp, "item_pipe", true)
  local hood = NPC.GetItem(getMyChamp, "item_hood_of_defiance", true)
  local bm = NPC.GetItem(getMyChamp, "item_blade_mail", true)
  local agha = NPC.GetItem(getMyChamp, "item_ultimate_scepter", true)
  local bkb = NPC.GetItem(getMyChamp, "item_black_king_bar", true)
  
  
  
  if Menu.IsEnabled(brstle.autospray) then
    
     brstle.DoSomething(spray,champMana,getMyChamp,hero,false)
  
  end

  if Menu.IsEnabled(brstle.autonasal) then
    
    if agha then
        brstle.DoSomething(nasalgoo,champMana,getMyChamp,hero,false)
    else
        brstle.DoSomething(nasalgoo,champMana,getMyChamp,hero,true)
    end
  
  end
  
  if Menu.IsKeyDown(brstle.optionKey) then 
 
    
      brstle.CastSomething(shiva,champMana,brstle.useshiva)
      
      brstle.CastSomething(crson,champMana,brstle.usecrimson)
      
      brstle.CastSomething(hood,champMana,brstle.usehood)
      
      brstle.CastSomething(bm,champMana,brstle.usemail)
      
      brstle.CastSomething(bkb,champMana,brstle.usebkb)
      
      brstle.CastSomething(pipe,champMana,brstle.usepipe)

    
      if not Menu.IsEnabled(brstle.autonasal) then
        
        if agha then
          brstle.DoSomething(nasalgoo,champMana,getMyChamp,hero,false)
        else
          brstle.DoSomething(nasalgoo,champMana,getMyChamp,hero,true)
        end
        
      end
      
      if not Menu.IsEnabled(brstle.autospray) then
       
          brstle.DoSomething(spray,champMana,getMyChamp,hero,false)
          
      end
      
  end

end

function brstle.CastSomething(item,champMana,getMenuName)
  
    if item and Ability.IsCastable(item,champMana) and Menu.IsEnabled(getMenuName) then 
      
        Ability.CastNoTarget(item)
     
    end
  
end

function brstle.DoSomething(skill,champMana,getMyChamp,hero,isTarget)
  
    if Ability.IsCastable(skill, champMana) and
    hero ~=nil and 
    NPC.IsPositionInRange(getMyChamp,NPC.GetAbsOrigin(hero), Ability.GetCastRange(skill) , 0)  then
      if isTarget then
        Ability.CastTarget(skill, hero)
      else
        Ability.CastNoTarget(skill)
      end
    return end
  
end

return brstle  
