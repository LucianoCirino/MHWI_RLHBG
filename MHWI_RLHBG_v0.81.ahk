/*Reverse Ledge Heavy Bow Gun (RLHBG) AHK Script
   
The Original foundation for this script was written by MoonBunnie (2019). 
Script has since then been extensively altered/modified by TSC (2021).
 
Please label your speedruns using this script as TAS, 
and give back some credit if used :)

Important Script Notes:
1. This script is designed to work with "Monster Hunter World:Iceborne" 
(Also works in ICE).
2. Use script with "BetterInputs.dll" plugin.
3. Script currently only works with game locked at 60fps
4. Reload the script when switching between different HBGs.
(Noticed it caused issues when not reloaded)
5. Script commands are designed to work with a PS4/PS5 Controller.

For more help/info, you can contact us at:
ICE Community Edition Discord: https://discord.gg/xPDVbhZgFJ
*/

#SingleInstance Force
;Give each instance of AutoHotkey.exe its own button: by Lexicos 
RegWrite, REG_SZ, HKEY_CLASSES_ROOT, Applications\AutoHotkey.exe, IsHostApp
Menu, Tray, Icon, resources/pics/AmmoWhite.ico,, 1
;;=================================[Default Settings]===========================
global ADSmode := 2		;[1:None , 2:Standard , 3:Mixed, 4:Full] See below for more info
global SMG := 0			;[0:False , 1:True] Define wether to attempt to SMG all ADS shots. Only works on some ledges. 
global MixedADS := 3 		;Defines the ADS shot cycle in "Mixed" ADSmode (example: MixedADS=3 will make script ADS every 3rd shot)
global StartMixedInADS := 0	;[0:False , 1:True] Define in which ADS mode to start MixedADS                                                  
global Rmode := 2  		;[1:Manual , 2:Aerial] See below for more info
global CenterCamera := 0	;[0:False , 1:True] Centers camera before an air reload. Will lag Air reload by 1frame.
global AutoRoll := 0    	;[0:False , 1:True] Rolls forward out of the air reload animation at a the earliest possible frame
global AutoWalk := 0    	;[0:False , 1:True] Walks forward out of the air reload animation 
global DisableCrafting := 1	;[0:False , 1:True] Disables the use of _crafter.ahk script
global CraftMagSize := 1	;Define at what magazine size you want the script to start commanding crafts.
global AutoCraftAlways := 0	;[0:False , 1:True] Auto Craft outside RLHBG if conditions are met (???)
global DisableAmmoPlus := 1	;[0:False , 1:True] Disables the use of _ammo.ahk script
global AutoSync := 1		;[0:False , 1:True] Automatically sync ammo menu on map enters
global PrimaryType := -1	;Primary Ammo Type
global SwapPrimary := 0		;[0:False , 1:True] Swap to Primary when other ammo types reach zero (Unless Support Ammo settings say otherwise) 
global StartPrimary := 0	;[0:False , 1:True] Swap to Primary after RLHBG has started. (Unless Support Ammo settings say otherwise) 
global PrimaryJump := 0		;[0:False , 1:True] If ammo available, swap to this ammo on jumps. If multiple set, priority is P>S1>S2>S3>S4
global ReturnPrimary := 0	;[0:False , 1:True] Swap to Primary after RLHBG has ended.
global ReloadPrimary := 0	;[0:False , 1:True] Swap to Primary on commanded RLHBG air reloads.
global ReloadPrimary2 := 0	;[0:False , 1:True] Swap to Primary after RLHBG air reloads.
global AmmoSelect := 1		;[1:Primary, 2:Support 1, 3:Support 2, 4:Support 3, 5:Support 4] Ammo Select
global Support1Type := -1	;Support 1 Ammo Type
global Support2Type := -1	;Support 2 Ammo Type
global Support3Type := -1	;Support 3 Ammo Type
global Support4Type := -1	;Support 4 Ammo Type
global Support1AfterReload := 0	;[0:False , 1:True] Swap to Support1 after RLHBG air reloads.
global Support2AfterReload := 0	;[0:False , 1:True] Swap to Support1 after RLHBG air reloads.
global Support3AfterReload := 0	;[0:False , 1:True] Swap to Support1 after RLHBG air reloads.
global Support4AfterReload := 0	;[0:False , 1:True] Swap to Support1 after RLHBG air reloads.
global Support1Jump := 0	;[0:False , 1:True] If ammo available, swap to this ammo on jumps. If multiple set, priority is S1>S2>S3>S4>P
global Support2Jump := 0	;[0:False , 1:True] If ammo available, swap to this ammo on jumps. If multiple set, priority is S1>S2>S3>S4>P
global Support3Jump := 0	;[0:False , 1:True] If ammo available, swap to this ammo on jumps. If multiple set, priority is S1>S2>S3>S4>P
global Support4Jump := 0	;[0:False , 1:True] If ammo available, swap to this ammo on jumps. If multiple set, priority is S1>S2>S3>S4>P
global Support1ADS := 0		;[0:False , 1:True] If ammo available, swap to this ammo on MixedADS ADS shots. If multiple set, priority is S1>S2>S3>S4
global Support2ADS := 0		;[0:False , 1:True] If ammo available, swap to this ammo on MixedADS ADS shots. If multiple set, priority is S1>S2>S3>S4
global Support3ADS := 0		;[0:False , 1:True] If ammo available, swap to this ammo on MixedADS ADS shots. If multiple set, priority is S1>S2>S3>S4
global Support4ADS := 0		;[0:False , 1:True] If ammo available, swap to this ammo on MixedADS ADS shots. If multiple set, priority is S1>S2>S3>S4
global Support1AR := 0		;[0:False , 1:True]  Swap to Support1 on commanded RLHBG air reloads.
global Support2AR := 0		;[0:False , 1:True]  Swap to Support1 on commanded RLHBG air reloads.
global Support3AR := 0		;[0:False , 1:True]  Swap to Support1 on commanded RLHBG air reloads.
global Support4AR := 0		;[0:False , 1:True]  Swap to Support1 on commanded RLHBG air reloads.
global Support1Next := 0	;[0:False , 1:True]  Assign as an allowable next ammo.
global Support2Next := 0	;[0:False , 1:True]  Assign as an allowable next ammo.
global Support3Next := 0	;[0:False , 1:True]  Assign as an allowable next ammo.
global Support4Next := 0	;[0:False , 1:True]  Assign as an allowable next ammo.  
global Support1Cap := 0		;[0:False , 1:True] If ammo available, swap to this ammo when Monster is capture ready. If multiple set, priority is S1>S2>S3>S4
global Support2Cap := 0		;[0:False , 1:True] If ammo available, swap to this ammo when Monster is capture ready. If multiple set, priority is S1>S2>S3>S4
global Support3Cap := 0		;[0:False , 1:True] If ammo available, swap to this ammo when Monster is capture ready. If multiple set, priority is S1>S2>S3>S4
global Support4Cap := 0		;[0:False , 1:True] If ammo available, swap to this ammo when Monster is capture ready. If multiple set, priority is S1>S2>S3>S4
global HPswapPercent:=3 	;[1:50% ,2:40% ,3:30% ,4:25% ,5:20% ,6:15% ,7:10% ,8:5% ] Percent value of when to call for a Support ammo swap.
global Support1Limit 		;Number of shots to fire before performing "SupportAction". If no limit is set it will perform SupportAction when 0 shots remain.
global Support2Limit 		;Number of shots to fire before performing "SupportAction". If no limit is set it will perform SupportAction when 0 shots remain.
global Support3Limit 		;Number of shots to fire before performing "SupportAction". If no limit is set it will perform SupportAction when 0 shots remain.
global Support4Limit 		;Number of shots to fire before performing "SupportAction". If no limit is set it will perform SupportAction when 0 shots remain.
global Support1Action := 1	;[1:Do Nothing, 2:Swap2Primary, 3:Swap2Support1, 4:Swap2Support1, 5:Swap2Support1, 6:Swap2Support1, 7:EscapeShot, 8:Air Reload]
global Support2Action := 1	;[1:Do Nothing, 2:Swap2Primary, 3:Swap2Support1, 4:Swap2Support1, 5:Swap2Support1, 6:Swap2Support1, 7:EscapeShot, 8:Air Reload]
global Support3Action := 1	;[1:Do Nothing, 2:Swap2Primary, 3:Swap2Support1, 4:Swap2Support1, 5:Swap2Support1, 6:Swap2Support1, 7:EscapeShot, 8:Air Reload]
global Support4Action := 1	;[1:Do Nothing, 2:Swap2Primary, 3:Swap2Support1, 4:Swap2Support1, 5:Swap2Support1, 6:Swap2Support1, 7:EscapeShot, 8:Air Reload]

	
/*
  _Aim Down Sights Mode (ADSmode)_
  (1) None: 	Will shoot all shots without ADS. In this mode you are affected by snowballing deviation buildup. 
                However, full noADS seems to be the fastest shooting mode. Shots in this mode will track camera
                facing direction (intended).

  (2) Standard: ADS only during the air fall state. This is the mode you are most familiar with... you used it
                on your first RLHBG Luna run.

  (3) Mixed:    A combination of noADS & Standard mode. Will only ADS at assigned intervals defined by "MixedADS".
                This is to gain the benefits of nonADS's speed while being able to mitigate full noADS's
                deviation issues.

  (4) Full:    	Will keep you in ADS while in RLHBG. Don't see a reason to use this mode as of right now (Slowest mode).
                Might be useful if I ever figure out how to make you stay in the SMG state.

 _Reload Mode (Rmode)_
  (1) Manual: 	Will shoot last shot in magazine early in nonADS in order to get you back ontop of ledge (manual reload).

  (2)AirReload: AirReloads ontop of Ledge facing backward. In noADS it will center the camera for you. 
                In standard this reload basically ends the RLHBG loop.


*/
;;=================================[Default Timings]===========================
;Sometimes it seems like timings are inconsistent in different scenarios, try messing with these timings if something is not working.

