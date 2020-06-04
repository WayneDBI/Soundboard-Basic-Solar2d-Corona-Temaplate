------------------------------------------------------------------------------------------------------------------------------------
-- SFX Library & Soundboard
-- Target iPhone.
------------------------------------------------------------------------------------------------------------------------------------
-- Developed by Deep Blue Apps.com [http:www.deepbueapps.com]
------------------------------------------------------------------------------------------------------------------------------------
-- Abstract: A very simple Soundboard type template for the Corona Platform.
-- Press a button to hear a sound played back.
-- Additionally, this same code base can be used as the beginnings of a menu select system.
-- See in the code as we capture the buttons ID and store its reference in a global variable.
-- This template is setup to be as clearly editable as possible, however to further optimise
-- you would ideally use a single scene for the Soundboards, with the Audio file names etc stored
-- in an Array/Tables. Additionally the buttons would either be a SpriteSheet or you would use a single
-- button, changing the TEXT over the top. This example demonstrates using 2 x buttons for EACH sound.
-- That said, the app runs very smooth, and has a relatively low memory footprint.
------------------------------------------------------------------------------------------------------------------------------------
--
-- main.lua
--
------------------------------------------------------------------------------------------------------------------------------------
-- 20th Feb 2014 : Version 3
------------------------------------------------------------------------------------------------------------------------------------

display.setStatusBar( display.HiddenStatusBar )

_G.sprite = require "sprite"							-- Add SPRITE API for Graphics 1.0

-- require controller modules
local storyboard 		= require "storyboard"
local scene 			= storyboard.newScene()

local bck_shp = nil

-- Define some GLOBAL variables
_G._w 					= display.contentWidth  		-- Get the devices Width
_G._h 					= display.contentHeight 		-- Get the devices Height
_G.sfxVolume			= 1								-- Default SFX Volume
_G.musicVolume			= 0.3							-- Default Music Volume
_G.imagePath			= "assets/"
_G.subImagePath			= "00"
_G.sceneID				= "00"
_G.audioPath			= "assets/_sceneSounds/"


local doDebug = false

-- Debug Data
if (doDebug) then
	local fps = require("fps")
	local performance = fps.PerformanceOutput.new();
	performance.group.x, performance.group.y = display.contentWidth/2,  270;
	performance.alpha = 0.3; -- So it doesn't get in the way of the rest of the scene
end


function startGame()
	-- load first screen
	image:removeSelf()
	image=nil
	
storyboard.gotoScene( "scene_Start" )
end

image = display.newImage( "Default.png" )
image.x = display.contentWidth/2
image.y = display.contentHeight/2


--Start GAme after a short delay.
timer.performWithDelay(1800, startGame )
