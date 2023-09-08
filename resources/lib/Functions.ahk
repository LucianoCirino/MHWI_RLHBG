;;===============================[Precise Sleep]===============================
;;Precision Sleep using DllCall
PreciseSleep(duration) {
   DllCall("Sleep","UInt",duration)
}

;;===============================[Kill All AHK]================================
AHKPanic(Kill=0, Pause=0, Suspend=0, SelfToo=0) {
DetectHiddenWindows, On
WinGet, IDList ,List, ahk_class AutoHotkey
Loop %IDList%
  {
  ID:=IDList%A_Index%
  WinGetTitle, ATitle, ahk_id %ID%
  IfNotInString, ATitle, %A_ScriptFullPath%
    {
    If Suspend
      PostMessage, 0x111, 65305,,, ahk_id %ID%  ; Suspend. 
    If Pause
      PostMessage, 0x111, 65306,,, ahk_id %ID%  ; Pause.
    If Kill
      WinClose, ahk_id %ID% ;kill
    }
  }
If SelfToo
  {
  If Suspend
    Suspend, Toggle  ; Suspend. 
  If Pause
    Pause, Toggle, 1  ; Pause.
  If Kill
    ExitApp
  }
}


;;==============================[AHK Files PIDs]===============================
GetScriptPID(ScriptName) {
   DHW := A_DetectHiddenWindows
   TMM := A_TitleMatchMode
   DetectHiddenWindows, On
   SetTitleMatchMode, 2
   WinGet, PID, PID, \%ScriptName% - ahk_class AutoHotkey
   DetectHiddenWindows, %DHW%
   SetTitleMatchMode, %TMM%
   Return PID
}

;;=========================[Pause & Resume AHK Files]==========================
;Function to find the State of other ahk scripts (paused/unpaused)
Is_Paused( PID ) {
    dhw := A_DetectHiddenWindows
    DetectHiddenWindows, On  ; This line can be important!
    hWnd := WinExist("ahk_class AutoHotkey ahk_pid " PID)
    SendMessage, 0x211 ; WM_ENTERMENULOOP
    SendMessage, 0x212 ; WM_EXITMENULOOP
    DetectHiddenWindows, %dhw%
    hMenu := DllCall("GetMenu", "uint", hWnd)
    hMenu := DllCall("GetSubMenu", "uint", hMenu, "int", 0)
    Return (DllCall("GetMenuState", "uint", hMenu, "uint", 4, "uint", 0x400) & 0x8)!= 0
}

;Pause/Resume an AHK script
PauseResumeAHK(ahk=""){
   PostMessage, 0x0111, 65306,,, % ahk - AutoHotkey  ; Pause/Resume
}

/* How to use:
   
   1) Get Script ID
   PID := GetScriptPID("AhkScripName.ahk")

   2) Check if Script ID is paused
   ScriptPaused := Is_Paused(PID)
   ; 1 means is paused
   ; 0 means is not paused

   3) Pause/Resume the script using PauseToggleAHK("AhkScripName.ahk")
*/

;;===============================[Ammo IDs]====================================
;Function will return the name of ammo based on the fed ID.
AmmoName(ID){
/*
  Ammo IDs
  Type -1 = disabled / don't use 
  Type 0/1/2 = Normal 1/2/3    | Type 3/4/5 = Pierce 1/2/3    | Type 6/7/8 = Spread 1/2/3
  Type 9/10/11 = Cluster 1/2/3 | Type 13/14/15 = Sticky 1/2/3 | Type 21 = Dragon Ammo
  Type 24/25 = Para 1/2        | Type 26/27 = Sleep 1/2
  Type 28/29 = Exhaust 1/2     | Type 36 = Tranq
*/

   switch ID{
      case 0:return "Normal 1"
      case 1:return "Normal 2"
      case 2:return "Normal 3"
      case 3:return "Pierce 1"
      case 4:return "Pierce 2"
      case 5:return "Pierce 3"
      case 6:return "Spread 1"
      case 7:return "Spread 2"
      case 8:return "Spread 3"
      case 9:return "Cluster 1"
      case 10:return "Cluster 2"
      case 11:return "Cluster 3"
      case 12:return "Wyvern"
      case 13:return "Sticky 1"
      case 14:return "Sticky 2"
      case 15:return "Sticky 3"
      case 16:return "Slicing"
      case 17:return "Flaming"
      case 21:return "Dragon"
      case 22:return "Poison 1"
      case 23:return "Poison 2"
      case 24:return "Para 1"
      case 25:return "Para 2"
      case 26:return "Sleep 1"
      case 27:return "Sleep 2"
      case 28:return "Exhaust 1"
      case 29:return "Exhaust 2"
      case 30:return "Recovery 1"
      case 33:return "Armor"
      case 36:return "Tranq"
      default: return "???"
   }
}

;Function will return the ID of an ammo type based on the fed Name.
AmmoID(AmmoName:=""){
/*
  Ammo IDs
  Type -1 = disabled / don't use 
  Type 0/1/2 = Normal 1/2/3    | Type 3/4/5 = Pierce 1/2/3    | Type 6/7/8 = Spread 1/2/3
  Type 9/10/11 = Cluster 1/2/3 | Type 13/14/15 = Sticky 1/2/3 | Type 21 = Dragon Ammo
  Type 24/25 = Para 1/2        | Type 26/27 = Sleep 1/2
  Type 28/29 = Exhaust 1/2     | Type 36 = Tranq
*/
   switch AmmoName{
      case "Normal 1":return 0
      case "Normal 2":return 1
      case "Normal 3":return 2
      case "Pierce 1":return 3
      case "Pierce 2":return 4
      case "Pierce 3":return 5
      case "Spread 1":return 6
      case "Spread 2":return 7
      case "Spread 3":return 8
      case "Cluster 1":return 9
      case "Cluster 2":return 10
      case "Cluster 3":return 11
      case "Wyvern":return 12
      case "Sticky 1":return 13
      case "Sticky 2":return 14
      case "Sticky 3":return 15
      case "Slicing":return 16
      case "Flaming":return 17
      case "Dragon":return 21
      case "Poison 1":return 22
      case "Poison 2":return 23
      case "Para 1":return 24
      case "Para 2":return 25
      case "Sleep 1":return 26
      case "Sleep 2":return 27
      case "Exhaust 1":return 28
      case "Exhaust 2":return 29
      case "Recovery 1":return 30
      case "Armor":return 33
      case "Tranq":return 36
      default: return "???"
   }

}