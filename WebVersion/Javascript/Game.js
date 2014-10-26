// Base graphical components
var stage, graphics;

// Tile pack image
var TilePack;

// Tile System
var tileSys;

// Resources
var textures2Load = 0, texturesLoaded = 0;

function init()
{
	stage = document.getElementById("Stage");
	graphics = stage.getContext("2d");
	
	graphics.scale(2,2);
	
	TilePack = loadImage("PacMan_TilePack.png");
	
}

function start()
{
	tileSys = new TileSystem(TilePack);
	draw();
}

function draw()
{
	// Clear bg
	//graphics.clearRect(0,0,stage.width,stage.height);
	graphics.fillRect(0,0,stage.width,stage.height);
	
	// Draw Tiles
	tileSys.draw(graphics);
}

function loadImage(name)
{
	textures2Load++;
	var newImg = new Image();
	newImg.src = "Resources/" + name;
	newImg.addEventListener("load", onImageLoaded);
	return newImg;
}

function onImageLoaded()
{
	texturesLoaded++;
	if (textures2Load == texturesLoaded)
	{
		start();
	}
}

// -- Entry -- //
window.onload = init;