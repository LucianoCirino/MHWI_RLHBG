/* This script was designed to craft Hotbar menu items. This script will save its settings (and takes commands) from "craft_settings.ini" in the data directory. 
-Script Written by TSC
*/
#SingleInstance Force
;Give each instance of AutoHotkey.exe its own button: by Lexicos 
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, Applications\AutoHotkey.exe, IsHostApp
#NoTrayIcon
;;=============================[Default Settings]==============================
global cPulse:= 0		;[0: Standby, 1:Craft()] Command Pulse
global Menu := 0 		;Menu where craft items are located. [1:"F1",2:"F2",3:"F3",4:"F4"]
global Slot1 := 0      		;Slot of craft item in Menu above. [1,2,3,4,5,6,7,8] (Any other value will disable)
global Slot2 := 0      		;Slot of craft item in Menu above. [1,2,3,4,5,6,7,8] (Any other value will disable)
global Slot3 := 0      		;Slot of craft item in Menu above. [1,2,3,4,5,6,7,8] (Any other value will disable)

global c_settings := "resources\data\craft_settings.ini"
;;==============================[Load Libraries]===============================
SetTitleMatchMode 2  ; Avoids the need to specify the full path of files.
#Include resources/lib/Initialization.ahk
#Include resources/lib/MemoryLibrary.ahk
#Include resources/lib/Functions.ahk

;;=============================[Load Settings]=================================
/* How to externally write to AmmoCrafter_Settings.ini:
   c_settings := "resources\data\craft_settings.ini"
   Iniwrite, [1,2,3,4], %c_settings%, Menu: , _
   Iniwrite, [1,2,3,4,5,6,7,8] , %c_settings%, Slot1: , _
   Iniwrite, [1,2,3,4,5,6,7,8] , %c_settings%, Slot2: , _
   Iniwrite, [1,2,3,4,5,6,7,8] , %c_settings%, Slot3: , _
   Iniwrite, [0: Standby, 1:Craft()], %c_settings%, cPulse: , _
*/

LoadSettings(){
   ;Make default settings file with values if file dne
   ifnotexist,%c_settings%
   {
   Iniwrite, %Menu%, %c_settings%, Menu: , _
   Iniwrite, %Slot1% , %c_settings%, Slot1: , _
   Iniwrite, %Slot2% , %c_settings%, Slot2: , _
   Iniwrite, %Slot3% , %c_settings%, Slot3: , _
   Iniwrite, %cPulse% , %c_settings%, cPulse: , _
   }

   IniRead, Menu, %c_settings%, Menu: , _
   if ((Menu=1) or (Menu=2) or (Menu=3) or (Menu=4))
      Menu := "F" . Menu
   else
      Menu := ""
   IniRead, Slot1, %c_settings%, Slot1: , _
   IniRead, Slot2, %c_settings%, Slot2: , _
   IniRead, Slot3, %c_settings%, Slot3: , _
   IniRead, cPulse, %c_settings%, cPulse: , _

}

;;==================================[Main Loop]================================
Main:

   ;Wait until MHW is main window
   While (!CheckWindow()){
      PreciseSleep(34)
   }

   LoadSettings()

   if (cPulse=1){
      CraftItems()
      CraftItems()
      CraftItems()
         Iniwrite, 0 , %c_settings%, cPulse: , _
   }

Goto Main	;Loop 

;;==================================[Functions]================================

CraftItems(){

   Send {%Menu% down}

   if ((Slot1>=1) & (Slot1<=8)){
      Send {%Slot1% down}
      PreciseSleep(17)
      Send {%Slot1% up}
   }
   if ((Slot2>=1) & (Slot2<=8) & (Slot2<>Slot1)){
      Send {%Slot2% down}
      PreciseSleep(17)
      Send {%Slot2% up}
   }
   if ((Slot3>=1) & (Slot3<=8) & ((Slot3<>Slot1) or (Slot3<>Slot2))){
      Send {%Slot3% down}
      PreciseSleep(17)
      Send {%Slot3% up}
   }

   Send {%Menu% up}

   PreciseSleep(17)
}