;noADS Shot Timings (The lower the value the faster it shoots)
global nADS1st := 60 	 ;[Range: ~55cm -> ~65cm] The fall DISTANCE before the 1st noADS shot is commanded.
global nADS := 45	 ;[Range: 40cm -> 45cm]   The fall DISTANCE for the rest of commanded no ADS shots.
global nADS2 := 6	 ;[Range: 5f -> 6f]       The fall delay FRAMES the rest of the noADS shots take.
global nADScb := 0	 ;[0:Use nADS, 1: Use nADS2]

;ADS Shot Timings (The lower the value the faster it shoots)
global yADS1st := 10	;[Range: ~5cm -> ~20cm] The fall DISTANCE before the 1st ADS shot is commanded.
global yADS := 5	;[Range: ~0cm -> ~15cm] The fall DISTANCE for the rest of commanded ADS shots.
global yADScb := 0	;[0:Use yADS, 1: No delay]

;Jump Shot Timing (The one after a roll off ledge)
global airT := 28     ;[Range: 26f -> 29f] Delay in FRAMES of when script inputs an air shot.

;;==============================[Default Controls]==============================
;Keyboard Settings
global keyForward := "w"
global keyBack := "s"
global keyLeft := "a"
global keyRight := "d"
global keyReload := "XButton1"
global keyRoll := "Space"
global keyAmmoUp := "Up"
global keyAmmoDown := "Down"
global keyCamera := "LControl"
global keyFire := "LButton"
global keyADS := "Rbutton"

;Script Commands
global keyEnable := "F8"
global keyDisable := "F9"
global keyExit := "F10"
global keyStop := "Joy3"
global keyEscShot := "Joy8"
global keyAmmoSync := "F5"
global keyPrimary := "Joy11"
global keySupport1
global keySupport2
global keySupport3
global keySupport4

;;==============================[Load Libraries]===============================
SetTitleMatchMode 2  ; Avoids the need to specify the full path of files.
#Include resources/lib/Initialization.ahk
#Include resources/lib/MemoryLibrary.ahk
#Include resources/lib/Functions.ahk
#Include _rlhbg_gui.ahk

/* MHW Memory Reads Functions:
   GetAmmoType()	;Returns your Current equipped Ammo type 
   GetAmmoCount(type)	;Returns the Ammo mag count of a given ammo type (ex:Spread3 8mag, 60clip)
   GetAmmoCount2(type)	;Returns the Ammo clip count of a given ammo type
   GetActionID()	;Returns your character's Action State ID
   GetAnimID()		;Returns your character's Primary Animation ID
   GetAnim2ID()		;Returns your character's Secondary Animation ID
   GetXpos()		;Returns your character's X position on Map
   GetYpos()		;Returns your character's Y position on Map
   GetZpos()		;Returns your character's Z position on Map
*/

;;=============================[Custom Functions]==============================

;;Controls safety setting
ToggleSafety(mode="") {
   switch mode {
      case "On": safety := true
      case "Off": safety := false
      default: safety := !safety
   }
}

AmmoCraft(mode:=""){

   if (DisableCrafting){
      If WinExist(AmmoCrafterAHK)
      {
         WinClose, %AmmoCrafterAHK% ahk_class AutoHotkey
      }
   } 
   else{
      If (WinExist(AmmoCrafterAHK)=0) ;must have the "=0" for the NOT(!) 
      {   
         Run %AmmoCrafterAHK%
	 PreciseSleep(100)
      }
   }

   switch mode{
      case "Craft":
         Iniwrite, 1, %c_settings%, cPulse: , _

      default:
   }

}

AmmoPlus(mode:="",GotoType:=-1){

   if (DisableAmmoPlus){
     Iniwrite, -1, %a_settings%, cPulse: , _
     If WinExist(AmmoCyclerAHK)
     {
        WinClose, %AmmoCyclerAHK% ahk_class AutoHotkey
     }
     return 
   } 
   else{
     If (WinExist(AmmoCyclerAHK)=0) ;must have the "=0" for the NOT(!) 
     {   
        Run %AmmoCyclerAHK%
	PreciseSleep(100)
     }
   }

   switch mode{
      case "Swap":
            Iniwrite, %GotoType% , %a_settings%, GotoType: , _
            Iniwrite, 1, %a_settings%, cPulse: , _

      case "Sync":
            Iniwrite, 2, %a_settings%, cPulse: , _

      case "Cycle":
            Iniwrite, 3, %a_settings%, cPulse: , _

      default:

   }
}

