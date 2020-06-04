---------------------------------------------------------------------------------
--
-- scene_Start.lua
--
---------------------------------------------------------------------------------

local storyboard 		= require( "storyboard" )
local ui 				= require("ui")
local scene 			= storyboard.newScene()

-- Touch event listener for background image
local function onSceneTouch( self, event )

end


local buttonHandler = function( event )

	--Show which button pressed, and its phase in Terminal
	print (event.id.." : "..event.phase.. " : Level: "..event.levelSelect)

	--Capture the SUB FOLDER we'll use the buttons id for this data
	subImagePath 	= event.id.."/"
	
	--Capture the scenes ID - you could use this to capture the selected level.
	--NOTE: We have added the [levelSelect] reference to the ui.lua file
	sceneID			= event.levelSelect
	
	--Detect which button was pressed and goto that scene
	if (event.id == "01_Horror" and event.phase == "release") then
		storyboard.gotoScene( "scene_01", "crossFade", 400  )
		return true
		
	elseif (event.id == "02_Fantasy" and event.phase == "release") then
		storyboard.gotoScene( "scene_02", "crossFade", 400  )
		return true
		
	elseif (event.id == "03_Kids" and event.phase == "release") then
		storyboard.gotoScene( "scene_03", "crossFade", 400  )
		return true
		
	elseif (event.id == "04_Natural" and event.phase == "release") then
		storyboard.gotoScene( "scene_04", "crossFade", 400  )
		return true
		
	elseif (event.id == "05_SciFi" and event.phase == "release") then
		storyboard.gotoScene( "scene_05", "crossFade", 400  )
		return true
		
	elseif (event.id == "moreInfo" and event.phase == "release") then
		storyboard.gotoScene( "scene_Info", "crossFade", 400  )
		return true
	end
	
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view

			local spritePath = imagePath
			
			--Set up the Background image
			bck_shp = display.newImage( spritePath.."homeBackground.png" )
			bck_shp.x = _w/2
			bck_shp.y = _h/2
			screenGroup:insert( bck_shp )


			--Add Button controls
			button1 = ui.newButton{
				default = spritePath.."01_Select_OFF.png",
				over = spritePath.."01_Select_ON.png",
				onEvent = buttonHandler, x = 94, y = 150, id = "01_Horror", levelSelect = "01"
			}
			screenGroup:insert( button1 )

			button1 = ui.newButton{
				default = spritePath.."02_Select_OFF.png",
				over = spritePath.."02_Select_ON.png",
				onEvent = buttonHandler, x = 94, y = 243, id = "02_Fantasy", levelSelect = "02"
			}
			screenGroup:insert( button1 )

			button1 = ui.newButton{
				default = spritePath.."03_Select_OFF.png",
				over = spritePath.."03_Select_ON.png",
				onEvent = buttonHandler, x = 235, y = 150, id = "03_Kids", levelSelect = "03"
			}
			screenGroup:insert( button1 )
			
			button1 = ui.newButton{
				default = spritePath.."04_Select_OFF.png",
				over = spritePath.."04_Select_ON.png",
				onEvent = buttonHandler, x = 235, y = 243, id = "04_Natural", levelSelect = "04"
			}
			screenGroup:insert( button1 )
			
			button1 = ui.newButton{
				default = spritePath.."05_Select_OFF.png",
				over = spritePath.."05_Select_ON.png",
				onEvent = buttonHandler, x = 375, y = 150, id = "05_SciFi", levelSelect = "05"
			}
			screenGroup:insert( button1 )

			button1 = ui.newButton{
				default = spritePath.."info_Select_OFF.png",
				over = spritePath.."info_Select_ON.png",
				onEvent = buttonHandler, x = 375, y = 243, id = "moreInfo", levelSelect = "00"
			}
			screenGroup:insert( button1 )
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )

	-- remove previous scene's view
	storyboard.removeScene( "main" )
	storyboard.removeScene( "scene_01" )
	storyboard.removeScene( "scene_02" )
	storyboard.removeScene( "scene_03" )
	storyboard.removeScene( "scene_04" )
	storyboard.removeScene( "scene_05" )
	--storyboard.removeScene( "scene_Start" )
	storyboard.removeScene( "scene_Info" )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
		

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	
	print( "((destroying scene[MENU] view))" )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene