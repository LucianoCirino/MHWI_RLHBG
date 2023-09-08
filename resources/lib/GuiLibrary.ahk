WM_CTLCOLOREDIT    := 0x0133
WM_CTLCOLORLISTBOX := 0x0134
WM_CTLCOLORSTATIC  := 0x0138

OnMessage(WM_CTLCOLOREDIT, "Control_Colors")
OnMessage(WM_CTLCOLORSTATIC, "Control_Colors")
OnMessage(WM_CTLCOLORLISTBOX, "Control_Colors")

Control_Colors(wParam, lParam, Msg, Hwnd) {
   Static Controls := {}
   If (lParam = "Set") {
      If !(CtlHwnd := wParam + 0)
         GuiControlGet, CtlHwnd, Hwnd, %wParam%
      If !(CtlHwnd + 0)
         Return False
      Controls[CtlHwnd, "CBG"] := Msg + 0
      Controls[CtlHwnd, "CTX"] := Hwnd + 0
      Return True
   }
   ; Critical
   If (Msg = 0x0133 Or Msg = 0x0134 Or Msg = 0x0138) {
      If Controls.HasKey(lParam) {
         If (Controls[lParam].CTX >= 0)
            DllCall("Gdi32.dll\SetTextColor", "Ptr", wParam, "UInt", Controls[lParam].CTX)
         DllCall("Gdi32.dll\SetBkColor", "Ptr", wParam, "UInt", Controls[lParam].CBG)
         Return DllCall("Gdi32.dll\CreateSolidBrush", "UInt", Controls[lParam].CBG)
      }
   }
}

ConvertColor(BGRValue){
	BlueByte := ( BGRValue & 0xFF0000 ) >> 16
	GreenByte := BGRValue & 0x00FF00
	RedByte := ( BGRValue & 0x0000FF ) << 16
	return RedByte | GreenByte | BlueByte
}

/*
Note:

To set colors for controls you have to call Control_Colors() with 4 parameters:
HWND of the control or name of the associated variable. The name has to be has to be enclosed with double-quotes. The control is expected to belong to the current default GUI.
The string "Set".
The background color as BGR hex value: 0xBBGGRR.
The text color as BGR hex value: 0xBBGGRR. If you pass an empty string (i.e. "") the control's default color will be used.
To start the coloring you have to use OnMessage(ColorMessage, "Control_Colors") for one or more of the following mesages:
WM_CTLCOLOREDIT    := 0x0133  for writabel Edit controls, and ComboBox edit fields.
WM_CTLCOLORLISTBOX := 0x0134  for ComboBoxes, DropDownLists, and ListBoxes.
WM_CTLCOLORSTATIC  := 0x0138  for Text controls, read-only Edit controls, and the background of Checkboxes and Radios.
*/

/*;Example:
#NoEnv
SetBatchLines, -1
WM_CTLCOLOREDIT    := 0x0133
WM_CTLCOLORLISTBOX := 0x0134
WM_CTLCOLORSTATIC  := 0x0138

OnMessage(WM_CTLCOLOREDIT, "Control_Colors")
OnMessage(WM_CTLCOLORSTATIC, "Control_Colors")
OnMessage(WM_CTLCOLORLISTBOX, "Control_Colors")

 ;Example:
Gui 1: Default
Gui 1: Color, 000000
Gui 1: Add, Text,cWhite y100 w530 Center, Example1
Gui 1: Add, Edit, x0 y180 w530 h20 vMyControl1 hwndEB1 ReadOnly Center, This area should be gray.
Control_Colors("MyControl1", "Set", "0xd8d8d8", "0x000000")
Gui 1: Show, y200 w530 h200, Example1
ControlFocus, Static1, Example1
Gui, +LastFound
Return

GuiClose:
Gui 1: Destroy

Gui 2: Default
Gui 2: Color, 000000
Gui 2: Add, Text,cWhite y100 w530 Center, Example2
Gui 2: Add, Edit, x0 y180 w530 h20 vMyControl2 hwndEB2 ReadOnly Center, This area should be gray.
Control_Colors("MyControl2", "Set", "0xd8d8d8", "0x000000")
Gui 2: Show, y500 w530 h200, Example2
ControlFocus, Static1, Example2
Return

2GuiClose:
ExitApp
*/


