/* This script will store your ammo list in an array in order to optimally be able to navigate it.
   This script will save its settings (and takes commands) from "ammo_settings.ini" in the data directory. 
   The stored ammo list array will be saved in a file named "ammo_list.ini" in data directory. -Script Written by TSC
*/
#SingleInstance Force
;Give each instance of AutoHotkey.exe its own button: by Lexicos 
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, Applications\AutoHotkey.exe, IsHostApp
#NoTrayIcon
;;=============================[Default Settings/Controls]==============================
global cPulse:= 0		;[0: Standby, 1:GotoType(), 2:AmmoSync() , 3:Cycle()] Command Pulse
;global GotoType := -1 		;Ammo type to go to
global keyAmmoUp := "z"      	;Key binding to scroll UP on ammo wheel
global keyAmmoDown := "x"      	;Key binding to scroll DOWN on ammo wheel
global keyAmmoSync := "F6"	;Key bind to call the AmmoSync function
global keyGotoType := "Joy11"	;Key bind to call the GotoType function

global a_list := "resources\data\ammo_list.ini"
;;======================================================================== 

global ammoN := 1		;The total number of Ammo Types in array
global AmmoArray := {}		;AmmoArray{} = { {type: x1}, {type: x2}, etc...}

;;==============================[Load Libraries]===============================
SetTitleMatchMode 2  ; Avoids the need to specify the full path of files.
#Include resources/lib/Initialization.ahk
#Include resources/lib/MemoryLibrary.ahk
#Include resources/lib/Functions.ahk

;;=============================[Load Settings]=================================
/* How to externally write to AmmoCrafter_Settings.ini:
   a_settings := resources\data\a_settings
   Iniwrite, [int], %a_settings%, GotoType: , _
   Iniwrite, [0:Standby ,1:GotoType() ,2:AmmoSync() ,3:Cycle()], %a_settings%, cPulse: , _
   Iniwrite, [key] , %a_settings%, keyAmmoUp: , _
   Iniwrite, [key] , %a_settings%, keyAmmoDown: , _
*/
LoadSettings()
LoadSettings(){
   ;Make default settings file with values if file dne
   ifnotexist,%a_settings%
   {
      Iniwrite, %cPulse%, %a_settings%, cPulse: , _
      Iniwrite, %GotoType%, %a_settings%, GotoType: , _
      Iniwrite, %keyAmmoUp% , %a_settings%, keyAmmoUp: , _
      Iniwrite, %keyAmmoDown% , %a_settings%, keyAmmoDown: , _
   }

   ;if ammo_list exists, create AmmoArray from stored ammo_list.ini
      ifexist,%a_list%
   {
      n:=0
      IniRead, aType, %a_list%, %n%, _
      While (aType<>"ERROR"){
         AmmoArray[n]:=aType
         n:=n+1
         IniRead, aType, %a_list%, %n%, _
      }
      ammoN:=n
   }
}
;;==================================[Main Loop]=================================
Main:

   ;Wait until MHW Window is open
   While (!CheckWindow()){
      PreciseSleep(34)
   }

   IniRead, cPulse, %a_settings%, cPulse: , _
   IniRead, Type, %a_settings%, GotoType: , _
   IniRead, keyAmmoUp , %a_settings%, keyAmmoUp: , _
   IniRead, keyAmmoDown , %a_settings%, keyAmmoDown: , _

   if (cPulse=1){
      aType := Type
      GotoType(aType)
      IniRead, cPulse, %a_settings%, cPulse: , _
      IniRead, Type, %a_settings%, GotoType: , _
      if (((cPulse=1) & (Type=aType)) or (cPulse=3))
         PulseReset()
   }
   if(cPulse=2){
      AmmoSync()
      IniRead, cPulse, %a_settings%, cPulse: , _
      if (cPulse=2)
         PulseReset()
   }
   if(cPulse=3){
      Cycle("Up")
      IniRead, cPulse, %a_settings%, cPulse: , _
      if (cPulse=3)
         PulseReset()
   }

Goto Main