;Perform assigned actions given a Support Ammo "n"
SupportAmmoAction(n:=""){

   if (n="")
      return

   ;Loop assigns values to n1, n2, and n3
   m:=1
   k:=1
   Loop , 4
   {
      if (m<>n){
         n%k%:=m
         k:=++k
      }
      m:=++m
   }
   
      Switch Support%n%Action {
         case 1:  ;;Do nothing

         case 2:  ;;Swap to Primary
            AmmoPlus("Swap", PrimaryType)

         case 3:  ;;Swap to Support n1
         case3:
            if (GetAmmoCount(Support%n1%Type)=0) & (SwapPrimary=1) ;;Call Primary if have 0s shot left
               AmmoPlus("Swap",PrimaryType)
            else
               AmmoPlus("Swap", Support%n1%Type)

         case 4:  ;;Swap to Support n2
         case4:
            if (GetAmmoCount(Support%n2%Type)=0) & (SwapPrimary=1) ;;Call Primary if have 0s shot left
               AmmoPlus("Swap",PrimaryType)
            else
               AmmoPlus("Swap", Support%n2%Type)

         case 5:  ;;Swap to Support n3
         case5:
            if (GetAmmoCount(Support%n3%Type)=0) & (SwapPrimary=1) ;;Call Primary if have 0s shot left
               AmmoPlus("Swap",PrimaryType)
            else
               AmmoPlus("Swap", Support%n3%Type)

         case 6:  ;;Next Support
            if ((n1>n) & (GetAmmoCount(Support%n1%Type)>0))
               goto case3
            else if ((n2>n) & (GetAmmoCount(Support%n2%Type)>0)) 
               goto case4
            else if ((n3>n) & (GetAmmoCount(Support%n3%Type)>0))    
               goto case5

         case 7:  ;;Escape Shot
            escRLHBG := true

         case 8:  ;;Air Reload & Stop
            stopRLHBG := true

         case 9:  ;;Air Reload Primary
            stopRLHBG := true
            AmmoPlus("Swap", PrimaryType)

         case 10:  ;;Air Reload Support n1
            stopRLHBG := true
            AmmoPlus("Swap", Support%n1%Type)

         case 11:  ;;Air Reload Support n2
            stopRLHBG := true
            AmmoPlus("Swap", Support%n2%Type)

         case 12:  ;;Air Reload Support n3
            stopRLHBG := true
            AmmoPlus("Swap", Support%n3%Type)

      }
Support%n%Counter := 0
}

;Initialization for RLHBG
RLHBGinit(){

   if (Counter>=0){ 
      Send {%keyBack% up}
      Send {%keyADS% up}
  
      if (ReturnPrimary=1)
         AmmoPlus("Swap", PrimaryType)
    }

   Counter := -1 ;Counter<0 When not in RLHBG mode. The counter denotes the number of sequential RLHBG shots (except in SMG mode)
   PrimaryCounter := 0
   Support1Counter := 0
   Support2Counter := 0
   Support3Counter := 0
   Support4Counter := 0
   stopRLHBG := false
   pauseRLHBG := false
   escRLHBG := false
   AmmoCraft() ;runs script if not running
   AmmoPlus() ;runs script if not running  

}