; ===========================================================================================================================

SetFocusedBkColor(W, L := "", M := "", H := "") {
   Static Controls := {}
   If (M && H) { ; system call: W = HDC, L = HWND
      If Controls.HasKey(L) {
         If (L = DllCall("GetFocus", "UPtr")) {
            Controls[L, "Invalidated"] := False
            DllCall("SetBkColor", "Ptr", W, "UInt", Controls[L, "Color"])
            Return Controls[L, "Brush"]
         }
         Else If !Controls[L, "Invalidated"] {
            Controls[L, "Invalidated"] := True
            DllCall("InvalidateRect", "Ptr", L, "Ptr", 0, "UInt", 1)
         }
      }
   }
   Else { ; setup call: W = HWND, L = color
      If DllCall("IsWindow", "Ptr", W) {
         If Controls.HasKey(W) {
            DllCall("DeleteObject", "Ptr", Controls[W, "Brush"])
            Controls.Delete(W)
         }
         If (L <> "") && ((EditColor := SwapRB(L)) <> "") {
            Controls[W, "Color"] := EditColor
            Controls[W, "Brush"] := DllCall("CreateSolidBrush", "UInt", EditColor, "Uptr")
            Controls[W, "Invalidated"] := True
         }
         DllCall("RedrawWindow", "Ptr", W, "Ptr", 0, "Ptr", 0, "UInt", 0x0405, "UInt")
      }
   }
}

SwapRB(Color) { ; converts RGB to BGR and vice versa
   Return ((Color & 0xFF0000) >> 16) | (Color & 0x00FF00) | ((Color & 0x0000FF) << 16)
}
/*;Example:

#NoEnv
BackColor := 0xFFFF00
EditControls := {}
Gui Add, Edit, x183 y57 w205 h51 hwndHED, Edit 1
SetFocusedBkColor(HED, BackColor)
Gui Add, edit, x184 y128 w205 h51 hwndHED, Edit 2
SetFocusedBkColor(HED, BackColor)
Gui Add, Edit, x185 y199 w205 h51 hwndHED, Edit 3
SetFocusedBkColor(HED, BackColor)
OnMessage(0x0133, "SetFocusedBkColor") ; WM_CTLCOLOREDIT
Gui Show, w547 h338, Window
Return
GuiClose:
ExitApp
*/
; ===========================================================================================================================
/*
WM_COMMAND := 0x0111
;OnMessage(WM_COMMAND, "On_EN_SETFOCUS") ;Call this to hide the text cursor for ALL Edit boxes

On_EN_SETFOCUS(wParam, lParam) {
   Static EM_SETSEL   := 0x00B1
   Static EN_SETFOCUS := 0x0100
   Critical
   If ((wParam >> 16) = EN_SETFOCUS) {
      DllCall("User32.dll\HideCaret", "Ptr", lParam)
      PostMessage, %EM_SETSEL%, -1, 0, , ahk_id %lParam%
   }
}
*/
/* ;Another way to hide caret (text cursor):
Gui, Add, Edit, HwndEditHwnd
DllCall( "HideCaret" , "Ptr" , EditHwnd )
DllCall( "ShowCaret" , "Ptr" , EditHwnd )
;*For later use
*/

; =======================[ComboBox Exact String Match]=========================
;Function to select correct position of an item in a combobox list given a string.
;Function written by "Just Me", https://www.autohotkey.com/board/topic/16556-choose-string-exact-match/
ControlChooseStrExact(hCtrl, String) { ; not case-sensitive
   ; Returns the number of the entry, if found; otherwise zero
   ; LB_FINDSTRINGEXACT := 0x01A2, CB_FINDSTRINGEXACT := 0x0158
   Static Msg := {ListBox: 0x01A2, ComboBox: 0x0158, ComboBoxEx: 0x0158}
   WinGetClass, Class, ahk_id %hCtrl%
   If !Msg.HasKey(Class)
      Return 0
   SendMessage, % Msg[Class], -1, &String, , ahk_id %hCtrl%
   If (R := ErrorLevel + 1) > 0
      Control, Choose, %R%, , ahk_id %hCtrl%
   Return R
}