;;==================================[Functions]=================================
AmmoSync(){
   AmmoArray := {}
   ammoN := 1	
   AmmoArray[0] := GetAmmoType()

   FileDelete, %a_list%

   ;Wait until MHW Window is open
   While (!CheckWindow()){
      PreciseSleep(34)
   }

   StoredType := AmmoArray[0]
   iniwrite, %StoredType%, %a_list%, 0, _

   ;Begin opening the ammo menu(84ms/5f delay if menu not open, assume not open)
   GotType := AmmoArray[0] 
   Send {%keyAmmoDown% down}
   PreciseSleep(17)
   Send {%keyAmmoDown% up}
   PreciseSleep(17)

   CurrentTime := A_TickCount
   ;Wait until ammo changes to scroll again
   While (GotType=GetAmmoType()){
      ElapsedTime := A_TickCount - CurrentTime
      if (ElapsedTime>50) ;Takes ~0ms from CurrentTime
         return
   }

   ;Scroll through ammos until you loop
   while (AmmoArray[0]<>GetAmmoType()){

      ;Store in array only during a detected ammo type change
      AmmoArray[ammoN] := GetAmmoType()
      StoredType := AmmoArray[ammoN]
      iniwrite, %StoredType%, %a_list%, %ammoN%, _
      ammoN:=ammoN+1

      GotType := GetAmmoType()
      Send {%keyAmmoDown% down}
      PreciseSleep(17)
      Send {%keyAmmoDown% up}
      PreciseSleep(17)

      CurrentTime := A_TickCount
      ;Wait until ammo changes to scroll again
      While (GotType=GetAmmoType()){
         ElapsedTime := A_TickCount - CurrentTime
         if (ElapsedTime>300) ;Takes ~250ms from CurrentTime
            return
      }
   }
   Send {%keyAmmoDown% up}
}

GotoType(Type){

   N := 0
   ;Make sure ammo exists in pouch before looking for it (Check1)
   if (GetAmmoCount2(Type)>0){
      
      CurrentType := GetAmmoType()
        
      ;Find quickest way to get to ammo->
      ;Step1: scroll through array and find position of CurrentType(n1) and Type(n2)    
      Loop
      {
      if (AmmoArray[N]=CurrentType)
         n1 := N
      if (AmmoArray[N]=Type)
         n2 := N
      if (N=ammoN)
         break
      else
         N := N + 1
      }
      
      ;if Type not in pouch, exit (Check2)
      if (n2="")
         return
 
      ;Step2: Decide based on positions n1,n2 and the array length "ammoN" wether to scroll up or down
      if (n1>n2){
         if ((ammoN + n2 - n1 + 1) > (n1 - n2))
            Scroll := keyAmmoUp
         else
            Scroll := keyAmmoDown
       }
       else if(n2>n1){
          if ((ammoN + n1 - n2 + 1) > (n2 - n1))
            Scroll := keyAmmoDown
         else
            Scroll := keyAmmoUp
        }
       else 
          Return      

      ;Make Sure MHW Window is open
      While (!CheckWindow()){
         PreciseSleep(34)
      }

      while (GetAmmoType()<>Type){

         ;Exit if MHW window not open
         if (!CheckWindow()){
            Return
         }
         GotType := GetAmmoType()
         Send {%Scroll% down}
         PreciseSleep(17)
         Send {%Scroll% up}
         PreciseSleep(17)

         CurrentTime := A_TickCount
         ;Wait until ammo changes to scroll again
         While (GotType=GetAmmoType()){
            ElapsedTime := A_TickCount - CurrentTime
            if (ElapsedTime>367)
               return
         }

      }
   }
}

;Ammo Cycle is used to force open ammo menu
Cycle(mode:="Down"){
   CycleTime:= A_TickCount

   CurrentType := GetAmmoType()

   Switch mode{
      case "Up":
         key1stDirection := keyAmmoUp
         key2ndDirection := keyAmmoDown
      default:
         key1stDirection := keyAmmoDown
         key2ndDirection := keyAmmoUp
   }

   Send {%key1stDirection% down}
   Send {%key2ndDirection% down}
   PreciseSleep(17)
   Send {%key1stDirection% up}
   Send {%key2ndDirection% up}
   PreciseSleep(17)

   CurrentTime := A_TickCount
   ;Wait until ammo changes back
   While (CurrentType<>GetAmmoType()){
      ElapsedTime := A_TickCount - CurrentTime
      if (ElapsedTime>400) ;Without menu open it takes ~300-334ms from CurrentTime
         return
    }
}

PulseReset(){
   Iniwrite, 0, %a_settings%, cPulse: , _
   cPulse:=0
}

;F7::Cycle()