;;=============================[Main Function]==============================
RLHBG() { 

   ;if !CheckWindow(){
   ;  Msgbox,262144,Error, Please open Monster Hunter World before enabling the script.
   ;   return
   ;}

   ;check if safety is off
   if safety
      return 

   OrbColor("Green")

   LastState := -1 	;;Variable used to track your last state 
   ReScanPtrs()
   RLHBGinit()
   
   ;Wait until MHW Window is open
   While (!CheckWindow()){
      PreciseSleep(34)
   }

   ;;Main Loop
   While (!safety) {

      ;Memory Reads
      currentState := GetActionID()
      ammoType := GetAmmoType()

      ;If currently swapping, assume you will make it and take AmmoCount of target ammo type
      IniRead, cPulse, %a_settings%, cPulse: , _
      if (cPulse=1){
         IniRead, GotoType, %a_settings%, GotoType: , _
         ammoType := GotoType
      }

      ammoCount := GetAmmoCount(ammoType)

      ;Swap to Primary on unsheaths
      if (StartPrimary=1){
         if (AnimID<>GetAnimID()) & (GetAnimID()=33)
            AmmoPlus("Swap",PrimaryType)
         AnimID := GetAnimID()
      }
    
      ;For debugging
      ;Iniwrite, %Counter%, _rlhbg_counter.ini, Counter: , _

      ;;Selection depending on current state
      switch currentState {

         case 0:    ;;Not Moving

            if !(LastState=0)
               RLHBGinit()

            LastState := 0

         case 1:    ;;Sheathed Moving

             LastState := 1

         case 13:    ;;Aerial Melee

            if (LastState<>13)
               RLHBGinit()
            
            LastState := 13

         case 18:    ;;HBG Roll

            if (LastState<>18)
                  AmmoPlus("Cycle")

            LastState := 18

         case 23: ;;falling

            if !(LastState=23){ 

               Time23 := A_TickCount

               StartY := GetYpos()
 
               if (Counter<0)
                  Counter := 0

            if (AmmoCount=0){
               Send {%keyADS% up}
               Counter := -1 
               Goto Skip23 
            }
            
            ;If 1shot left and in Manual Reload mode, escape RLHBG with early nonADS shot
            if ((AmmoCount=1) & (Rmode=1)) or (escRLHBG=true){  
                 Send {%keyADS% up}
                 RLHBGinit()
                 Goto SkipADS
            }

            ;Unpress forward moving direction
            ;Send {%keyForward% up}

            if (Counter < 1){  ;;First shot Delay when falling off
               if ((ADSmode=2) or (ADSmode=4) or ((ADSmode=3) & (StartMixedInADS=1))){
                   YDelta1 := yADS1st ;;ADS fall distance
                   if (YDelta1=0)
                      Goto Skip1stDelay
               }
               else
                   YDelta1 := nADS1st ;noADS fall distance

               while ((StartY - GetYpos()) < YDelta1) {
                  Elapsed23 := A_TickCount - Time23
                  if (Elapsed23>150)
                     goto Skip23
               }

               Skip1stDelay: 
                
                if ((ADSmode=1) or ((ADSmode=3) & (StartMixedInADS=0)))
                   Goto SkipADS

            }else { ;;Any shot after 1st shot Delay when falling off
               if (((ammoCount > 1) & (Rmode=1)) or ((ammoCount > 0) & (Rmode=2))){ 
                  ;Check if ADS or no ADS timing.
                  if ((ADSmode=1) or ((ADSmode=3) & (StartMixedInADS=0) & !(mod(Counter+1,MixedADS)=0)) or ((ADSmode=3) & (StartMixedInADS=1) & !(mod(Counter,MixedADS)=0))){ ;no ADS
                     ;Decide wether to use fall distance timing or flat delay timing
                     if (nADScb=0){
                        while ((StartY - GetYpos()) < nADS) {
                           Elapsed23 := A_TickCount - Time23
                           if (Elapsed23>150)
                              goto Skip23
                        }
                     } else{
                        ;Old shot delays where by flat wait time 
                        nADS_Time:= Ceil(16.67*nADS2)
                        Elapsed23 := A_TickCount - Time23
                        While (Elapsed23<nADS_Time){
                          Elapsed23 := A_TickCount - Time23
                        }
                     }
                    Goto SkipADS
                  }
                  else if (yADScb=0){ ;ADS
                     while ((StartY - GetYpos()) < yADS) {
                        Elapsed23 := A_TickCount - Time23
                        if (Elapsed23>150)
                           goto Skip23
                     }
                  }

               }
               else{ ;;Early nonADS shot for reload
                  PreciseSleep(51)
                  Goto SkipADS ;Skip ADS
               }
            }
 
            Send {%keyADS% down}  

            SkipADS:

            Send {%keyFire% down}
            if (ADSmode=1)
               Send {%keyForward% down}
            Counter := Counter + 1
            sAmmoType := AmmoType ;Store chosen shot ammo type
            PreciseSleep(17)
            ;Send {%keyForward% up}
            Send {%keyFire% up}

            }

            Skip23:

            LastState := 23

         case 24: ;;Ledge Jump

            if !(LastState=24){

               Time24 := A_TickCount
 
               RLHBGinit()

               Send {%keyForward% up}

               if (!DisableAmmoPlus){
                  if ((GetAmmoCount(Support1Type)>0) & (Support1Jump=1)){
                     AmmoPlus("Swap",Support1Type)
                     sAmmoType:=Support1Type
                  }
                  else if ((GetAmmoCount(Support2Type)>0) & (Support2Jump=1)){
                     AmmoPlus("Swap",Support2Type)
                     sAmmoType:=Support2Type
                  }
                  else if ((GetAmmoCount(Support3Type)>0) & (Support3Jump=1)){
                     AmmoPlus("Swap",Support3Type)
                     sAmmoType:=Support3Type
                  }
                  else if ((GetAmmoCount(Support4Type)>0) & (Support4Jump=1)){
                     AmmoPlus("Swap",Support4Type)
                     sAmmoType:=Support4Type
                  }
                  else if ((GetAmmoCount(PrimaryType)>0) & (PrimaryJump=1)){
                     AmmoPlus("Swap",PrimaryType)
                     sAmmoType:=PriamryType
                  }
                  else if (ammoCount=0){
                     Goto Skip24
                  }
                }else if (ammoCount=0)
                   Goto Skip24

               airTime := Ceil(16.67*airT) 
               Elapsed24 := A_TickCount - Time24
               While (Elapsed24<airTime){
                  Elapsed24 := A_TickCount - Time24
               }

               Send {%keyADS% down}
               Send {%keyFire% down}
               Send {%keyForward% down}
               Counter := 0
               PreciseSleep(17)
               Send {%keyFire% up}
               ;Send {%keyForward% up}
            }

            Skip24:

            LastState := 24

         case 25:   ;;Landing Neutral Unsheathed

            case25:    
        
            if (LastState=104){

               Time25 := A_TickCount

               if (ADSmode<4)
                  Send {%keyADS% up}

               if (AmmoCount<=CraftMagSize)
                  AmmoCraft("Craft")
                  
               ;Ledge Air reload. Also force reload on R1 or Circle. Check also that above ledge. Make Sure not mid ammo cycling
               if ((((AmmoCount=0) & (Rmode=2)) or stopRLHBG) & (GetYpos() > (StartY-15)) & (cPulse<>3)){

                  Send {%keyADS% up} ;original

                  if (ADSmode=1) & (CenterCamera=1){
                     Send {%keyCamera% down}
	             PreciseSleep(17)
                     Send {%keyCamera% up}
                  }

                  Elapsed25 := A_TickCount - Time25
                  While (Elapsed25<167){
                     Elapsed25 := A_TickCount - Time25
                  }

                  Send {%keyBack% down}
                  Send {%keyReload% down}

                  rAmmoType := GetAmmoType() ;store requested reload ammo type

                  CurrentTime := A_TickCount
                  while !((GetActionID()=84)){ ;Wait until air reload begins. If air melees exit
                     	ElapsedTime := A_TickCount - CurrentTime
                        if (ElapsedTime>334) ;Exit if it doesnt make it in 20f
                           break
                  }

                  if (DisableAmmoPlus=0){
                     if (ReloadPrimary2=1)
                        AmmoPlus("Swap",PrimaryType)
                     else if (Support1AfterReload=1)
                        AmmoPlus("Swap",Support1Type)
                     else if (Support2AfterReload=1)
                        AmmoPlus("Swap",Support2Type)
                     else if (Support3AfterReload=1)
                        AmmoPlus("Swap",Support3Type)
                     else if (Support4AfterReload=1)
                        AmmoPlus("Swap",Support4Type)
                  }

               Send {%keyReload% up}
               Send {%keyBack% up}

            }
}
            Skip25:
 
            LastState := 25

         case 27:   ;;Landing Moving Unsheathed

            goto case25

            LastState := 27

         case 65:    ;;ADS transition ON

            if (Counter>=0)
               Send {%keyADS% up}

            RLHBGinit()

            LastState := 65

         case 67:  ;;ADS Standing

            if (Counter>=0)
               Send {%keyADS% up}

            RLHBGinit()

            LastState := 67
         
         case 69:    ;;ADS Moving

            RLHBGinit()

            LastState := 69

        case 79:   ;;Slow HBG Reload

            RLHBGinit()

            LastState := 79

         case 82:  ;;HBG Air Reload

            LastState := 82

	 case 84: ;;HBG Landing Reload

            if !(LastState=84){
               Time84 := A_TickCount
               Send {%keyBack% up}
               PreciseSleep(84) ;Give ammo crafting some buffer
               AmmoPlus("Cycle")

               ;If above ledge, auto roll out of air reload
               if ((GetYpos() > (StartY-15)) & ((Rmode=2) & ((AutoRoll=1) or (AutoWalk=1))) & !stopRLHBG){

                  ;Store preReload AmmoCount
                  rAmmoCount := GetAmmoCount(rAmmoType)
             
                  CurrentTime := A_TickCount
                  ;Wait until ammo changes before rolling
                  While (rAmmoCount=GetAmmoCount(rAmmoType)){ 
                     ElapsedTime := A_TickCount - CurrentTime
                     if (ElapsedTime>1000) ;wait max 1000ms
                        Goto Skip84
                  }

                  if stopRLHBG
                     goto Skip84

                  Send {%keyADS% down}

                  CurrentTime := A_TickCount
                  ElapsedTime := A_TickCount - CurrentTime
                  ;Delay roll by holding ADS
                  While (Getkeystate(keyADS,"P") or Getkeystate("Joy7","P")){
                     ElapsedTime := A_TickCount - CurrentTime
                     if ((ElapsedTime>2000) or stopRLHBG)
                        Goto Skip84
                  }

                  if (AutoRoll=1){		;Auto Roll
                     Send {%keyForward% down}
                     Send {%keyRoll% down}
                     PreciseSleep(17)
                     Send {%keyForward% up}
                     Send {%keyRoll% up}
                  } 
                  else if (AutoWalk=1){		;Auto Walk
                     Send {%keyBack% down}

                     CurrentTime := A_TickCount
                     While (GetActionID()=84){
                        ElapsedTime := A_TickCount - CurrentTime
                        if ((ElapsedTime>2000) or stopRLHBG) ;wait max 2000ms
                           Goto Skip84
                     }

                     PreciseSleep(17)
                     Send {%keyBack% up}

                     ;If doing an extra fast ground reload this will wait until you are done before proceeding
                     CurrentTime := A_TickCount
                     While (GetAnim2ID()=102){
                        ElapsedTime := A_TickCount - CurrentTime
                        if ((ElapsedTime>1500) or stopRLHBG){ ;wait max 1500ms
                           Send {%keyADS% up}
                           Goto Skip84
                        }
                     }

                     CurrentTime := A_TickCount
                     ElapsedTime := A_TickCount - CurrentTime
                     ;Delay walk by holding ADS
                     While (Getkeystate(keyADS,"P") or Getkeystate("Joy7","P")){
                        ElapsedTime := A_TickCount - CurrentTime
                        if ((ElapsedTime>2000) or stopRLHBG)
                           Goto Skip84
                     }

                     Send {%keyForward% down}
                     PreciseSleep(17)
                     Send {%keyADS% up}

                     CurrentTime := A_TickCount
                     While (GetActionID()<>23){
                        ElapsedTime := A_TickCount - CurrentTime
                        if (ElapsedTime>200){ ;wait max 100ms
                           Send {%keyForward% up}
                           Goto Skip84
                           }
                     }
                     Send {%keyForward% up}
                  }
               }
               else{
                  PreciseSleep(834)
                  Send {%keyADS% down}

                  CurrentTime := A_TickCount
                  While (GetActionID()=84){
                     ElapsedTime := A_TickCount - CurrentTime
                     if (ElapsedTime>1000) ;wait max 1000ms
                        break
                  }
                  PreciseSleep(51)
                  Send {%keyADS% up}

               }

               Skip84:

               RLHBGinit()
            }
     
           ;Skip84:

           LastState := 84

	 case 85: ;;Cluster ADS Enter

               RLHBGinit()

           LastState := 85

	 case 86: ;;Cluster ADS Exit

            if (LastState<>86){

               if (Counter>=0){
                  Send {%keyADS% up}
                  RLHBGinit()
               }
               AmmoPlus("Cycle")
             }

           LastState := 86

	 case 87: ;;Cluster ADS

            if (Counter>=0){
               Send {%keyADS% up}
               RLHBGinit()
             }

           LastState := 87

         case 104:    ;;HBG Airshot
                    
            if !(LastState=104){
               Time104 := A_TickCount
               ;Send {%keyForward% up}
               AmmoPlus("Cycle")

               ;Wait for shot count to update if in ADS. No ADS has no delay:
               if (Getkeystate(keyADS)=1){
                  Elapsed104 := A_TickCount - Time104
                  While (Elapsed104<150){                   
                     Elapsed104 := A_TickCount - Time104
                  }
                } 

               if (LastState=24)
                  Send {%keyADS% up}

               if (!DisableAmmoPlus & !stopRLHBG){

                  ;Check if any of these hp swap checkbox conditions are set
                  if ((Support1Cap=1) or (Support2Cap=1) or (Support3Cap=1) or (Support4Cap=1)){
                     ;Reset HP ammo auto switch if HP change is detected
                     if (Monster1HP<>GetMon1MaxHp()){
                        hpAmmoShot:=false
                        Monster1MaxHp:= GetMon1MaxHp()
                     }

                     if (hpAmmoShot=false){   

                        MonHpPercent:= (GetMon1Hp()/Monster1MaxHp)*100

                        if (HPswapPercent=1)
                           HpPercent:=50
                        else if (HPswapPercent=2)
                           HpPercent:=40
                        else if (HPswapPercent=3)
                           HpPercent:=30
                        else if (HPswapPercent=4)
                           HpPercent:=25
                        else if (HPswapPercent=5)
                           HpPercent:=20
                        else if (HPswapPercent=6)
                           HpPercent:=15
                        else if (HPswapPercent=7)
                           HpPercent:=10
                        else if (HPswapPercent=8)
                           HpPercent:=5
                        else
                           HpPercent:=0

                        ;if Monster drops below threshold HP and you have not done this swap, swap (if ammo available). This will override any other swaps.
                        if ((GetAmmoCount(Support1Type)>0) & (Support1Cap=1) & (MonHpPercent<=HpPercent)){
                           AmmoPlus("Swap",Support1Type)
                           Goto Skip104
                        }
                        else if ((GetAmmoCount(Support2Type)>0) & (Support2Cap=1) & (MonHpPercent<=HpPercent)){
                           AmmoPlus("Swap",Support2Type)
                           Goto Skip104
                        }
                        else if ((GetAmmoCount(Support3Type)>0) & (Support3Cap=1) & (MonHpPercent<=HpPercent)){
                           AmmoPlus("Swap",Support3Type)
                           Goto Skip104
                        }
                        else if ((GetAmmoCount(Support4Type)>0) & (Support4Cap=1) & (MonHpPercent<=HpPercent)){
                           AmmoPlus("Swap",Support4Type)
                           Goto Skip104
                        }
                        hpAmmoShot:=true
                     }
                  }

                  if ((sAmmoType = Support1Type) & (Support1Action>1)){
                     Support1Counter:=++Support1Counter
                     if Support1Limit is Number
                     {
                        if (Support1Counter>=Support1Limit){
                           SupportAmmoAction(1)
                           Goto Skip104
                        }
                     }
                     else if (GetAmmoCount(Support1Type)=0) 
                     {
                        SupportAmmoAction(1)
                        Goto Skip104
                     }
                  }
                  else if ((sAmmoType = Support2Type) & (Support2Action>1)){
                     Support2Counter:=++Support2Counter
                     if Support2Limit is Number
                     {
                        if (Support2Counter>=Support2Limit){
                           SupportAmmoAction(2)
                           Goto Skip104
                        }
                     }
                     else if (GetAmmoCount(Support2Type)=0) 
                     {
                        SupportAmmoAction(2)
                        Goto Skip104
                     }
                  }
                  else if ((sAmmoType = Support3Type) & (Support3Action>1)){
                     Support3Counter:=++Support3Counter
                     if Support3Limit is Number
                     {
                        if (Support3Counter>=Support3Limit){
                           SupportAmmoAction(3)
                           Goto Skip104
                        }
                     }
                     else if (GetAmmoCount(Support3Type)=0) 
                     {
                        SupportAmmoAction(3)
                        Goto Skip104
                     }
                  }
                  else if ((sAmmoType = Support4Type) & (Support4Action>1)){
                     Support4Counter:=++Support4Counter
                     if Support4Limit is Number
                     {
                        if (Support4Counter>=Support4Limit){
                           SupportAmmoAction(4)
                           Goto Skip104
                        }
                     }
                     else if (GetAmmoCount(Support4Type)=0) 
                     {
                        SupportAmmoAction(4)
                        Goto Skip104
                     }
                  }            
                  else if ((GetAmmoCount(AmmoType)=0) & (SwapPrimary=1)) ;;Call Primary if have 0s shot left
                     AmmoPlus("Swap",PrimaryType)

                  if ((ADSmode=3)  &  (((Counter>0) & (StartMixedInADS=0) & (mod(Counter+1,MixedADS)=0)) or ((StartMixedInADS=1) & (mod(Counter,MixedADS)=0)))){ ; Check if next shot in MixedADS mode is ADS
                     if ((GetAmmoCount(Support1Type)>0) & (Support1ADS=1)){
                        AmmoPlus("Swap",Support1Type)
                        Goto Skip104
                     }
                     else if ((GetAmmoCount(Support2Type)>0) & (Support2ADS=1)){
                        AmmoPlus("Swap",Support2Type)
                        Goto Skip104
                     }
                     else if ((GetAmmoCount(Support3Type)>0) & (Support3ADS=1)){
                        AmmoPlus("Swap",Support3Type)
                        Goto Skip104
                     }
                     else if ((GetAmmoCount(Support4Type)>0) & (Support4ADS=1)){
                        AmmoPlus("Swap",Support4Type)
                        Goto Skip104
                     }
                  }
               }              
            }
   
            Skip104:

            if (ADSmode=4) & (SMG=1) & (GetAmmoCount(AmmoType)>0) & (!stopRLHBG) & !(((AmmoCount=1) & (Rmode=1)) or (escRLHBG=true)) & !(Getkeystate(keyADS,"P") or Getkeystate("Joy7","P"))
               Send {%keyBack% down}
            else
               Send {%keyBack% up}

            Elapsed104 := A_TickCount - Time104
            While (Elapsed104<67){
               Elapsed104 := A_TickCount - Time104
            }

            if (ADSmode=1)
               Send {%keyForward% up} 

            LastState := 104

         case 112:    ;;HBG Post Reload Roll

            if (LastState<>112)
                  AmmoPlus("Cycle")

            LastState := 112

         case 313:	;;Quest Start Walk

             if !(LastState=313){
                ReScanPtrs()
                PreciseSleep(500)
                AmmoPlus("Sync")
              }

            LastState := 313

         case 314:	;;Quest Start Bird Drop

             if !(LastState=314){
                ReScanPtrs()
                PreciseSleep(1000)
                AmmoPlus("Sync")
              }

            LastState := 314

         case 319:	;;Quest Start Drunk Bird (Animation starts at 318 but on 319 you can scroll items)

             if !(LastState=319){
                ReScanPtrs()
                PreciseSleep(1000)
                AmmoPlus("Sync")
              }
         
            LastState := 319

         case 585:	;;Reload script after equipment menu is closed
 
            ReScanPtrs()
            AHKPanic(1,0,0,0) ;Kill all other scripts
            PreciseSleep(17) ;Buffer to let other scripts close
            Reload

         default: 

            RLHBGinit()
            
      }
   }
}
Return
;;=================================[Variables]==================================
global safety := true
global Counter := -1
global PrimaryCounter := 0
global Support1Counter := 0
global Support2Counter := 0
global Support3Counter := 0
global Support4Counter := 0
global AmmoCount := -1
global stopRLHBG := false
global pauseRLHBG := false
global escRLHBG := false
global sAmmoType := -1
global hpAmmoShot:=false

