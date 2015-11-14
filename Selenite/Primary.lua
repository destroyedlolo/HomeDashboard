-- This page contains all the information for the primary surface

-- Design of the display

local HSGRPH = 30	-- Height of small graphs
local VBAR1 = 160	-- position of the first vertical bar
local VBAR2 = 500	-- position of the first vertical bar
BARZOOM = 5	-- Magnify bar

ThermImg = SelImage.create(SELENE_SCRIPT_DIR .. "/Images/Thermometre.png")

-- compatibility with newer Lua
local unpack = unpack or table.unpack

-----
-- Electricity
-----

-- title
psrf:SetFont( ftitle )
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( VBAR1, 0, VBAR1, psrf:GetHeight() )
psrf:DrawString("Electricité :", 5,0)
local offy = 5+ftitle:GetHeight()

psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tension EDF :", 5, offy )
offy = offy + ftitle1:GetHeight()
srf_tension = psrf:SubSurface( 10, offy, VBAR1-20, fmdigit:GetHeight() )
srf_tension:SetFont( fmdigit )
srf_tension:SetColor( unpack(COL_DIGIT) )
offy = offy + fmdigit:GetHeight()

psrf:DrawString("Consommation :", 5, offy)
offy = offy + ftitle1:GetHeight()
srf_consommation = psrf:SubSurface( 10, offy, VBAR1-20, fdigit:GetHeight() )
srf_consommation:SetFont( fdigit )
srf_consommation:SetColor( unpack(COL_DIGIT) )
offy = offy + fdigit:GetHeight()
local xoffmaxc = VBAR1 - (5 + fsdigit:StringWidth("12345"))
srf_maxconso = psrf:SubSurface( xoffmaxc, offy, fsdigit:StringWidth("12345"), HSGRPH);
srf_maxconso:SetFont( fsdigit )
srf_maxconso:SetColor( unpack(COL_DIGIT) )
srf_consogfx = psrf:SubSurface( 5, offy, xoffmaxc -5, HSGRPH)
srf_consogfx:SetColor( unpack(COL_RED) )
offy = offy + HSGRPH

psrf:DrawString("Production :", 5, offy)
offy = offy + ftitle1:GetHeight()
srf_production = psrf:SubSurface( 10, offy, VBAR1-20, fdigit:GetHeight() )
srf_production:SetFont( fdigit )
srf_production:SetColor( unpack(COL_DIGIT) )
offy = offy + fdigit:GetHeight()
srf_maxprod = psrf:SubSurface( xoffmaxc, offy, fsdigit:StringWidth("12345"), HSGRPH);
srf_maxprod:SetFont( fsdigit )
srf_maxprod:SetColor( unpack(COL_DIGIT) )
srf_prodgfx = psrf:SubSurface( 5, offy, xoffmaxc -5, HSGRPH)
srf_prodgfx:SetColor( unpack(COL_RED) )
offy = offy + HSGRPH + 15

-----
-- Keys temperatures
-----

psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine(0, offy, VBAR1, offy )
offy = offy + 15
psrf:SetColor( unpack(COL_TITLE) )
ThermImg:RenderTo( psrf, { 10, offy + 20, 25,90 } )

