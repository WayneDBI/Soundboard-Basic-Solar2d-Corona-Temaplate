---------------------------------------------------------------------------------
--
-- scene_02.lua
--
---------------------------------------------------------------------------------

local storyboard 		= require( "storyboard" )
local ui 				= require("ui")
require "gameUI"

local scene = storyboard.newScene()

-- vars local
local mainSpriteGroup 		= nil
local imageSprite			= nil

--Here we just setup a SOUND to prime the sound controller
local currentSound		= audio.loadSound( audioPath.."01_Horror/Bite.mp3" )

local spritePath 		= ""
local soundType 		= ".mp3"
local triggerSound		= nil
local stageRefernce		= sceneID.."_"
local board = {}

local myButtonsGroup1 = display.newGroup()
local myButtonsGroup2 = display.newGroup()
local myButtonsGroup3 = display.newGroup()
local myButtonsGroup4 = display.newGroup()
local myButtonsGroup5 = display.newGroup()
local myButtonsGroup6 = display.newGroup()

local this_btn = nil
local baseX = 103
local baseY = 110
local offsetX = 134
local offsetY = 48

local slideCounter = 0


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
			
			spritePath = imagePath.."_sceneArt/"..subImagePath
			
			-- backdrop
			imageSprite = display.newImage( spritePath..sceneID.."_Background.png")
			imageSprite.x = _w/2
			imageSprite.y = _h/2
			screenGroup:insert( imageSprite )
	
			-- bottom Banner
			imageSprite = display.newImage( imagePath.."bannerBottom.png")
			imageSprite.x = _w/2
			imageSprite.y = _h-21
			screenGroup:insert( imageSprite )

			-- top Banner
			imageSprite = display.newImage( imagePath.."bannerTop.png")
			imageSprite.x = _w/2
			imageSprite.y = 45
			screenGroup:insert( imageSprite )
	
			-- banner info
			imageSprite = display.newImage( spritePath..sceneID.."_Header.png")
			imageSprite.x = _w-114
			imageSprite.y = 32
			screenGroup:insert( imageSprite )

			--------------------------------------------------------------------------------------------------------------------
			-- Slider Setup
			slider = require( "slider" )
			slider:init()
			sliderSprite = slider:getSprite()
			mainSpriteGroup:insert( sliderSprite )
			
			local function nullSlider()
				local sliderGroup = nil
				local sliderButtonSprites = nil
				local textInfo_tbl = {}
				local btnInfo_tbl = {}
				local this_btn = nil
			end

			-- Add as many sliders as you require CHNAGE the renderSlide VALUE each time		
			nullSlider()
			sliderGroup = createSlider1( 1, textInfo_tbl, btnInfo_tbl )		--Change the Integer variable to the new Slider Panel Number
			sliderButtonSprites = renderSlideBtn( 1, _w )				  	--Change the Integer variable to the new Slider Panel Number
			slider.addSlide( sliderGroup, sliderButtonSprites )

			nullSlider()
			sliderGroup = renderSlide2( 2, textInfo_tbl, btnInfo_tbl )  	--Change the Integer variable to the new Slider Panel Number
			sliderButtonSprites = renderSlideBtn( 2, _w )  					--Change the Integer variable to the new Slider Panel Number
			slider.addSlide( sliderGroup, sliderButtonSprites )
			--------------------------------------------------------------------------------------------------------------------



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
		
		----------------------------------------------------------------------------------------------------
		-- CREATE SLIDE 1
		-- Here we setup the base slide and add all the buttons
		----------------------------------------------------------------------------------------------------
		function createSlider1( slideIndex, textInfo_tbl, btnInfo_tbl )
			-- sliderGroup
			local sliderGroup = display.newGroup()
			
			-- sliderInvisibleSprite
			local sliderInvisibleSprite = display.newImage( imagePath.."slide_bck.png",134,48 )
			sliderGroup:insert( sliderInvisibleSprite )
					
			-- A local function to create the Button GroupMatrix
			-- Note we capture the [Buttons Name[, [X Pos], [Y Pos], [Audio File Name], [NA], [Buttons ID]
			local function createSceneButton(butName, posX, posY, audioFile, isEmail, butId)
				myButtonsGroup1 = display.newGroup()
				local img = display.newImage( spritePath..butName.."_OFF"..".png" )
				local img2 = display.newImage( spritePath..butName.."_ON"..".png" )
				myButtonsGroup1:insert(img)
				myButtonsGroup1:insert(img2)
				--myButtonsGroup1:setReferencePoint(display.TopCenterReferencePoint)
				myButtonsGroup1.anchorX = 0.5		-- Graphics 2.0 Anchoring method
				myButtonsGroup1.anchorY = 0.5		-- Graphics 2.0 Anchoring method
				myButtonsGroup1.isHitTestable = true
				myButtonsGroup1.imgVisible = true
				myButtonsGroup1.x = posX
				myButtonsGroup1.y = posY
				-----------------------------------
				myButtonsGroup1.id = butId
				myButtonsGroup1.tag = audioFile
				-----------------------------------
				myButtonsGroup1[1].alpha = 1
				myButtonsGroup1[2].alpha = 0
				myButtonsGroup1:addEventListener( "tap", tapCb)
				sliderGroup:insert( myButtonsGroup1 )
			end
			
			-- Here we are putting the remainder of the buttons onto the screen based on our base co-ordinates (set at the top).
			-- The X and Y offset data just helps with positioning the buttons. We set a START X,Y and an OFFSET value at the
			-- top of this lua file. Then we multiply those values to offset the buttons around the screen (in the Slider Group).
			createSceneButton(stageRefernce.."01", (baseX + (offsetX * 0)), (baseY + (offsetY * 0)), "Beast1", 		"No", 1)
			createSceneButton(stageRefernce.."02", (baseX + (offsetX * 1)), (baseY + (offsetY * 0)), "Beast1", 		"No", 2)
			createSceneButton(stageRefernce.."03", (baseX + (offsetX * 2)), (baseY + (offsetY * 0)), "Beast1", 		"No", 3)
			createSceneButton(stageRefernce.."04", (baseX + (offsetX * 0)), (baseY + (offsetY * 1)), "Beast1", 		"No", 4)
			createSceneButton(stageRefernce.."05", (baseX + (offsetX * 1)), (baseY + (offsetY * 1)), "Beast1", 		"No", 5)
			createSceneButton(stageRefernce.."06", (baseX + (offsetX * 2)), (baseY + (offsetY * 1)), "Beast1", 		"No", 6)
			createSceneButton(stageRefernce.."07", (baseX + (offsetX * 0)), (baseY + (offsetY * 2)), "Beast1", 		"No", 7)
			createSceneButton(stageRefernce.."08", (baseX + (offsetX * 1)), (baseY + (offsetY * 2)), "Beast1", 		"No", 8)
			createSceneButton(stageRefernce.."09", (baseX + (offsetX * 2)), (baseY + (offsetY * 2)), "Beast1", 		"No", 9)
			createSceneButton(stageRefernce.."10", (baseX + (offsetX * 0)), (baseY + (offsetY * 3)), "Beast1", 		"No", 10)
			createSceneButton(stageRefernce.."11", (baseX + (offsetX * 1)), (baseY + (offsetY * 3)), "Beast1", 		"No", 11)
			createSceneButton(stageRefernce.."12", (baseX + (offsetX * 2)), (baseY + (offsetY * 3)), "Beast1", 		"No", 12)
			
			--Insert the Buttons and the Slider group into the main Scene Group
			screenGroup:insert( sliderGroup )
			screenGroup:insert( mainSpriteGroup )

			return sliderGroup
			
		end
		----------------------------------------------------------------------------------------------------
		
		
		----------------------------------------------------------------------------------------------------
		-- CREATE SLIDE 2
		-- Here we setup the base slide and add all the buttons
		----------------------------------------------------------------------------------------------------
		function renderSlide2( slideIndex, textInfo_tbl, btnInfo_tbl )
			-- sliderGroup
			local sliderGroup = display.newGroup()
			
			-- sliderInvisibleSprite
			local sliderInvisibleSprite = display.newImage( imagePath.."slide_bck.png" )
			sliderGroup:insert( sliderInvisibleSprite )
			
			
			-- A local function to create the Button GroupMatrix
			-- Note we capture the [Buttons Name[, [X Pos], [Y Pos], [Audio File Name], [NA], [Buttons ID]
			local function createSceneButton(butName, posX, posY, audioFile, isEmail, butId)
				myButtonsGroup2 = display.newGroup()
				local img = display.newImage( spritePath..butName.."_OFF"..".png" )
				local img2 = display.newImage( spritePath..butName.."_ON"..".png" )
				myButtonsGroup2:insert(img)
				myButtonsGroup2:insert(img2)
				--myButtonsGroup2:setReferencePoint(display.TopCenterReferencePoint)
				myButtonsGroup2.anchorX = 0.5		-- Graphics 2.0 Anchoring method
				myButtonsGroup2.anchorY = 0.5		-- Graphics 2.0 Anchoring method
				myButtonsGroup2.isHitTestable = true
				myButtonsGroup2.imgVisible = true
				myButtonsGroup2.x = posX
				myButtonsGroup2.y = posY
				-----------------------------------
				myButtonsGroup2.id = butId
				myButtonsGroup2.tag = audioFile
				-----------------------------------
				myButtonsGroup2[1].alpha = 1
				myButtonsGroup2[2].alpha = 0
				myButtonsGroup2:addEventListener( "tap", tapCb)
				sliderGroup:insert( myButtonsGroup2 )
			end
			
			-- Here we are putting the remainder of the buttons onto the screen based on our base co-ordinates (set at the top).
			-- The X and Y offset data just helps with positioning the buttons. We set a START X,Y and an OFFSET value at the
			-- top of this lua file. Then we multiply those values to offset the buttons around the screen (in the Slider Group).
			createSceneButton(stageRefernce.."13", (baseX + (offsetX * 0)), (baseY + (offsetY * 0)), "Beast1", 		"No", 13)
			createSceneButton(stageRefernce.."14", (baseX + (offsetX * 1)), (baseY + (offsetY * 0)), "Beast1", 		"No", 14)
			createSceneButton(stageRefernce.."15", (baseX + (offsetX * 2)), (baseY + (offsetY * 0)), "Beast1", 		"No", 15)
			createSceneButton(stageRefernce.."16", (baseX + (offsetX * 0)), (baseY + (offsetY * 1)), "Beast1", 		"No", 16)
			createSceneButton(stageRefernce.."17", (baseX + (offsetX * 1)), (baseY + (offsetY * 1)), "Beast1", 		"No", 17)
			createSceneButton(stageRefernce.."18", (baseX + (offsetX * 2)), (baseY + (offsetY * 1)), "Beast1", 		"No", 18)
		
			--Insert the Buttons and the Slider group into the main Scene Group
			screenGroup:insert( sliderGroup )
			screenGroup:insert( mainSpriteGroup )

			return sliderGroup
			
		end
		----------------------------------------------------------------------------------------------------
		--For MORE slides, simply copy the CREATE SLIDE code, changing the references to 3,4,5 etc etc..
		----------------------------------------------------------------------------------------------------
		
		----------------------------------------------------------------------------------------------------
		-- Create the Dots at bottom of the Screen
		----------------------------------------------------------------------------------------------------
		function renderSlideBtn( btnIndex, slideWidth )
		
			-- How many slides are there?
			local numBtns = 2
			
			-- Setup the Dots, to show how many slides there are.
			local sliderButtonSprites = display.newGroup()
			sliderButtonSprites.x = 12 + 0.5 * slideWidth + (btnIndex - 0.5 * numBtns - 1) * 20
			sliderButtonSprites.y = 305
			sliderButtonSprites.id = btnIndex
			
			-- Set up an ON dot for the specific panel
			local btnOn_sprt = display.newImage( imagePath.."PageIndicatorSelected.png" )
			sliderButtonSprites:insert(btnOn_sprt)
			
			-- Set up an OFF dot for the specific panel
			local btnOff_sprt = display.newImage( imagePath.."PageIndicatorNormal.png" )
			sliderButtonSprites:insert(btnOff_sprt)
			btnOff_sprt.isVisible = false
			
			return sliderButtonSprites
			
		end
		
		----------------------------------------------------------------------------------------------------
		-- Play a Sound when our button is pressed
		-- NOTE: we'll load the sound based on the CAPTURED data from the button in the slider.
		----------------------------------------------------------------------------------------------------
		function tapCb( evt )
			
			local btnId 	= evt.target.id
			local btnSound	= evt.target.tag
			------------------------------------
			local saveX = evt.target.x
			local saveY = evt.target.y
			------------------------------------
			local function audioFinished()
			   evt.target[1].alpha = 1 -- img to be invisible
			   evt.target[2].alpha = 0 -- img2 to be visible
			end
	
			evt.target[1].alpha = 0 -- img to be invisible
			evt.target[2].alpha = 1 -- img2 to be visible
			timer.performWithDelay(200, audioFinished )
	
			-- Show which button was tapped
			print( "btnId = " .. btnSound )
			
			--Clean up and then play the new sound
			audio.dispose()
			audio.stop()
			audio.rewind()
			currentSound = audio.loadSound( audioPath..subImagePath..btnSound..soundType )
			audio.play(currentSound)
			
		
		end

		-- Get the ball rolling!
		init()
		
	
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	-- remove previous scene's view
	storyboard.removeScene( "main" )
	storyboard.removeScene( "scene_01" )
	--storyboard.removeScene( "scene_02" )
	storyboard.removeScene( "scene_03" )
	storyboard.removeScene( "scene_04" )
	storyboard.removeScene( "scene_05" )
	storyboard.removeScene( "scene_Start" )
	storyboard.removeScene( "scene_Info" )
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
		
	audio.dispose()
	audio.stop()
	
	myButtonsGroup1:removeEventListener( "tap", tapCb)
	myButtonsGroup2:removeEventListener( "tap", tapCb)
		
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