;Debugging
Record:=0
;;=================================[Hotkeys]====================================
;;Gamepad Hotkeys

Enable:
SoundPlay resources/sounds/smw_1-up.wav
ToggleSafety("Off")
RLHBG()
Return

Disable:
SoundPlay resources/sounds/smw_dragon_coin.wav
ToggleSafety("On")
OrbColor("Red")
Return

Exit:
CleanExit()
AHKPanic(1,0,0,1) ;Kill all scripts
Return

;Stop RLHBG
Stop:
if (Counter>=0){
   if (ReloadPrimary=1)
      AmmoPlus("Swap",PrimaryType)
   else if (Support1AR=1)
      AmmoPlus("Swap",Support1Type)
   else if (Support2AR=1)
      AmmoPlus("Swap",Support2Type)
   else if (Support3AR=1)
      AmmoPlus("Swap",Support3Type)
   else if (Support4AR=1)
      AmmoPlus("Swap",Support4Type)
   stopRLHBG := true
}
Return

;Escape RLHBG
EscShot:
if (Counter>=0)
   escRLHBG := true
Return

;Call for an AmmoSync
AmmoSync:
AmmoPlus("Sync")
return

;Primary
Primary:
AmmoPlus("Swap",PrimaryType)
return

;Support 1
Support1:
Support1Counter := 0
Support2Counter := 0
Support3Counter := 0
Support4Counter := 0
AmmoPlus("Swap",Support1Type)
return

;Support 2
Support2:
Support1Counter := 0
Support2Counter := 0
Support3Counter := 0
Support4Counter := 0
AmmoPlus("Swap",Support2Type)
return

;Support 3
Support3:
Support1Counter := 0
Support2Counter := 0
Support3Counter := 0
Support4Counter := 0
AmmoPlus("Swap",Support3Type)
return

;Support 4
Support4:
Support1Counter := 0
Support2Counter := 0
Support3Counter := 0
Support4Counter := 0
AmmoPlus("Swap",Support4Type)
return
