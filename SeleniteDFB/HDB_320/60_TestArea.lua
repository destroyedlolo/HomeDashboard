-- Scratch pad to test some function

local function f()
	self = SubSurface( psrf, 
		LeftBar.get():GetWidth(),0,
		psrf:GetWidth() - LeftBar.get():GetWidth(), psrf:GetHeight()
	)
	local sw, sh = self.get():GetSize()
	local srf = self.get()

	text = TextArea( srf, 30,30, sw-60, sh-60, fdigit, COL_BLACK, { bgcolor=COL_LIGHTGREY } )
text.DrawString("Truc ")
text.DrawString("Much")
text.CR()
text.DrawString("Machin")

text.setColor( COL_ORANGE )
for i=1,5
do
	text.DrawString("Bla ")
end

for i=1,6
do
	text.CR()
	text.DrawString("gna gna ".. i)
end

	self.refresh()

	return self
end

TestArea = f()