psrf:DrawString("Salon :", 65, offy)
offy = offy + ftitle1:GetHeight()
srf_TSalon = psrf:SubSurface( 35, offy, fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TSalon:SetFont( fdigit )
offy = offy + fdigit:GetHeight()

psrf:DrawString("Dehors :", 65, offy)
offy = offy + ftitle1:GetHeight()
srf_TDehors = psrf:SubSurface( 35, offy, fdigit:StringWidth("-888.8°C"), fdigit:GetHeight() )
srf_TDehors:SetFont( fdigit )
srf_TDehors:SetColor( unpack(COL_DIGIT) )
offy = offy + fdigit:GetHeight()

----
-- Onduleur
----
psrf:SetFont( ftitle1 )
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Onduleur :", VBAR1 + 5, 0 )
srf_consoUPS = psrf:SubSurface( VBAR1 + 5 + ftitle1:StringWidth("Onduleur : "), 0, ftitle1:StringWidth("200.6 W"), ftitle1:GetHeight() )
srf_consoUPS:SetColor( unpack(COL_DIGIT) )
srf_consoUPS:SetFont( ftitle1 )

local tx,ty = srf_consoUPS:GetPosition()
local tw,th = srf_consoUPS:GetSize()
local goffy = ty + th + 2	-- bar's offset
bar_ups = { x=VBAR1+6, y=goffy+1, w=tx+tw-VBAR1-1, h=10 }
psrf:SetColor( unpack( COL_LIGHTGREY ) )
psrf:DrawRectangle( bar_ups.x-1, bar_ups.y-1, bar_ups.w+2, bar_ups.h+2 )

local xcursor = tx + tw + 12	-- x cursor
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( xcursor, 0, xcursor, bar_ups.y + bar_ups.h + 4 )

----
-- Internet
----

xcursor = xcursor + 8
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Internet :", xcursor, 0 )
srf_Internet = psrf:SubSurface( xcursor + ftitle1:StringWidth("Internet : "), 0, ftitle1:StringWidth("8888 kb / 2000 kb"), ftitle1:GetHeight() )
srf_Internet:SetColor( unpack(COL_DIGIT) )
srf_Internet:SetFont( ftitle1 )

tx, ty = srf_Internet:GetPosition()
tw, th = srf_Internet:GetSize()
tw = tx + tw - xcursor	-- width for bars
bar_Idn = { x=xcursor+1, y=goffy+1, w=tw/2-2, h=10 }
bar_Iup = { x=xcursor + tw/2 +4, y=goffy+1, w=tw/2-2, h=10 }
psrf:SetColor( unpack( COL_LIGHTGREY ) )
psrf:DrawRectangle( bar_Idn.x-1, bar_Idn.y-1, bar_Idn.w+2, bar_Idn.h+2 )
psrf:DrawRectangle( bar_Iup.x-1, bar_Iup.y-1, bar_Iup.w+2, bar_Iup.h+2 )

xcursor = bar_Iup.x + bar_Iup.w + 5
psrf:SetColor( unpack(COL_BORDER) )
psrf:DrawLine( xcursor, 0, xcursor, bar_ups.y + bar_ups.h + 4 )

----
-- Tablette
----

xcursor = xcursor + 6
psrf:SetColor( unpack(COL_TITLE) )
psrf:DrawString("Tablette :", xcursor, 0 )
srf_tabpwr = psrf:SubSurface( xcursor + ftitle1:StringWidth("Tablette :"), 0, ftitle1:StringWidth("88.88 W"), ftitle1:GetHeight() )
srf_tabpwr:SetColor( unpack(COL_DIGIT) )
srf_tabpwr:SetFont( ftitle1 )

tx, ty = srf_tabpwr:GetPosition()
tw, th = srf_tabpwr:GetSize()
srf_ttpmu = psrf:SubSurface(tx + tw + 10, 0, ftitle1:StringWidth("88.8°C"), ftitle1:GetHeight() )
srf_ttpmu:SetColor( unpack(COL_DIGIT) )
srf_ttpmu:SetFont( ftitle1 )

srf_tpwrgfx =  psrf:SubSurface( 
	xcursor, goffy-2, 
	ftitle1:StringWidth("Tablette :") + ftitle1:StringWidth("88.88 W") + ftitle1:StringWidth("88.8°C") + 10,
	bar_ups.y + bar_ups.h - goffy + 2
);
srf_tpwrgfx:SetColor( unpack(COL_RED) )



psrf:SetColor( unpack(COL_BORDER) )
goffy = bar_ups.y + bar_ups.h + 4
psrf:DrawLine(VBAR1, goffy, psrf:GetWidth(), goffy )

-- Collection for graphics
dt_pwr = SelCollection.create( srf_tpwrgfx:GetWidth()/5 )
dt_conso = SelCollection.create( srf_consogfx:GetWidth() )
dt_prod = SelCollection.create( srf_prodgfx:GetWidth() )

-- update functions
function updateInternet()
	local intDn = tonumber( SelShared.get('Freebox/DownloadATM') )
	local intUp = tonumber( SelShared.get('Freebox/UploadATM') )
	if intDn and intUp then
		UpdDataRight( srf_Internet, intDn .. ' Kb / ' .. intUp ..' Kb' )
	end
end

function updatedWAN()
	local intDn = tonumber( SelShared.get('Freebox/DownloadATM') )
	local wanDn = tonumber( SelShared.get('Freebox/DownloadWAN') )
	if intDn then
		local pw = bar_Idn.w * wanDn * 8 / intDn
		psrf:SetColor( unpack( COL_WHITE ) )
		psrf:FillRectangle( bar_Idn.x, bar_Idn.y, pw, bar_Idn.h )
		psrf:SetColor( unpack( COL_BLACK ) )
		psrf:FillRectangle( bar_Idn.x+pw, bar_Idn.y, bar_Idn.w-pw, bar_Idn.h )
	end
end

function updateuWAN()
	local intUp = tonumber( SelShared.get('Freebox/UploadATM') )
	local wanUp = tonumber( SelShared.get('Freebox/UploadWAN') )
	if intUp then
		local pw = bar_Iup.w * wanUp * 8 / intUp
		psrf:SetColor( unpack( COL_WHITE ) )
		psrf:FillRectangle( bar_Iup.x, bar_Iup.y, pw, bar_Iup.h )
		psrf:SetColor( unpack( COL_BLACK ) )
		psrf:FillRectangle( bar_Iup.x+pw, bar_Iup.y, bar_Iup.w-pw, bar_Iup.h )
	end
end

function updateUPSLd()
	local maxp = tonumber( SelShared.get('onduleur/ups.realpower.nominal') )
	if maxp then -- maximum power not known yet
		UpdDataRight( srf_consoUPS, string.format('%3.1f', SelShared.get('onduleur/ups.load')*maxp/100) .. ' W')
	else
		UpdDataRight( srf_consoUPS, SelShared.get('onduleur/ups.load') .. ' %')
	end
	local pw = bar_ups.w * SelShared.get('onduleur/ups.load') / 100
	psrf:SetColor( unpack( COL_WHITE ) )
	psrf:FillRectangle( bar_ups.x, bar_ups.y, pw, bar_ups.h )
	psrf:SetColor( unpack( COL_BLACK ) )
	psrf:FillRectangle( bar_ups.x+pw, bar_ups.y, bar_ups.w-pw, bar_ups.h )
end

function updateVlt()
	UpdDataRight( srf_tension, SelShared.get('onduleur/input.voltage') .. ' V')
end

function updateConso()
	local cols = {
		[500] = COL_DIGIT,
		[1500] = COL_ORANGE,
		[4500] = COL_RED
	}
	local v = SelShared.get('TeleInfo/Consommation/values/PAPP')
	srf_consommation:SetColor( findgradiancolor(v, cols ) )
	UpdDataRight( srf_consommation, v .. ' VA')

	dt_conso:Push(v)
	local min,max = dt_conso:MinMax()
	UpdDataRight( srf_maxconso, max )
	updgfx( srf_consogfx, dt_conso, 0 )
end

function updateProduction()
	local v = SelShared.get('TeleInfo/Production/values/PAPP')
	UpdDataRight( srf_production, v .. ' VA')

	dt_prod:Push(v)
	local min,max = dt_prod:MinMax()
	UpdDataRight( srf_maxprod, max )
	updgfx( srf_prodgfx, dt_prod, 0 )
end

-- local subscription
local ltopics = {
	{ topic = "Freebox/DownloadWAN", trigger=updatedWAN, trigger_once=true },
	{ topic = "Freebox/UploadWAN", trigger=updateuWAN, trigger_once=true },
	{ topic = "Freebox/DownloadATM" },
	{ topic = "Freebox/UploadATM", trigger=updateInternet, trigger_once=true },
	{ topic = "onduleur/ups.realpower.nominal" },
	{ topic = "onduleur/ups.load", trigger=updateUPSLd, trigger_once=true },
	{ topic = "onduleur/input.voltage", trigger=updateVlt, trigger_once=true },
	{ topic = "TeleInfo/Consommation/values/PAPP", trigger=updateConso, trigger_once=true },
	{ topic = "TeleInfo/Production/values/PAPP", trigger=updateProduction, trigger_once=true }
}

TableMerge( Topics, ltopics)


