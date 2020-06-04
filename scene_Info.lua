---------------------------------------------------------------------------------
--
-- scene_info.lua
--
---------------------------------------------------------------------------------

local storyboard 		= require( "storyboard" )
local ui 				= require("ui")
require "gameUI"

local scene = storyboard.newScene()

-- vars local
local mainSpriteGroup 		= nil
local imageSprite			= nil


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Go to the Menu screen if user taps the HOME button
local buttonHandler = function( event )

	if (event.id == "home" and event.phase == "release") then
		storyboard.gotoScene( "scene_Start", "crossFade", 200  )
		return true
	end
	
end


-- Called when the scene's view does not exist:
function scene:createScene( event )
	local screenGroup = self.view
		
		----------------------------------------------------------------------------------------------------
		-- init
		----------------------------------------------------------------------------------------------------
		local function init()
				
			-- mainSpriteGroup
			mainSpriteGroup = display.newGroup()
						
			-- backdrop
			imageSprite = display.newImage( "Default.png")
			imageSprite.x = _w/2
			imageSprite.y = _h/2
			screenGroup:insert( imageSprite )


			--------------------------------------------------------------------------------------------------------------------
			-- MENU HOME Button 1
			--------------------------------------------------------------------------------------------------------------------
			button1 = ui.newButton{
			default = imagePath.."buttonHome1.png",
			over = imagePath.."buttonHome2.png",
			onEvent = buttonHandler, x = 29, y = _h-26, id = "home"
			}
			screenGroup:insert( button1 )

			--------------------------------------------------------------------------------------------------------------------
			-- MENU HOME Button 2
			--------------------------------------------------------------------------------------------------------------------
			button2 = ui.newButton{
			default = imagePath.."textMenu.png",
			over = imagePath.."textMenu.png",
			onEvent = buttonHandler, x = 78, y = _h-13, id = "home"
			}
			screenGroup:insert( button2 )

			
		end

		-- Get the ball rolling!
		init()
		
	
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
	storyboard.removeScene( "scene_Start" )
	--storyboard.removeScene( "scene_Info" )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
		
	audio.dispose()
	audio.stop()
			
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	print( "((destroying scene[..] view))" )
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