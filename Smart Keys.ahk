#NoEnv
#Persistent
#SingleInstance force
Suspend, Toggle

Gui,01:+AlwaysOnTop +Resize -MaximizeBox -MinimizeBox +LastFound +ToolWindow
Gui,01:Add,DropDownList,AltSubmit x10 y10 w100 vPTool gset,None||Brush|Eraser|Smudge|Burn/Dodge|Stamp|Select|Lasso|Wand|Pen|PathSelect|Shape|Move|Fill/Gradient|Hand|Heal
Gui,01:Add,DropDownList,AltSubmit x10 y40 w100 vSTool gset,None||Brush|Eraser|Smudge|Burn/Dodge|Stamp|Select|Lasso|Wand|Pen|PathSelect|Shape|Move|Fill/Gradient|Hand|Heal
Gui,01:Add,Groupbox,x10 y70 w100 h70,Hold Modifier
Gui,01:Add,Checkbox,x20 y120 w30 h13 vCheckAlt gCheckKey,Alt
Gui,01:Add,Checkbox,x60 y90 w49 h13 vCheckShift gCheckKey,Shift
Gui,01:Add,Checkbox,x20 y90 w33 h13 vCheckCtrl gCheckKey,Ctrl
Gui,01:Add,Checkbox,x60 y120 w49 h13 vCheckSpace gCheckKey,Space
Gui,01:Show,x552 y638 w121 h145 ,Smart Keys
Gui, Show
return

;-----------Checkboxes-----------//every time one of the checkboxes is checked or unchecked this part of the script sets the corresponding keystates to down or up
CheckKey:
Gui,01: Submit, NoHide
if (CheckCtrl="1")
{
    send {ctrl down}
}
else
{
    send {ctrl up}
}
if (CheckAlt="1")
{
    send {alt down}
}
else
{
    send {alt up}
}
if (CheckShift="1")
{
    send {shift down}
}
else
{
    send {shift up}
}
if (CheckSpace="1")
{
    send {space down}
}
else
{
    send {space up}
}
return

set:
;---//this part runs when the Button Set is pressed; if no photoshop window is detected it it exits the script, if a photoshop window is detected it activates it and continues with subroutine Suspend
ifWinExist, ahk_class Photoshop
{
    WinActivate, ahk_class Photoshop
	gosub, Suspend
}
else
{
	Gui Destroy
	MsgBox, Photoshop is not open! Closing Script...
    ExitApp	
    return
}

;---//this part checks the selection, if none is in one of the drop downs selected or if the same tools are selected it suspends the hotkeys; if not it continues with subroutine Selection
Suspend:
Gui,01: Submit, NoHide
if (PTool=1)
{
    suspend, on
}
if (STool=1)
{
    suspend, on
}
if (PTool-STool="0")
    suspend, on
else
{
    gosub, Selection
}
return


;-------------Primary Tools---------------//this part defines the keypress after the hotkey (secondary tool) is released
Selection:
if (PTool="2") ;Brush
{
    vX = b
}
if (PTool="3") ;Eraser
{
	vX = e
}
if (PTool="4") ;Smudge
{
    vX = r
}
if (PTool="5") ;Burn/Dodge
{
    vX = o
}
if (PTool="6") ;Stamp
{
    vX = s
}
if (PTool="7") ;Select
{
    vX = m
}
if (PTool="8") ;Lasso
{
    vX = l
}
if (PTool="9") ;Wand
{
    vX = w
}
if (PTool="10") ;Pen
{
    vX = p
}
if (PTool="11") ;PathSelect
{
    vX = a
}
if (PTool="12") ;Shape
{
    vX = u
}
if (PTool="13") ;Move
{
    vX = v
}
if (PTool="14") ;Fill/Grad
{
    vX = g
}
if (PTool="15") ;Hand
{
    vX = h
}
if (PTool="16") ;Heal
{
    vX = j
}
;-----------------Secondary Tools------------------//this part defines the key that is remapped to the hotkey and
if (STool="2") ;Brush
{
    suspend, off
    vY = b
}
if (STool="3") ;Eraser
{
    suspend, off
    vY = e
}
if (STool="4") ;Smudge
{
    suspend, off
	vY = r
}
if (STool="5") ;Burn/Dodge
{
    suspend, off
    vY = o
}
if (STool="6") ;Stamp
{
    suspend, off
    vY = s
}
if (STool="7") ;Select
{
    suspend, off
    vY = m
}
if (STool="8") ;Lasso
{
    suspend, off
    vY = l
}
if (STool="9") ;Wand
{
    suspend, off
    vY = w
}
if (STool="10") ;Pen
{
    suspend, off
    vY = p
}
if (STool="11") ;PathSelect
{
    suspend, off
    vY = a
}
if (STool="12") ;Shape
{
    suspend, off
    vY = u
}
if (STool="13") ;Move
{
    suspend, off
    vY = v
}
if (STool="14") ;Fill/Gradient
{
    suspend, off
    vY = g
}
if (STool="15") ;Hand
{
    suspend, off
    vY = h
}
if (STool="16") ;Heal
{
    suspend, off
    vY = j
}
send %vX%
return
   
*F2::
send {%vY% down}
KeyWait, F2
send %vX%
return

Guiclose:
Gui Destroy
ExitApp 
return
