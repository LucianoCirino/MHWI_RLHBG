/* Gui settings will be loaded from resources/data/...
      ...rlhbg_settings.ini
      ...c_settings.ini
      ...a_settings.ini
*/
AHKPanic(1,0,0,0) ;Kill all other scripts
SetTitleMatchMode 2  ; Avoids the need to specify the full path of files.
#Include resources/lib/Initialization.ahk
#Include resources/lib/Functions.ahk
#Include resources/lib/GuiLibrary.ahk

;Gui global Variables
;Tab 1: General
global ADSmode_ , SMG_ , MixedADS_ , MixedADS_box , MixedADS_text, StartMixedInADS_ , Rmode_ , CenterCamera_ , AutoRoll_ , AutoWalk_
;Tab 2: Timings
global nADS1st_ , nADS1st_box , nADS_, nADS2_ , nADScb_ , nADS_box , yADS1st_ , yADS1st_box , yADS_ , yADS2_, yADScb_ , airT_ , airT_box
;Tab 3: Crafting
global DisableCrafting_ , AutoCraftAlways_ , HbMenu_ , Slot1_ , Slot2_ , Slot3_ , CraftMagSize_
;Tab 4: Ammo+
global DisableAmmoPlus_ , AutoSync_ ;, DisableCheckBoxes
global PrimaryType_ , Primaryhwnd, StartPrimary_ , PrimaryJump_ , ReturnPrimary_ , ReloadPrimary_ , ReloadPrimary2_ , SwapPrimary_ 
global AmmoSelect_ , Support1Type_ , Support1hwnd , Support1AfterReload_ , Support1Jump_ , Support1ADS_ , Support1AR_ , Support1Next_ , Support1Cap_ , HPswapPercent_ , Support1Limit_ , Support1Action_
global Support2Type_ , Support2hwnd , Support2AfterReload_ , Support2Jump_ , Support2ADS_ ,  Support2AR_ , Support2Cap_ , Support2Next_ , Support2Limit_ , Support2Action_
global Support3Type_ , Support3hwnd , Support3AfterReload_ , Support3Jump_ , Support3ADS_ ,  Support3AR_ , Support3Cap_ , Support3Next_ , Support3Limit_ , Support3Action_  
global Support4Type_ , Support4hwnd , Support4AfterReload_ , Support4Jump_ , Support4ADS_ ,  Support4AR_ , Support4Cap_ , Support4Next_ ,Support4Limit_ , Support4Action_  

;Tab 5: Controls
global EditMode_ , keyForward_, keyBack_ , keyLeft_ , keyRight_ , keyReload_ , keyAmmoUp_ , keyAmmoDown_ , keyRoll_ , keyCamera_ , keyFire_ , keyADS_
global keyEnable_ , keyDisable_ , keyExit_ , keyStop_ , keyEscShot_ , keyAmmoSync_ , keyPrimary_ , keySupport1_ , keySupport2_ , keySupport3_ , keySupport4_
;Other
global KeepOnTop_

;Create Gui
Gui, Font, s12 ; Set a large font size (32-point).
Gui, Add, Tab2, w400 h350 gSubmit_ALL vtab, General|Timings|Crafting|Ammo+|Controls  ; Tab2 vs. Tab requires [v1.0.47.05+].

;Tab 1: General
Gui, Tab, 1
   ;ADS Mode
   Gui, Font, s12 cBlack
   Gui, Add, GroupBox, xs+10 ys+35 w380 h145, ADS Mode
   Gui, Add, ComboBox, xs+35 ys+65 w100 vADSmode_ gSubmit_ALL, noADS||Standard|Mixed|Full
   ;Control_Colors("ADSmode", "Set", "0x000000", "0x990000")
   Gui, Font, s10 cBlack
   Gui, Add, Text,xs+170 ys+52 w210 r7 vADSmode_Desc,
   Gui, Add, Checkbox, xs+25 ys+110 vSMG_ gSubmit_ALL, Submachine Gun
   Gui, Add, Edit,xs+96 ys+97 w50 r1 vMixedADS_box ReadOnly -e0x200,
   Gui, Add, Text,xs+29 ys+97 w65 vMixedADS_text, ADS every
   Gui, Add, Slider, xs+12 ys+120 TickInterval1 Range2-4 ToolTipBottom vMixedADS_ gSubmit_ALL,
   Gui, Add, Checkbox, xs+40 ys+152 vStartMixedInADS_ gSubmit_ALL, Start with ADS
   Gui, Font, s9 cBlack
   Gui, Add, Button, xs+75 ys+135 vSMGButton gSMGButton , ?
   ;Reload Mode
   Gui, Font, s12 cBlack
   Gui, Add, GroupBox, xs+10 ys+180 w380 h140, Reload Mode
   Gui, Add, ComboBox, xs+35 ys+210 w100 vRmode_ gSubmit_ALL, Manual||Aerial
   Gui, Font, s10 cBlack
   Gui, Add, Checkbox, xs+30 ys+247 vAutoRoll_ gSubmit_ALL, Auto roll
   Gui, Add, Checkbox, xs+30 ys+269 vAutoWalk_ gSubmit_ALL, Auto walk
   Gui, Add, Checkbox, xs+30 ys+291 vCenterCamera_ gSubmit_ALL, Center camera
   Gui, Add, Text,xs+170 ys+197 w195 r7 vRmode_Desc,
   Gui, Font, s9 cBlack
   Gui, Add, Button, xs+110 ys+253 vWalkRollButton gWalkRollButton , ?

   Gui, Font, s9 cBlue Normal
   Gui, Add, Text, xs+25 ys+325 , Note: No script changes are applied until you click the Save button below.

;Tab 2: Timings
Gui, Tab, 2
   ;noADS Shot Timings
   Gui, Font, s12 cBlack
   Gui, Add, GroupBox, xs+7 ys+35 w195 h180 Center, no ADS
      ;nADS1st
      Gui, Font, s11 cBlack
      Gui, Add, Text,xs+15 ys+70, 1st Shot Fall Distance:
      Gui, Font, s12 cBlack
      Gui, Add, Slider, xs+15 ys+100 TickInterval Range55-65 ToolTipBottom vnADS1st_ gSubmit_ALL,60
      Gui, Add, Edit,xs+149 ys+65 w45 r1 vnADS1st_box ReadOnly Center,
      Control_Colors("nADS1st_box", "Set", "0xFFFFFF", "0x000000")
      ;nADS
      Gui, Font, s11 cBlack
      Gui, Add, Text,xs+15 ys+140, Every Shot After:
      Gui, Add, Checkbox, xs+130 ys+143 w12 h12 vnADScb_ gSubmit_ALL ,
      Gui, Font, s12 cBlack
      Gui, Add, Slider,xs+15 ys+170 TickInterval Range41-50 ToolTipBottom vnADS_ gSubmit_ALL, 45
      Gui, Add, Slider,xs+15 ys+170 TickInterval Range5-7 ToolTipBottom vnADS2_ gSubmit_ALL, 6
      Gui, Add, Edit,xs+149 ys+135 w45 r1 vnADS_box ReadOnly Center,
      Control_Colors("nADS_box", "Set", "0xFFFFFF", "0x000000")

      
   ;ADS Shot Timings
   Gui, Add, GroupBox, xs+200 ys+35 w195 h180 Center, ADS
      ;yADS1st
      Gui, Font, s11 cBlack
      Gui, Add, Text,xs+208 ys+70, 1st Shot Fall Distance:
      Gui, Font, s12 cBlack
      Gui, Add, Slider, xs+208 ys+100 TickInterval Range0-20 ToolTipBottom vyADS1st_ gSubmit_ALL,10
      Gui, Add, Edit,xs+342 ys+65 w45 r1 vyADS1st_box ReadOnly Center,
      Control_Colors("yADS1st_box", "Set", "0xFFFFFF", "0x000000")
      ;yADS
      Gui, Font, s11 cBlack
      Gui, Add, Text,xs+211 ys+140, Every Shot After:
      Gui, Add, Checkbox, xs+326 ys+143 w12 h12 vyADScb_ gSubmit_ALL ,
      Gui, Font, s12 cBlack
      Gui, Add, Slider, xs+208 ys+170 TickInterval2 Range0-15 ToolTipBottom vyADS_ gSubmit_ALL,5
      Gui, Add, Slider, xs+208 ys+170 TickInterval2 Range0 ToolTipBottom Disabled vyADS2_ gSubmit_ALL,0
      Gui, Add, Edit,xs+342 ys+135 w45 r1 vyADS_box ReadOnly Center,
      Control_Colors("yADS_box", "Set", "0xFFFFFF", "0x000000")
   ;Jump Shot Timing
   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+200 ys+203 w195 h130 Center, Jump Shot
      Gui, Font, s12 cBlack Normal
      Gui, Add, Slider, xs+208 ys+263 TickInterval Range26-29 ToolTipBottom vairT_ gSubmit_ALL,28
      Gui, Add, Edit,xs+342 ys+233 w40 r1 vairT_box ReadOnly Center,
      Control_Colors("airT_box", "Set", "0xFFFFFF", "0x000000")

   ;InfoBox
   Gui, Add, GroupBox, xs+7 ys+203 w195 h130,
   Gui, Font, s9 cBlue Normal
   Gui, Add, Text, xs+15 ys+218 w182 , Note: The best timing settings will depend on the geometry of the ledge. 

;Tab 3: Crafting
Gui, Tab, 3
   Gui, Font, s12 cBlack Normal
   Gui, Add, Checkbox, vDisableCrafting_ gSubmit_ALL, Disable Auto Crafting
   ;Auto Craft Settings
   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+60 w370 h275 Center, Craft Item Locations
   ;Gui, Add, Checkbox, xs+25 ys+100 w300 r1 vAutoCraftAlways_ gSubmit_ALL, Auto Craft outside RLHBG ;Currently not setup
   Gui, Add, Text,xs+25 ys+93, Hotbar Menu:
   Gui, Add, ComboBox, xs+145 ys+88 w50 r10 vHbMenu_ gSubmit_All, F1||F2|F3|F4
   Gui, Add, Text,xs+25  ys+133, Craft item slots:
   Gui, Add, ComboBox, xs+145  ys+128 w50 vSlot1_ gSubmit_All, -||1|2|3|4|5|6|7|8
   Gui, Add, ComboBox, xs+205  ys+128 w50 vSlot2_ gSubmit_All, -||1|2|3|4|5|6|7|8
   Gui, Add, ComboBox, xs+265 ys+128 w50 vSlot3_ gSubmit_All, -||1|2|3|4|5|6|7|8
   Gui, Font, s9 cRed Normal
   Gui, Add, Text,xs+25 ys+165 r2 w340 Center, Warning: Do not put non-craft items into the "Craft item slots" above.

   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+185 w370 h150 Center, Craft Conditions
   Gui, Add, Text,xs+25 ys+218, Craft when >=
   Gui, Add, ComboBox, xs+125 ys+213 w40 vCraftMagSize_ gSubmit_All, 0||1|2
   Gui, Add, Text,xs+170 ys+218, shot(s) remain
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+276 ys+223, (*during RLHBG)
   ;Gui, Font, s12 cBlack Normal
   ;Gui, Add, Checkbox, xs+25 ys+250 gSubmit_ALL w330 r2, If any ammo type's clip hits zero
   Gui, Font, s9 cBlue Normal
   Gui, Add, Text,xs+25 ys+300 r2 w340 Center, Note: Some automatic craft conditions may interfere with ammo control.

   

;Tab 4: Ammo+
Gui, Tab, 4
   Gui, Font, s12 cBlack Normal
   Gui, Add, Checkbox, vDisableAmmoPlus_ gSubmit_ALL, Disable Ammo Control

   ;AmmoSync
   Gui, Font, s11 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+55 w370 h43 Center ,
   Gui, Add, Picture, x285 y82 +BackgroundTrans gAmmoSyncMsg, resources/pics/Question(16x16).png
   Gui, Font, s18 cBlack Normal
   Gui, Add, Button, w30 h26 xs+20 ys+67 gAmmoList, ▤ ;☰
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+305 ys+68 w70 vAmmoSync_box Center ReadOnly,
   Gui, Add, Checkbox, xs+60 ys+73 vAutoSync_ gSubmit_ALL , Auto Sync when entering maps

   ;Ammo Setup
   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+86 w370 h255 Center,

   Gui, Add, Picture, x40 y115 +BackgroundTrans vPrimaryIcon, resources/pics/star(24x24).png
   Gui, Add, Picture, x40 y115 +BackgroundTrans vSupport1Icon, resources/pics/number-1(24x24).png
   Gui, Add, Picture, x40 y115 +BackgroundTrans vSupport2Icon, resources/pics/number-2(24x24).png
   Gui, Add, Picture, x40 y115 +BackgroundTrans vSupport3Icon, resources/pics/number-3(24x24).png
   Gui, Add, Picture, x40 y115 +BackgroundTrans vSupport4Icon, resources/pics/number-4(24x24).png

   Gui, Add, ComboBox, xs+60 ys+105 w100 vAmmoSelect_ gSubmit_ALL, Primary||Support 1|Support 2|Support 3|Support 4

   Gui, Font, s14 cBlack Normal
   Gui, Add, Text, xs+175 ys+107, =

   Gui, Font, s12 cBlack Normal
   Gui, Add, ComboBox, xs+200 ys+105 w90 hwndPrimaryhwnd vPrimaryType_ gSubmit_ALL, -||Spread 3|Pierce 3|Dragon|Cluster 3
   Gui, Add, ComboBox, xs+200 ys+105 w90 hwndSupport1hwnd vSupport1Type_ gSubmit_ALL, -||Spread 3|Spread 2|Pierce 3|Normal 3|Dragon|Para 2|Para 1|Sleep 2|Sleep 1|Sticky 3|Sticky 2|Tranq
   Gui, Add, ComboBox, xs+200 ys+105 w90 hwndSupport2hwnd vSupport2Type_ gSubmit_ALL, -||Spread 3|Spread 2|Pierce 3|Normal 3|Dragon|Para 2|Para 1|Sleep 2|Sleep 1|Sticky 3|Sticky 2|Tranq
   Gui, Add, ComboBox, xs+200 ys+105 w90 hwndSupport3hwnd vSupport3Type_ gSubmit_ALL, -||Spread 3|Spread 2|Pierce 3|Normal 3|Dragon|Para 2|Para 1|Sleep 2|Sleep 1|Sticky 3|Sticky 2|Tranq
   Gui, Add, ComboBox, xs+200 ys+105 w90 hwndSupport4hwnd vSupport4Type_ gSubmit_ALL, -||Spread 3|Spread 2|Pierce 3|Normal 3|Dragon|Para 2|Para 1|Sleep 2|Sleep 1|Sticky 3|Sticky 2|Tranq

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+305 ys+107 w70 vPrimary_box Center ReadOnly, ;Hotkey
   Gui, Add, Edit, xs+305 ys+107 w70 vSupport1_box Center ReadOnly, ;Hotkey
   Gui, Add, Edit, xs+305 ys+107 w70 vSupport2_box Center ReadOnly, ;Hotkey
   Gui, Add, Edit, xs+305 ys+107 w70 vSupport3_box Center ReadOnly, ;Hotkey
   Gui, Add, Edit, xs+305 ys+107 w70 vSupport4_box Center ReadOnly, ;Hotkey

   Gui, Font, s11 cBlack Normal
   Gui, Add, Text,xs+75 ys+145 , After
   Gui, Add, ComboBox, xs+110 ys+142 w30 vPrimaryLimit_ disabled gSubmit_ALL, -||1|2|3|4|5|6|7|8|9
   Gui, Add, ComboBox, xs+110 ys+142 w30 vSupport1Limit_ gSubmit_ALL, -||1|2|3|4|5|6|7|8|9
   Gui, Add, ComboBox, xs+110 ys+142 w30 vSupport2Limit_ gSubmit_ALL, -||1|2|3|4|5|6|7|8|9
   Gui, Add, ComboBox, xs+110 ys+142 w30 vSupport3Limit_ gSubmit_ALL, -||1|2|3|4|5|6|7|8|9
   Gui, Add, ComboBox, xs+110 ys+142 w30 vSupport4Limit_ gSubmit_ALL, -||1|2|3|4|5|6|7|8|9
   Gui, Add, Text,xs+145 ys+145 , shot(s),
   Gui, Add, ComboBox, xs+190 ys+142 w150 vPrimaryAction_ Disabled gSubmit_ALL, -||
   Gui, Add, ComboBox, xs+190 ys+142 w150 vSupport1Action_ gSubmit_ALL, -||Swap to Primary|Swap to Support 2|Swap to Support 3|Swap to Support 4|Swap to next Support|Escape Shot|Air Reload & Stop|Air Reload Primary|Air Reload Support 2|Air Reload Support 3|Air Reload Support 4
   Gui, Add, ComboBox, xs+190 ys+142 w150 vSupport2Action_ gSubmit_ALL, -||Swap to Primary|Swap to Support 1|Swap to Support 3|Swap to Support 4|Swap to next Support|Escape Shot|Air Reload & Stop|Air Reload Primary|Air Reload Support 1|Air Reload Support 3|Air Reload Support 4
   Gui, Add, ComboBox, xs+190 ys+142 w150 vSupport3Action_ gSubmit_ALL, -||Swap to Primary|Swap to Support 1|Swap to Support 2|Swap to Support 4|Swap to next Support|Escape Shot|Air Reload & Stop|Air Reload Primary|Air Reload Support 1|Air Reload Support 2|Air Reload Support 4
   Gui, Add, ComboBox, xs+190 ys+142 w150 vSupport4Action_ gSubmit_ALL, -||Swap to Primary|Swap to Support 1|Swap to Support 2|Swap to Support 3|Swap to next Support|Escape Shot|Air Reload & Stop|Air Reload Primary|Air Reload Support 1|Air Reload Support 2|Air Reload Support 3

   Gui, Font, s18 cBlack Normal
   Gui, Add, Button, w30 h25 x360 y150 Center vResetAmmo gResetAmmo,↩

   Gui, Add, Picture, x65 y182 +BackgroundTrans, resources/pics/Line.png

   Gui, Font, s12 cBlack Normal

   Gui, Add, Picture, x38 y195 vHighlightPrimary, resources/pics/Highlight.png
   Gui, Add, Picture, x36 y186 +BackgroundTrans vSelectedPrimary, resources/pics/selected(24x24).png
   Gui, Add, Picture, x40 y190 +BackgroundTrans gPrimarySelect, resources/pics/star(16x16).png

   Gui, Add, Picture, x58 y195 vHighlightSupport1, resources/pics/Highlight.png
   Gui, Add, Picture, x56 y186 +BackgroundTrans vSelectedSupport1, resources/pics/selected(24x24).png
   Gui, Add, Picture, x60 y190 +BackgroundTrans gSupport1Select, resources/pics/number-1(16x16).png

   Gui, Add, Picture, x78 y195 vHighlightSupport2, resources/pics/Highlight.png
   Gui, Add, Picture, x76 y186 +BackgroundTrans vSelectedSupport2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x80 y190 +BackgroundTrans gSupport2Select, resources/pics/number-2(16x16).png

   Gui, Add, Picture, x98 y195 vHighlightSupport3, resources/pics/Highlight.png
   Gui, Add, Picture, x96 y186 +BackgroundTrans vSelectedSupport3, resources/pics/selected(24x24).png
   Gui, Add, Picture, x100 y190 +BackgroundTrans gSupport3Select, resources/pics/number-3(16x16).png

   Gui, Add, Picture, x118 y195 vHighlightSupport4, resources/pics/Highlight.png
   Gui, Add, Picture, x116 y186 +BackgroundTrans vSelectedSupport4, resources/pics/selected(24x24).png
   Gui, Add, Picture, x120 y190 +BackgroundTrans gSupport4Select, resources/pics/number-4(16x16).png

   Gui, Font, s11 cBlack Underline
   Gui, Add, Text,xs+130 ys+181 , Swap to Conditions:
   Gui, Font, s11 cBlack Normal
   Gui, Add, Button, h15 w15 xs+255 ys+182 gSwapInfo1, *
   ;Gui, Font, s9 cBlack Normal
   ;Gui, Add, Button,xs+250 ys+175 gSwapPriority , ?

   Gui, Font, s11 cBlack Normal
   Gui, Add, Text,xs+130 ys+200 , Unsheathing
   Gui, Add, Checkbox, h12 w12 xs+27 ys+201 vStartPrimary_ gSubmit_ALL,
   ;Gui, Add, Checkbox, h12 w12 xs+47 ys+201 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+47 ys+201 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+67 ys+201 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+67 ys+201 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+87 ys+201 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+87 ys+201 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+107 ys+201 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+107 ys+201 +BackgroundTrans , resources/pics/DisabledCheckBox.png

   Gui, Add, Text,xs+130 ys+217 , Force when 0 magazine
   Gui, Add, Checkbox, h12 w12 xs+27 ys+218 vSwapPrimary_ gSubmit_ALL,
   ;Gui, Add, Checkbox, h12 w12 xs+47 ys+218 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+47 ys+218 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+67 ys+218 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+67 ys+218 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+87 ys+218 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+87 ys+218 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   ;Gui, Add, Checkbox, h12 w12 xs+107 ys+218 disabled gSubmit_ALL,
   ;Gui, Add, Picture, xs+107 ys+218 +BackgroundTrans , resources/pics/DisabledCheckBox.png

   Gui, Add, Text,xs+130 ys+234 , During hotkey air reloads
   Gui, Add, Checkbox, h12 w12 xs+27 ys+235 vReloadPrimary_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+47 ys+235 vSupport1AR_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+67 ys+235 vSupport2AR_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+87 ys+235 vSupport3AR_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+107 ys+235 vSupport4AR_ gSubmit_ALL,

   Gui, Add, Text,xs+130 ys+251 , After air reloads
   Gui, Add, Checkbox, h12 w12 xs+27 ys+252 vReloadPrimary2_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+47 ys+252 vSupport1AfterReload_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+67 ys+252 vSupport2AfterReload_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+87 ys+252 vSupport3AfterReload_ gSubmit_ALL,
   Gui, Add, Checkbox, h12 w12 xs+107 ys+252 vSupport4AfterReload_ gSubmit_ALL,

   Gui, Add, Text,xs+130 ys+268 , Ledge jumps*
   Gui, Add, CheckBox, h12 w12 xs+27 ys+269 vPrimaryJump_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+47 ys+269 vSupport1Jump_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+67 ys+269 vSupport2Jump_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+87 ys+269 vSupport3Jump_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+107 ys+269 vSupport4Jump_ gSubmit_ALL,

   Gui, Add, Text,xs+130 ys+285 , MixedADS ADS shots*
   ;Gui, Add, CheckBox, h12 w12 xs+27 ys+286 Disabled,
   ;Gui, Add, Picture, xs+27 ys+286 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   Gui, Add, CheckBox, h12 w12 xs+47 ys+286 vSupport1ADS_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+67 ys+286 vSupport2ADS_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+87 ys+286 vSupport3ADS_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+107 ys+286 vSupport4ADS_ gSubmit_ALL,

   Gui, Add, Text,xs+130 ys+302 , Allow as next Support*
   ;Gui, Add, CheckBox, h12 w12 xs+27 ys+303 Disabled,
   ;Gui, Add, Picture, xs+27 ys+303 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   Gui, Add, CheckBox, h12 w12 xs+47 ys+303 vSupport1Next_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+67 ys+303 vSupport2Next_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+87 ys+303 vSupport3Next_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+107 ys+303 vSupport4Next_ gSubmit_ALL,

   Percent := Chr(37)
   Gui, Add, Text,xs+130 ys+319 , Monster
   Gui, Add, Text,xs+217 ys+319 , %Percent% HP*
   ;Gui, Add, CheckBox, h12 w12 xs+27 ys+320 Disabled,
   ;Gui, Add, Picture, xs+27 ys+320 +BackgroundTrans , resources/pics/DisabledCheckBox.png
   Gui, Add, CheckBox, h12 w12 xs+47 ys+320 vSupport1Cap_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+67 ys+320 vSupport2Cap_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+87 ys+320 vSupport3Cap_ gSubmit_ALL,
   Gui, Add, CheckBox, h12 w12 xs+107 ys+320 vSupport4Cap_ gSubmit_ALL,
   Gui, Font, s9 cBlack Normal
   Gui, Add, Combobox,xs+182 ys+317 w35 vHPswapPercent_ gSubmit_ALL, 50|40|30||25|20|15|10|5  

   Gui, Font, s11 cBlack Normal

   Gui, Add, Edit, xs+305 ys+182 w70 vPrimaryType_box Center ReadOnly, ;Type
   Gui, Add, Edit, xs+305 ys+212 w70 vSupport1Type_box Center ReadOnly, ;Type
   Gui, Add, Edit, xs+305 ys+242 w70 vSupport2Type_box Center ReadOnly, ;Type
   Gui, Add, Edit, xs+305 ys+272 w70 vSupport3Type_box Center ReadOnly, ;Type
   Gui, Add, Edit, xs+305 ys+302 w70 vSupport4Type_box Center ReadOnly, ;Type

   Gui, Add, Picture, x296 y191 +BackgroundTrans vSelectedPrimary_2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x300 y195 +BackgroundTrans gPrimarySelect, resources/pics/star(16x16).png
   Gui, Add, Picture, x296 y221 +BackgroundTrans vSelectedSupport1_2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x300 y225 +BackgroundTrans gSupport1Select, resources/pics/number-1(16x16).png
   Gui, Add, Picture, x296 y251 +BackgroundTrans vSelectedSupport2_2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x300 y255 +BackgroundTrans gSupport2Select, resources/pics/number-2(16x16).png
   Gui, Add, Picture, x296 y281 +BackgroundTrans vSelectedSupport3_2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x300 y285 +BackgroundTrans gSupport3Select, resources/pics/number-3(16x16).png
   Gui, Add, Picture, x296 y311 +BackgroundTrans vSelectedSupport4_2, resources/pics/selected(24x24).png
   Gui, Add, Picture, x300 y315 +BackgroundTrans gSupport4Select, resources/pics/number-4(16x16).png

   Gui, Add, Picture, xs+27 ys+201 +BackgroundTrans vDisableCheckBoxes, resources/pics/DisableCheckboxes.png

Gui, Tab, 5
;Tab 5: Controls
   Gui, Font, s12 cBlack Normal
   Gui, Add, Checkbox, xs+15 ys+40 r1 vEditMode_ gSubmit_ALL, Edit Mode

   Gui, Font, s10 cBlack Normal
   Gui, Add, Button, xs+253 ys+35 Center gRunJoyTest, Test Joystick Inputs
   Gui, Add, Button, xs+160 ys+35 Center gKeyList, AHK KeyList

   ;Keyboard Bindings
   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+63 w370 h149 Center, Your Keyboard Bindings

   ;Column 1A
   Gui, Font, s11 cBlack Normal
   
   Gui, Add, Edit, xs+20 ys+88 w60 Center hwndHED vkeyForward_ gSubmit_ALL, %keyForward_%
   Control_Colors("keyForward_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+93, Forward
   
   Gui, Add, Edit, xs+20 ys+117 w60 Center hwndHED vkeyLeft_ gSubmit_ALL, %keyLeft_%
   Control_Colors("keyLeft_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+122 , Left
   
   Gui, Add, Edit, xs+20 ys+146 w60 Center hwndHED vkeyBack_ gSubmit_ALL, %keyBack_%
   Control_Colors("keyBack_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+151 , Back

   Gui, Add, Edit, xs+20 ys+175 w60 Center hwndHED vkeyRight_ gSubmit_ALL, %keyRight_%
   Control_Colors("keyRight_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+180 , Right

   ;Column 2A
   Gui, Add, Edit, xs+145 ys+88 w60 Center hwndHED vkeyReload_ gSubmit_ALL, %keyReload_%
   Control_Colors("keyReload_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+207 ys+93 , Reload

   Gui, Add, Edit, xs+145 ys+117 w60 Center hwndHED vkeyRoll_ gSubmit_ALL, %keyRoll_%
   Control_Colors("keyRoll_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+207 ys+122 , Roll

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+145 ys+146 w60 Center hwndHED vkeyAmmoUp_ gSubmit_ALL, %keyAmmoUp_%
   Control_Colors("keyAmmoUp_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+142 r2 w60 , Ammo   Scroll Up

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+145 ys+175 w60 Center hwndHED vkeyAmmoDown_ gSubmit_ALL, %keyAmmoDown_%
   Control_Colors("keyAmmoDown_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+173 r2 w60 , Ammo   Scroll Down

   ;Column 3A
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+88 w60 Center hwndHED vkeyCamera_ gSubmit_ALL, %keyCamera_%
   Control_Colors("keyCamera_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+327 ys+86 r2 w50 , Reset Camera

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+117 w60 Center hwndHED vkeyFire_ gSubmit_ALL, %keyFire_%
   Control_Colors("keyFire_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+327 ys+122 , Fire

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+146 w60 Center hwndHED vkeyADS_ gSubmit_ALL, %keyADS_%
   Control_Colors("keyADS_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+327 ys+151 , ADS

   ;Text
   ;Gui, Font, s9 cgray Normal
   ;Gui, Add, Text,xs+265 ys+190 , (Match keyboard bindings to your in game settings)

   ;Script Commands
   Gui, Font, s12 cBlack Normal
   Gui, Add, GroupBox, xs+15 ys+200 w370 h142 Center, Script Hotkeys

   ;Column 1B
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+20 ys+225 w60 Center hwndHED vkeyEnable_ gSubmit_ALL, %keyEnable_%
   Control_Colors("keyEnable_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+230, Enable

   Gui, Add, Edit, xs+20 ys+254 w60 Center hwndHED vkeyDisable_ gSubmit_ALL, %keyDisable_%
   Control_Colors("keyDisable_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+259, Disable

   Gui, Add, Edit, xs+20 ys+283 w60 Center hwndHED vkeyExit_ gSubmit_ALL, %keyExit_%
   Control_Colors("keyExit_", "Set", "0xFFFFFF", "0x000000")
   Gui, Add, Text,xs+82 ys+288, Exit

   ;Column 2B
   Gui, Add, Edit, xs+145 ys+225 w60 Center hwndHED vkeyStop_ gSubmit_ALL, %keyStop_%
   Control_Colors("keyStop_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+223 r2 w50, AirReload and Stop
   
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+145 ys+254 w60 Center hwndHED vkeyEscShot_ gSubmit_ALL, %keyEscShot_%
   Control_Colors("keyEscShot_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+252 r2 w50, Escape Shot

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+145 ys+283 w60 Center hwndHED vkeyAmmoSync_ gSubmit_ALL, %keyAmmoSync_%
   Control_Colors("keyAmmoSync_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+281 r2 w50, Ammo Sync

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+145 ys+312 w60 Center hwndHED vkeyPrimary_ gSubmit_ALL, %keyPrimary_%
   Control_Colors("keyPrimary_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+207 ys+317, Primary

   ;Column 3B
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+225 w60 Center hwndHED vkeySupport1_ gSubmit_ALL, %keySupport1_%
   Control_Colors("keySupport1_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+327 ys+230, Support 1
   
   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+254 w60 Center hwndHED vkeySupport2_ gSubmit_ALL, %keySupport2_%
   Control_Colors("keySupport2_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+327 ys+259, Support 2

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+283 w60 Center hwndHED vkeySupport3_ gSubmit_ALL, %keySupport3_%
   Control_Colors("keySupport3_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+327 ys+288, Support 3

   Gui, Font, s11 cBlack Normal
   Gui, Add, Edit, xs+265 ys+312 w60 Center hwndHED vkeySupport4_ gSubmit_ALL, %keySupport4_%
   Control_Colors("keySupport4_", "Set", "0xFFFFFF", "0x000000")
   Gui, Font, s9 cBlack Normal
   Gui, Add, Text,xs+327 ys+317, Support 4

   ;OnMessage(0x0133, "SetFocusedBkColor")  ;Edits background of highlighted edit box
   
Gui, Font, s12 cBlack Normal
Gui, Tab  ; i.e. subsequently-added controls will not belong to the tab control.

;pics
Gui, Add, Picture, x365 y3 gCredits , resources/pics/RLHBG_Icon(45x30).png
Gui, Add, Picture, x367 y20 +BackgroundTrans vOrbRed , resources/pics/OrbRed.png
Gui, Add, Picture, x367 y20 +BackgroundTrans vOrbGreen , resources/pics/OrbGreen.png
GuiControl, Hide, vOrbRed
GuiControl, Hide, vOrbGreen
Gui, Add, Picture, x367 y20 +BackgroundTrans vOrb, resources/pics/OrbGray.png

;Bottom bar buttons
Gui, Add, Button, xs+0 ys+360 w70 gButtonSave, Save
Gui, Add, Button, xs+80 ys+360 w70 gButtonReload, Reload
Gui, Add, Button, xs+160 ys+360 gButtonDefaults, Load Defaults
Gui, Add, Checkbox, xs+290 ys+365 w120 r1 vKeepOnTop_ gSubmit_ALL, Keep on top

LoadSettings()
ReadSettings() 
ReadSettings() 
ReadSettings() ;For some reason, I must call this function multiple times to not lose reads (Hit GuiControl limit?) 

Gui, Submit, nohide ;Save the input from the user to each control's associated variable.
Gui, Show, X800 Y400, %ScriptName% Script Settings 
return  ; End of auto-execute section. The script is idle until the user does something.

GuiClose:
AHKPanic(1,0,0,1) ;Kill all scripts
2GuiClose:
ExitApp
Return

ButtonSave:
SoundPlay resources/sounds/smw_save_menu.wav
ApplySettings()
Return

ButtonReload:
AHKPanic(1,0,0,0) ;Kill all other scripts
PreciseSleep(17) ;Buffer to let other scripts close
Reload
Return

ButtonDefaults:
MsgBox,4100,Revert to defaults, 
(
Are you sure you want to revert ALL settings to the defaults? 
), 5  ; 5-second timeout.
IfMsgBox, No
    Return  ; User pressed the "No" button.
IfMsgBox, Timeout
    Return ; i.e. Assume "No" if it timed out.
; Otherwise, continue:
FileDelete, %settings%
FileDelete, %c_settings%
FileDelete, %a_settings%
FileDelete, %a_list%
Reload
Return

Credits:
Gui, credits:New
Gui, +Border +ToolWindow +AlwaysOnTop
Gui, Add, Picture, x20 y20 +BackgroundTrans gTSC_YT ToolTipBottom, resources/pics/TSClurk(120x120).png
Gui, Add, Picture, x3 y120 +BackgroundTrans , resources/pics/MoonBunnie(150x150).png
Gui, Add, Picture, x440 y0 +BackgroundTrans , resources/pics/RLHBG_Icon(70x50).png
Gui, Font, s22 cBlack Bold
Gui, Add, Text, x155 y10 , %ScriptName%
FileRead, Credits_text, resources/rlhbg_credits.txt
Gui, Font, s11 cBlack Normal
Gui, Add, Edit, x150 y50 h215 w370 ReadOnly vCredits_box HwndCredits_boxHwnd -E0x200,
Gui, Add, GroupBox, x148 y41 h226 w374,  ;border
GuiControl,,Credits_box,%Credits_text%
GuiControl, Focus, Credits_box
Control_Colors("Credits_box", "Set", "0xFFFFFF", "0x000000")
DllCall( "HideCaret" , "Ptr" , Credits_boxHwnd )
Gui, Show, w580 h300 X800 Y400, RLHBG Script Credits
Return

TSC_YT:
run, https://www.youtube.com/c/TSCspeedruns
Return

SMGButton:
MsgBox, 262144, SMG Info  , You can temporarily disable the Submachine gun by holding your assigned ADS keyboard binding or "L2" PS4 button (Joy7).   
Return

WalkRollButton:
MsgBox, 262144, Automatic Post Reload Actions  , You can delay these automatic post reload actions for 2seconds by holding the assigned ADS keyboard binding or the "L2" PS4 button (Joy7). You can cancel out of these automatic actions by pressing your assigned "Air Reload & Stop" script hotkey. 
Return

AmmoSetup:
run, AmmoSetup.png, resources/pics
Return

AmmoSyncMsg(){
MsgBox,262144,Ammo Sync Info, Ammo Syncs are required for any ammo control functions to work. They can be commanded via Hotkey or can be set up to happen automatically when entering maps. During an Ammo Sync, the script will scroll once through your ammo list in order to capture the position of each ammo type, the script will then use this information to calculate the most optimal scroll direction to get to any ammo type from the current ammo position. An Ammo Sync only needs to be done once per ammo pouch change.  
}

AmmoList:

MyArray := []
;if ammo_list exists, create msglist array
ifexist,%a_list%
{
   n:=0
   IniRead, aType, %a_list%, %n%, _
   While (aType<>"ERROR"){
      MyArray[n]:=aType
      n:=n+1
      IniRead, aType, %a_list%, %n%, _
   }
}
ifnotexist,%a_list%
{
   msgbox,262144,Error, No ammo lists have been synced!
   Return
}

;Concatenate code by "just me" https://www.autohotkey.com/boards/viewtopic.php?t=62356
Concat := ""
For Each, AmmoID In MyArray {
   If (Concat <> "") ; Concat is not empty, so add a line feed
      Concat .= "`n"
   Concat .= AmmoName(AmmoID) . "  (ID:" . AmmoID . ")"
  
}
MsgBox, 262144, My Synced Ammo List, %Concat%

Return

ResetAmmo:

   Switch AmmoSelect_ {
      
      case 1:
         GuiControl, Choose, PrimaryType_, 1
         GuiControl,, StartPrimary_, 0
         GuiControl,, ReloadPrimary2_, 0
         GuiControl,, SwapPrimary_, 0
         GuiControl,, PrimaryJump_, 0
         GuiControl,, ReloadPrimary_, 0

      case 2:
         GuiControl, Choose, Support1Type_, 1
         GuiControl, Choose, Support1Limit_, 1
         GuiControl, Choose, Support1Action_, 1
         GuiControl,, Support1Jump_, 0
         GuiControl,, Support1ADS_, 0
         GuiControl,, Support1AR_, 0
         GuiControl,, Support1Next_, 0
         GuiControl,, Support1Cap_, 0

      case 3:
         GuiControl, Choose, Support2Type_, 1
         GuiControl, Choose, Support2Limit_, 1
         GuiControl, Choose, Support2Action_, 1
         GuiControl,, Support2Jump_, 0
         GuiControl,, Support2ADS_, 0
         GuiControl,, Support2AR_, 0
         GuiControl,, Support2Next_, 0
         GuiControl,, Support2Cap_, 0

      case 4:
         GuiControl, Choose, Support3Type_, 1
         GuiControl, Choose, Support3Limit_, 1
         GuiControl, Choose, Support3Action_, 1
         GuiControl,, Support3Jump_, 0
         GuiControl,, Support3ADS_, 0
         GuiControl,, Support3AR_, 0
         GuiControl,, Support3Next_, 0
         GuiControl,, Support3Cap_, 0

      case 5:
         GuiControl, Choose, Support4Type_, 1
         GuiControl, Choose, Support4Limit_, 1
         GuiControl, Choose, Support4Action_, 1
         GuiControl,, Support4Jump_, 0
         GuiControl,, Support4ADS_, 0
         GuiControl,, Support4AR_, 0
         GuiControl,, Support4Next_, 0
         GuiControl,, Support4Cap_, 0

   }

Submit_All()
Return

SwapPriority:
MsgBox, 262144, Swap Priority  , Priority is dictated by: S1 > S2 > S3 > S4 > Primary 
Return

SwapInfo1:
MsgBox, 262144, Auto Swap Priority  , For swap conditions marked with asterisks, if target ammo type has an empty magazine, script will not auto swap to that type and instead will check the next priority available ammo. Priority: S1 > S2 > S3 > S4 > Primary 
Return

PrimarySelect:
GuiControl, Choose, AmmoSelect_, 1
Submit_All()
Return

Support1Select:
GuiControl, Choose, AmmoSelect_, 2
Submit_All()
Return

Support2Select:
GuiControl, Choose, AmmoSelect_, 3
Submit_All()
Return

Support3Select:
GuiControl, Choose, AmmoSelect_, 4
Submit_All()
Return

Support4Select:
GuiControl, Choose, AmmoSelect_, 5
Submit_All()
Return

KeyList:
Run AuthoHotKeyList.txt,resources/
Return

RunJoyTest:
Run _ps4joytest.ahk,resources/
Return

Submit_All(){
   Gui, Submit, NoHide ;Save the input from the user to each control's associated variable.

   ;Tab1: General
   UpdateTab1()
   
   ;Tab2: Timings
   UpdateTab2()

   ;Tab3: Crafting
   UpdateTab3()

   ;Tab4: Ammo+
   UpdateTab4()

   ;Tab5: Controls
   UpdateTab5()

   ;Keep On Top
   if KeepOnTop_
      Gui, +AlwaysOnTop
   else
      Gui, -AlwaysOnTop  

}

UpdateTab1(){

   ;Convert ComboBoxes into list number
   GuiControl, +AltSubmit, ADSmode_
   GuiControl, +AltSubmit, Rmode_
   GuiControl, +AltSubmit, HbMenu_

   if (ADSmode_=1){
      GuiControl,,ADSmode_Desc,Fires all shots without ADS. In this mode you are affected by snowballing deviation buildup. Shots in this mode will track camera facing direction (intended).
      GuiControl,Hide,SMG_
      GuiControl,Hide,SMGButton
      GuiControl,Hide,MixedADS_box
      GuiControl,Hide,MixedADS_text
      GuiControl,Hide,MixedADS_
      GuiControl,Hide,StartMixedInADS_
      
   }
   if (ADSmode_=2){
      GuiControl,,ADSmode_Desc,Aims Down Sights (ADS) only briefly while firing shots.
      GuiControl,Hide,SMG_
      GuiControl,Hide,SMGButton
      GuiControl,Hide,MixedADS_box
      GuiControl,Hide,MixedADS_text
      GuiControl,Hide,MixedADS_
      GuiControl,Hide,StartMixedInADS_

      GuiControl,Hide,CenterCamera_
   }
   if (ADSmode_=3){
      GuiControl,,ADSmode_Desc,A combination of noADS and Standard mode. Will only ADS at user defined intervals. This is to gain the benefits of noADS's speed while mitigating its deviation issues.
      GuiControl,Hide,SMG_
      GuiControl,Hide,SMGButton
      GuiControl,Show,MixedADS_box
      GuiControl,Show,MixedADS_text
      GuiControl,Show,MixedADS_
      GuiControl,Show,StartMixedInADS_

      if (MixedADS_=1)
         p=st
      else if (MixedADS_=2)
         p=nd
      else if (MixedADS_=3)
         p=rd
      else 
         p=th

      GuiControl,,MixedADS_box,%MixedADS_%%p% shot

      GuiControl,Hide,CenterCamera_
   }
   if (ADSmode_=4){
      GuiControl,,ADSmode_Desc,Always stays in ADS mode. Submachine gun mode only semi works on some rare ledges with a specific set of shot timings.
      GuiControl,Show,SMG_
      GuiControl,Hide,MixedADS_box
      GuiControl,Hide,MixedADS_text
      GuiControl,Hide,MixedADS_
      GuiControl,Hide,StartMixedInADS_

      GuiControl,Hide,CenterCamera_

      if (SMG_=1)
         GuiControl,Show,SMGButton
      else
         GuiControl,Hide,SMGButton
   }



   if (Rmode_=1)
       GuiControl,,Rmode_Desc,Will shoot the last shot in the current magazine early (no ADS) in order to get you back ontop of ledge.

   if (Rmode_=2){
      GuiControl,,Rmode_Desc,Inputs a reload at the correct frame during RLHBG which allows you to perform an aerial reload that lands you ontop of the ledge.
      if (ADSmode_=1)
         GuiControl,Show,CenterCamera_
      GuiControl,Show,AutoRoll_
      GuiControl,Show,AutoWalk_
   }
   else{
      GuiControl,Hide,CenterCamera_
      GuiControl,Hide,AutoRoll_
      GuiControl,Hide,AutoWalk_
   }

   if (AutoRoll_=1){
      GuiControl,,AutoWalk_,0
      GuiControl,Disable,AutoWalk_
      GuiControl,Show,WalkRollButton
   }
   else if (AutoWalk_=1){
      GuiControl,,AutoRoll_,0
      GuiControl,Disable,AutoRoll_
      GuiControl,Show,WalkRollButton
   }
   else{
      GuiControl,Enable,AutoWalk_
      GuiControl,Enable,AutoRoll_
      GuiControl,Hide,WalkRollButton
   }

}

UpdateTab2(){
   GuiControl,,nADS1st_box,%nADS1st_%cm
   if (nADScb_ = 0){
   GuiControl, Show, nADS_ 
   GuiControl, Hide, nADS2_   
   GuiControl,,nADS_box,%nADS_%cm

   }
   else{
   GuiControl, Hide, nADS_ 
   GuiControl, Show, nADS2_   
   GuiControl,,nADS_box,%nADS2_%f
   }

   GuiControl,,yADS1st_box,%yADS1st_%cm
   if (yADScb_ = 0){
   GuiControl, Show, yADS_ 
   GuiControl, Hide, yADS2_   
   GuiControl,,yADS_box,%yADS_%cm

   }
   else{
   GuiControl, Hide, yADS_ 
   GuiControl, Show, yADS2_   
   GuiControl,,yADS_box,%yADS2_%f
   }

   GuiControl,,airT_box,%airT_%f
}

UpdateTab3(){
   if (DisableCrafting_){
      GuiControl, Disable, AutoCraftAlways_
      GuiControl, Disable, HbMenu_
      GuiControl, Disable, Slot1_
      GuiControl, Disable, Slot2_
      GuiControl, Disable, Slot3_
      GuiControl, Disable, CraftMagSize_
   }
   Else {
      GuiControl, Enable, AutoCraftAlways_
      GuiControl, Enable, HbMenu_
      GuiControl, Enable, Slot1_
      GuiControl, Enable, Slot2_
      GuiControl, Enable, Slot3_
      GuiControl, Enable, CraftMagSize_
   }
}
;Ammo+
UpdateTab4(){
   if (DisableAmmoPlus_){
      GuiControl, Disable, PrimaryType_
      GuiControl, Disable, AutoSync_
      GuiControl, Disable, StartPrimary_
      GuiControl, Disable, PrimaryJump_
      GuiControl, Disable, ReturnPrimary_
      GuiControl, Disable, ReloadPrimary_
      GuiControl, Disable, ReloadPrimary2_
      GuiControl, Disable, SwapPrimary_
      GuiControl, Disable, AmmoSelect_
      GuiControl, Disable, Support1Type_
      GuiControl, Disable, Support2Type_
      GuiControl, Disable, Support3Type_
      GuiControl, Disable, Support4Type_
      GuiControl, Disable, Support1AfterReload_
      GuiControl, Disable, Support2AfterReload_
      GuiControl, Disable, Support3AfterReload_
      GuiControl, Disable, Support4AfterReload_
      GuiControl, Disable, Support1Jump_
      GuiControl, Disable, Support2Jump_
      GuiControl, Disable, Support3Jump_
      GuiControl, Disable, Support4Jump_
      GuiControl, Disable, Support1ADS_
      GuiControl, Disable, Support2ADS_
      GuiControl, Disable, Support3ADS_
      GuiControl, Disable, Support4ADS_
      GuiControl, Disable, Support1AR_
      GuiControl, Disable, Support2AR_
      GuiControl, Disable, Support3AR_
      GuiControl, Disable, Support4AR_
      GuiControl, Disable, Support1Next_
      GuiControl, Disable, Support2Next_
      GuiControl, Disable, Support3Next_
      GuiControl, Disable, Support4Next_
      GuiControl, Disable, Support1Cap_
      GuiControl, Disable, Support2Cap_
      GuiControl, Disable, Support3Cap_
      GuiControl, Disable, Support4Cap_
      GuiControl, Disable, HPswapPercent_
      GuiControl, Disable, Support1Limit_
      GuiControl, Disable, Support2Limit_
      GuiControl, Disable, Support3Limit_
      GuiControl, Disable, Support4Limit_
      GuiControl, Disable, Support1Action_
      GuiControl, Disable, Support2Action_
      GuiControl, Disable, Support3Action_
      GuiControl, Disable, Support4Action_
      GuiControl, Hide, ResetAmmo
      GuiControl, Show, DisableCheckBoxes
   }
   Else {
      GuiControl, Enable, PrimaryType_
      GuiControl, Enable, AutoSync_
      GuiControl, Enable, StartPrimary_
      GuiControl, Enable, PrimaryJump_
      GuiControl, Enable, ReturnPrimary_
      GuiControl, Enable, ReloadPrimary_
      GuiControl, Enable, ReloadPrimary2_
      GuiControl, Enable, SwapPrimary_
      GuiControl, Enable, AmmoSelect_
      GuiControl, Enable, Support1Type_
      GuiControl, Enable, Support2Type_
      GuiControl, Enable, Support3Type_
      GuiControl, Enable, Support4Type_
      GuiControl, Enable, Support1AfterReload_
      GuiControl, Enable, Support2AfterReload_
      GuiControl, Enable, Support3AfterReload_
      GuiControl, Enable, Support4AfterReload_
      GuiControl, Enable, Support1Jump_
      GuiControl, Enable, Support2Jump_
      GuiControl, Enable, Support3Jump_
      GuiControl, Enable, Support4Jump_
      GuiControl, Enable, Support1ADS_
      GuiControl, Enable, Support2ADS_
      GuiControl, Enable, Support3ADS_
      GuiControl, Enable, Support4ADS_
      GuiControl, Enable, Support1AR_
      GuiControl, Enable, Support2AR_
      GuiControl, Enable, Support3AR_
      GuiControl, Enable, Support4AR_
      GuiControl, Enable, Support1Cap_
      GuiControl, Enable, Support2Cap_
      GuiControl, Enable, Support3Cap_
      GuiControl, Enable, Support4Cap_
      GuiControl, Enable, HPswapPercent_
      GuiControl, Enable, Support1Next_
      GuiControl, Enable, Support2Next_
      GuiControl, Enable, Support3Next_
      GuiControl, Enable, Support4Next_
      GuiControl, Enable, Support1Limit_
      GuiControl, Enable, Support2Limit_
      GuiControl, Enable, Support3Limit_
      GuiControl, Enable, Support4Limit_
      GuiControl, Enable, Support1Action_
      GuiControl, Enable, Support2Action_
      GuiControl, Enable, Support3Action_
      GuiControl, Enable, Support4Action_
      GuiControl, Show, ResetAmmo
      GuiControl, Hide, DisableCheckBoxes
   }

   GuiControl, +AltSubmit, AmmoSelect_

   GuiControl, +AltSubmit, Support1Action_ 
   GuiControl, +AltSubmit, Support2Action_
   GuiControl, +AltSubmit, Support3Action_
   GuiControl, +AltSubmit, Support4Action_

   if (ReloadPrimary_=1){
      GuiControl, Disable, Support1AR_
      GuiControl,, Support1AR_,0
      GuiControl, Disable, Support2AR_
      GuiControl,, Support2AR_,0
      GuiControl, Disable, Support3AR_
      GuiControl,, Support3AR_,0
      GuiControl, Disable, Support4AR_
      GuiControl,, Support4AR_,0
   }
   else if(Support1AR_=1){
      GuiControl, Disable, ReloadPrimary_
      GuiControl,, ReloadPrimary_,0
      GuiControl, Disable, Support2AR_
      GuiControl,, Support2AR_,0
      GuiControl, Disable, Support3AR_
      GuiControl,, Support3AR_,0
      GuiControl, Disable, Support4AR_
      GuiControl,, Support4AR_,0
   }
   else if(Support2AR_=1){
      GuiControl, Disable, ReloadPrimary_
      GuiControl,, ReloadPrimary_,0
      GuiControl, Disable, Support1AR_
      GuiControl,, Support1AR_,0
      GuiControl, Disable, Support3AR_
      GuiControl,, Support3AR_,0
      GuiControl, Disable, Support4AR_
      GuiControl,, Support4AR_,0
   }
   else if(Support3AR_=1){
      GuiControl, Disable, ReloadPrimary_
      GuiControl,, ReloadPrimary_,0
      GuiControl, Disable, Support1AR_
      GuiControl,, Support1AR_,0
      GuiControl, Disable, Support2AR_
      GuiControl,, Support2AR_,0
      GuiControl, Disable, Support4AR_
      GuiControl,, Support4AR_,0
   }
   else if(Support4AR_=1){
      GuiControl, Disable, ReloadPrimary_
      GuiControl,, ReloadPrimary_,0
      GuiControl, Disable, Support1AR_
      GuiControl,, Support1AR_,0
      GuiControl, Disable, Support2AR_
      GuiControl,, Support2AR_,0
      GuiControl, Disable, Support3AR_
      GuiControl,, Support3AR_,0
   }

   if (ReloadPrimary2_=1){
      GuiControl, Disable, Support1AfterReload_
      GuiControl,, Support1AfterReload_,0
      GuiControl, Disable, Support2AfterReload_
      GuiControl,, Support2AfterReload_,0
      GuiControl, Disable, Support3AfterReload_
      GuiControl,, Support3AfterReload_,0
      GuiControl, Disable, Support4AfterReload_
      GuiControl,, Support4AfterReload_,0
   }
   else if(Support1AfterReload_=1){
      GuiControl, Disable, ReloadPrimary2_
      GuiControl,, ReloadPrimary2_,0
      GuiControl, Disable, Support2AfterReload_
      GuiControl,, Support2AfterReload_,0
      GuiControl, Disable, Support3AfterReload_
      GuiControl,, Support3AfterReload_,0
      GuiControl, Disable, Support4AfterReload_
      GuiControl,, Support4AfterReload_,0
   }
   else if(Support2AfterReload_=1){
      GuiControl, Disable, ReloadPrimary2_
      GuiControl,, ReloadPrimary2_,0
      GuiControl, Disable, Support1AfterReload_
      GuiControl,, Support1AfterReload_,0
      GuiControl, Disable, Support3AfterReload_
      GuiControl,, Support3AfterReload_,0
      GuiControl, Disable, Support4AfterReload_
      GuiControl,, Support4AfterReload_,0
   }
   else if(Support3AfterReload_=1){
      GuiControl, Disable, ReloadPrimary2_
      GuiControl,, ReloadPrimary2_,0
      GuiControl, Disable, Support1AfterReload_
      GuiControl,, Support1AfterReload_,0
      GuiControl, Disable, Support2AfterReload_
      GuiControl,, Support2AfterReload_,0
      GuiControl, Disable, Support4AfterReload_
      GuiControl,, Support4AfterReload_,0
   }
   else if(Support4AfterReload_=1){
      GuiControl, Disable, ReloadPrimary2_
      GuiControl,, ReloadPrimary2_,0
      GuiControl, Disable, Support1AfterReload_
      GuiControl,, Support1AfterReload_,0
      GuiControl, Disable, Support2AfterReload_
      GuiControl,, Support2AfterReload_,0
      GuiControl, Disable, Support3AfterReload_
      GuiControl,, Support3AfterReload_,0
   }

   GuiControl, +AltSubmit, HPswapPercent_

   Switch AmmoSelect_ {
      
      case 1:
         ;Icon
         GuiControl,Show,PrimaryIcon
         GuiControl,Hide,Support1Icon
         GuiControl,Hide,Support2Icon
         GuiControl,Hide,Support3Icon
         GuiControl,Hide,Support4Icon

         ;Type
         GuiControl,Show,PrimaryType_
         GuiControl,Hide,Support1Type_
         GuiControl,Hide,Support2Type_
         GuiControl,Hide,Support3Type_
         GuiControl,Hide,Support4Type_

         ;Hotkey
         GuiControl,Show,Primary_box
         GuiControl,Hide,Support1_box
         GuiControl,Hide,Support2_box
         GuiControl,Hide,Support3_box
         GuiControl,Hide,Support4_box

         ;Limit
         GuiControl,Show,PrimaryLimit_
         GuiControl,Hide,Support1Limit_
         GuiControl,Hide,Support2Limit_
         GuiControl,Hide,Support3Limit_
         GuiControl,Hide,Support4Limit_

         ;Action
         GuiControl,Show,PrimaryAction_
         GuiControl,Hide,Support1Action_
         GuiControl,Hide,Support2Action_
         GuiControl,Hide,Support3Action_
         GuiControl,Hide,Support4Action_

         ;Selected Highlight
         GuiControl,Show,SelectedPrimary
         GuiControl,Hide,SelectedSupport1
         GuiControl,Hide,SelectedSupport2
         GuiControl,Hide,SelectedSupport3
         GuiControl,Hide,SelectedSupport4

         ;Selected Highlight_2
         GuiControl,Show,SelectedPrimary_2
         GuiControl,Hide,SelectedSupport1_2
         GuiControl,Hide,SelectedSupport2_2
         GuiControl,Hide,SelectedSupport3_2
         GuiControl,Hide,SelectedSupport4_2

         ;Checkbox Highlight
         GuiControl,Show,HighlightPrimary
         GuiControl,Hide,HighlightSupport1
         GuiControl,Hide,HighlightSupport2
         GuiControl,Hide,HighlightSupport3
         GuiControl,Hide,HighlightSupport4

      case 2:
         ;Icon
         GuiControl,Hide,PrimaryIcon
         GuiControl,Show,Support1Icon
         GuiControl,Hide,Support2Icon
         GuiControl,Hide,Support3Icon
         GuiControl,Hide,Support4Icon

         ;Type
         GuiControl,Hide,PrimaryType_
         GuiControl,Show,Support1Type_
         GuiControl,Hide,Support2Type_
         GuiControl,Hide,Support3Type_
         GuiControl,Hide,Support4Type_

         ;Hotkey
         GuiControl,Hide,Primary_box
         GuiControl,Show,Support1_box
         GuiControl,Hide,Support2_box
         GuiControl,Hide,Support3_box
         GuiControl,Hide,Support4_box

         ;Limit
         GuiControl,Hide,PrimaryLimit_
         GuiControl,Show,Support1Limit_
         GuiControl,Hide,Support2Limit_
         GuiControl,Hide,Support3Limit_
         GuiControl,Hide,Support4Limit_

         ;Action
         GuiControl,Hide,PrimaryAction_
         GuiControl,Show,Support1Action_
         GuiControl,Hide,Support2Action_
         GuiControl,Hide,Support3Action_
         GuiControl,Hide,Support4Action_

         ;Selected Highlight
         GuiControl,Hide,SelectedPrimary
         GuiControl,Show,SelectedSupport1
         GuiControl,Hide,SelectedSupport2
         GuiControl,Hide,SelectedSupport3
         GuiControl,Hide,SelectedSupport4

         ;Selected Highlight_2
         GuiControl,Hide,SelectedPrimary_2
         GuiControl,Show,SelectedSupport1_2
         GuiControl,Hide,SelectedSupport2_2
         GuiControl,Hide,SelectedSupport3_2
         GuiControl,Hide,SelectedSupport4_2

         ;Checkbox Highlight
         GuiControl,Hide,HighlightPrimary
         GuiControl,Show,HighlightSupport1
         GuiControl,Hide,HighlightSupport2
         GuiControl,Hide,HighlightSupport3
         GuiControl,Hide,HighlightSupport4

      case 3:
         ;Icon
         GuiControl,Hide,PrimaryIcon
         GuiControl,Hide,Support1Icon
         GuiControl,Show,Support2Icon
         GuiControl,Hide,Support3Icon
         GuiControl,Hide,Support4Icon

         ;Type
         GuiControl,Hide,PrimaryType_
         GuiControl,Hide,Support1Type_
         GuiControl,Show,Support2Type_
         GuiControl,Hide,Support3Type_
         GuiControl,Hide,Support4Type_

         ;Hotkey
         GuiControl,Hide,Primary_box
         GuiControl,Hide,Support1_box
         GuiControl,Show,Support2_box
         GuiControl,Hide,Support3_box
         GuiControl,Hide,Support4_box

         ;Limit
         GuiControl,Hide,PrimaryLimit_
         GuiControl,Hide,Support1Limit_
         GuiControl,Show,Support2Limit_
         GuiControl,Hide,Support3Limit_
         GuiControl,Hide,Support4Limit_

         ;Action
         GuiControl,Hide,PrimaryAction_
         GuiControl,Hide,Support1Action_
         GuiControl,Show,Support2Action_
         GuiControl,Hide,Support3Action_
         GuiControl,Hide,Support4Action_

         ;Selected Highlight
         GuiControl,Hide,SelectedPrimary
         GuiControl,Hide,SelectedSupport1
         GuiControl,Show,SelectedSupport2
         GuiControl,Hide,SelectedSupport3
         GuiControl,Hide,SelectedSupport4

         ;Selected Highlight_2
         GuiControl,Hide,SelectedPrimary_2
         GuiControl,Hide,SelectedSupport1_2
         GuiControl,Show,SelectedSupport2_2
         GuiControl,Hide,SelectedSupport3_2
         GuiControl,Hide,SelectedSupport4_2

         ;Checkbox Highlight
         GuiControl,Hide,HighlightPrimary
         GuiControl,Hide,HighlightSupport1
         GuiControl,Show,HighlightSupport2
         GuiControl,Hide,HighlightSupport3
         GuiControl,Hide,HighlightSupport4

      case 4:
         ;Icon
         GuiControl,Hide,PrimaryIcon
         GuiControl,Hide,Support1Icon
         GuiControl,Hide,Support2Icon
         GuiControl,Show,Support3Icon
         GuiControl,Hide,Support4Icon

         ;Type
         GuiControl,Hide,PrimaryType_
         GuiControl,Hide,Support1Type_
         GuiControl,Hide,Support2Type_
         GuiControl,Show,Support3Type_
         GuiControl,Hide,Support4Type_

         ;Hotkey
         GuiControl,Hide,Primary_box
         GuiControl,Hide,Support1_box
         GuiControl,Hide,Support2_box
         GuiControl,Show,Support3_box
         GuiControl,Hide,Support4_box

         ;Limit
         GuiControl,Hide,PrimaryLimit_
         GuiControl,Hide,Support1Limit_
         GuiControl,Hide,Support2Limit_
         GuiControl,Show,Support3Limit_
         GuiControl,Hide,Support4Limit_

         ;Action
         GuiControl,Hide,PrimaryAction_
         GuiControl,Hide,Support1Action_
         GuiControl,Hide,Support2Action_
         GuiControl,Show,Support3Action_
         GuiControl,Hide,Support4Action_

         ;Selected Highlight
         GuiControl,Hide,SelectedPrimary
         GuiControl,Hide,SelectedSupport1
         GuiControl,Hide,SelectedSupport2
         GuiControl,Show,SelectedSupport3
         GuiControl,Hide,SelectedSupport4

         ;Selected Highlight_2
         GuiControl,Hide,SelectedPrimary_2
         GuiControl,Hide,SelectedSupport1_2
         GuiControl,Hide,SelectedSupport2_2
         GuiControl,Show,SelectedSupport3_2
         GuiControl,Hide,SelectedSupport4_2

         ;Checkbox Highlight
         GuiControl,Hide,HighlightPrimary
         GuiControl,Hide,HighlightSupport1
         GuiControl,Hide,HighlightSupport2
         GuiControl,Show,HighlightSupport3
         GuiControl,Hide,HighlightSupport4

      case 5:
         ;Icon
         GuiControl,Hide,PrimaryIcon
         GuiControl,Hide,Support1Icon
         GuiControl,Hide,Support2Icon
         GuiControl,Hide,Support3Icon
         GuiControl,Show,Support4Icon

         ;Type
         GuiControl,Hide,PrimaryType_
         GuiControl,Hide,Support1Type_
         GuiControl,Hide,Support2Type_
         GuiControl,Hide,Support3Type_
         GuiControl,Show,Support4Type_

         ;Hotkey
         GuiControl,Hide,Primary_box
         GuiControl,Hide,Support1_box
         GuiControl,Hide,Support2_box
         GuiControl,Hide,Support3_box
         GuiControl,Show,Support4_box

         ;Limit
         GuiControl,Hide,PrimaryLimit_
         GuiControl,Hide,Support1Limit_
         GuiControl,Hide,Support2Limit_
         GuiControl,Hide,Support3Limit_
         GuiControl,Show,Support4Limit_

         ;Action
         GuiControl,Hide,PrimaryAction_
         GuiControl,Hide,Support1Action_
         GuiControl,Hide,Support2Action_
         GuiControl,Hide,Support3Action_
         GuiControl,Show,Support4Action_

         ;Selected Highlight
         GuiControl,Hide,SelectedPrimary
         GuiControl,Hide,SelectedSupport1
         GuiControl,Hide,SelectedSupport2
         GuiControl,Hide,SelectedSupport3
         GuiControl,Show,SelectedSupport4

         ;Selected Highlight_2
         GuiControl,Hide,SelectedPrimary_2
         GuiControl,Hide,SelectedSupport1_2
         GuiControl,Hide,SelectedSupport2_2
         GuiControl,Hide,SelectedSupport3_2
         GuiControl,Show,SelectedSupport4_2

         ;Checkbox Highlight
         GuiControl,Hide,HighlightPrimary
         GuiControl,Hide,HighlightSupport1
         GuiControl,Hide,HighlightSupport2
         GuiControl,Hide,HighlightSupport3
         GuiControl,Show,HighlightSupport4
   }

   GuiControl,,AmmoSync_box,%keyAmmoSync_%

   ;Ammo+ Hotkeys
   GuiControl,,Primary_box,%keyPrimary_%
   GuiControl,,Support1_box,%keySupport1_%
   GuiControl,,Support2_box,%keySupport2_%
   GuiControl,,Support3_box,%keySupport3_%
   GuiControl,,Support4_box,%keySupport4_%

   ;Ammo+ Types
   GuiControl,,PrimaryType_box,%PrimaryType_%
   GuiControl,,Support1Type_box,%Support1Type_%
   GuiControl,,Support2Type_box,%Support2Type_%
   GuiControl,,Support3Type_box,%Support3Type_%
   GuiControl,,Support4Type_box,%Support4Type_%

}

UpdateTab5(){
   if (EditMode_){
      GuiControl, Enable, keyForward_
      GuiControl, Enable, keyBack_
      GuiControl, Enable, keyLeft_
      GuiControl, Enable, keyRight_
      GuiControl, Enable, keyReload_
      GuiControl, Enable, keyRoll_
      GuiControl, Enable, keyAmmoUp_
      GuiControl, Enable, keyAmmoDown_
      GuiControl, Enable, keyCamera_
      GuiControl, Enable, keyFire_
      GuiControl, Enable, keyADS_
      GuiControl, Enable, keyEnable_
      GuiControl, Enable, keyDisable_
      GuiControl, Enable, keyExit_
      GuiControl, Enable, keyStop_
      GuiControl, Enable, keyEscShot_
      GuiControl, Enable, keyAmmoSync_
      GuiControl, Enable, keyPrimary_
      GuiControl, Enable, keySupport1_
      GuiControl, Enable, keySupport2_
      GuiControl, Enable, keySupport3_
      GuiControl, Enable, keySupport4_
   }
   Else {
      GuiControl, Disable, keyForward_
      GuiControl, Disable, keyBack_
      GuiControl, Disable, keyLeft_
      GuiControl, Disable, keyRight_
      GuiControl, Disable, keyReload_
      GuiControl, Disable, keyRoll_
      GuiControl, Disable, keyAmmoUp_
      GuiControl, Disable, keyAmmoDown_
      GuiControl, Disable, keyCamera_
      GuiControl, Disable, keyFire_
      GuiControl, Disable, keyADS_
      GuiControl, Disable, keyEnable_
      GuiControl, Disable, keyDisable_
      GuiControl, Disable, keyExit_
      GuiControl, Disable, keyStop_
      GuiControl, Disable, keyEscShot_
      GuiControl, Disable, keyAmmoSync_
      GuiControl, Disable, keyPrimary_
      GuiControl, Disable, keySupport1_
      GuiControl, Disable, keySupport2_
      GuiControl, Disable, keySupport3_
      GuiControl, Disable, keySupport4_
   }
}

OrbColor(mode="") {
   switch mode {
      case "Red":
      Menu, Tray, Icon, resources/pics/AmmoRed.ico,, 1        
      GuiControl, Hide, OrbGreen
      GuiControl, Show, OrbRed
      GuiControl, Hide, Orb
      case "Green":
      Menu, Tray, Icon, resources/pics/AmmoGreen.ico,, 1 
      GuiControl, Show, OrbGreen
      GuiControl, Hide, OrbRed
      GuiControl, Hide, Orb
      default: 
   }
}
;;=========================[Generate/Load/Read/Apply Settings]============================

;Load settings from file(s) 
LoadSettings(){

   ;If settings file does not exist, create one with defaults in main file.
   ifnotexist,%settings%
   {
   ;Tab 1: General
   Iniwrite, %ADSmode%, %settings%, ADSmode: , _
   Iniwrite, %SMG%, %settings%, SMG: , _
   Iniwrite, %MixedADS%, %settings%, MixedADS: , _
   Iniwrite, %StartMixedInADS%, %settings%, StartMixedInADS: , _
   Iniwrite, %Rmode%, %settings%, Rmode: , _
   Iniwrite, %CenterCamera%, %settings%, CenterCamera: , _
   Iniwrite, %AutoRoll%, %settings%, AutoRoll: , _
   Iniwrite, %AutoWalk%, %settings%, AutoWalk: , _

   ;Tab 2: Timings
   Iniwrite, %nADS1st%, %settings%, nADS1st: , _
   Iniwrite, %nADS%, %settings%, nADS: , _
   Iniwrite, %nADS2%, %settings%, nADS2: , _
   Iniwrite, %nADScb%, %settings%, nADScb: , _
   Iniwrite, %yADS1st%, %settings%, yADS1st: , _
   Iniwrite, %yADS%, %settings%, yADS: , _
   Iniwrite, %yADScb%, %settings%, yADScb: , _
   Iniwrite, %airT%, %settings%, airT: , _

   ;Tab 3: Crafting
   Iniwrite, %DisableCrafting%, %settings%, DisableCrafting: , _
   Iniwrite, %AutoCraftAlways%, %settings%, AutoCraftAlways: , _
   Iniwrite, %CraftMagSize%, %settings%, CraftMagSize: , _

   ;Tab 4: Ammo+
   Iniwrite, %DisableAmmoPlus%, %settings%, DisableAmmoPlus: , _
   Iniwrite, %AutoSync%, %settings%, AutoSync: , _
   ;
   Iniwrite, %PrimaryType%, %settings%, PrimaryType: , _
   Iniwrite, %StartPrimary%, %settings%, StartPrimary: , _
   Iniwrite, %PrimaryJump%, %settings%, PrimaryJump: , _
   Iniwrite, %ReturnPrimary%, %settings%, ReturnPrimary: , _
   Iniwrite, %ReloadPrimary%, %settings%, ReloadPrimary: , _
   Iniwrite, %ReloadPrimary2%, %settings%, ReloadPrimary2: , _
   Iniwrite, %SwapPrimary%, %settings%, SwapPrimary: , _
   ;
   Iniwrite, %AmmoSelect%, %settings%, AmmoSelect: , _
   Iniwrite, %Support1Type%, %settings%, Support1Type: , _
   Iniwrite, %Support2Type%, %settings%, Support2Type: , _
   Iniwrite, %Support3Type%, %settings%, Support3Type: , _
   Iniwrite, %Support4Type%, %settings%, Support4Type: , _
   Iniwrite, %Support1AfterReload%, %settings%, Support1AfterReload: , _
   Iniwrite, %Support2AfterReload%, %settings%, Support2AfterReload: , _
   Iniwrite, %Support3AfterReload%, %settings%, Support3AfterReload: , _
   Iniwrite, %Support4AfterReload%, %settings%, Support4AfterReload: , _
   Iniwrite, %Support1Jump%, %settings%, Support1Jump: , _
   Iniwrite, %Support2Jump%, %settings%, Support2Jump: , _
   Iniwrite, %Support3Jump%, %settings%, Support3Jump: , _
   Iniwrite, %Support4Jump%, %settings%, Support4Jump: , _
   Iniwrite, %Support1ADS%, %settings%, Support1ADS: , _
   Iniwrite, %Support2ADS%, %settings%, Support2ADS: , _
   Iniwrite, %Support3ADS%, %settings%, Support3ADS: , _
   Iniwrite, %Support4ADS%, %settings%, Support4ADS: , _
   Iniwrite, %Support1AR%, %settings%, Support1AR: , _
   Iniwrite, %Support2AR%, %settings%, Support2AR: , _
   Iniwrite, %Support3AR%, %settings%, Support3AR: , _
   Iniwrite, %Support4AR%, %settings%, Support4AR: , _
   Iniwrite, %Support1Next%, %settings%, Support1Next: , _
   Iniwrite, %Support2Next%, %settings%, Support2Next: , _
   Iniwrite, %Support3Next%, %settings%, Support3Next: , _
   Iniwrite, %Support4Next%, %settings%, Support4Next: , _
   Iniwrite, %Support1Cap%, %settings%, Support1Cap: , _
   Iniwrite, %Support2Cap%, %settings%, Support2Cap: , _
   Iniwrite, %Support3Cap%, %settings%, Support3Cap: , _
   Iniwrite, %Support4Cap%, %settings%, Support4Cap: , _
   Iniwrite, %HPswapPercent%, %settings%, HPswapPercent: , _

   Iniwrite, %Support1Limit%, %settings%, Support1Limit: , _
   Iniwrite, %Support2Limit%, %settings%, Support2Limit: , _
   Iniwrite, %Support3Limit%, %settings%, Support3Limit: , _
   Iniwrite, %Support4Limit%, %settings%, Support4Limit: , _
   Iniwrite, %Support1Action%, %settings%, Support1Action: , _
   Iniwrite, %Support2Action%, %settings%, Support2Action: , _
   Iniwrite, %Support3Action%, %settings%, Support3Action: , _
   Iniwrite, %Support4Action%, %settings%, Support4Action: , _

   ;Tab 5: Controls
   Iniwrite, %keyForward%, %settings%, keyForward: , _
   Iniwrite, %keyBack%, %settings%, keyBack: , _
   Iniwrite, %keyLeft%, %settings%, keyLeft: , _
   Iniwrite, %keyRight%, %settings%, keyRight: , _
   Iniwrite, %keyReload%, %settings%, keyReload: , _
   Iniwrite, %keyRoll%, %settings%, keyRoll: , _
   Iniwrite, %keyCamera%, %settings%, keyCamera: , _
   Iniwrite, %keyFire%, %settings%, keyFire: , _
   Iniwrite, %keyADS%, %settings%, keyADS: , _
   ;
   Iniwrite, %keyEnable%, %settings%, keyEnable: , _
   Iniwrite, %keyDisable%, %settings%, keyDisable: , _
   Iniwrite, %keyExit%, %settings%, keyExit: , _
   Iniwrite, %keyStop%, %settings%, keyStop: , _
   Iniwrite, %keyEscShot%, %settings%, keyEscShot: , _
   Iniwrite, %keyAmmoSync% , %settings%, keyAmmoSync: , _
   Iniwrite, %keyPrimary% , %settings%, keyPrimary: , _
   Iniwrite, %keySupport1% , %settings%, keySupport1: , _
   Iniwrite, %keySupport2% , %settings%, keySupport2: , _
   Iniwrite, %keySupport3% , %settings%, keySupport3: , _
   Iniwrite, %keySupport4% , %settings%, keySupport4: , _

   ;Other:
   Iniwrite, 1, %settings%, KeepOnTop: , _

   }

   ;Create Default Settings for ammo+
   ifnotexist,%a_settings%
   {
   Iniwrite, -1, %a_settings%, GotoType: , _
   Iniwrite, %keyAmmoUp% , %a_settings%, keyAmmoUp: , _
   Iniwrite, %keyAmmoDown% , %a_settings%, keyAmmoDown: , _
   }

   ;Update code with settings from ini(s)
   ;Tab 1: General
   IniRead, ADSmode, %settings%, ADSmode: , _
   IniRead, SMG, %settings%, SMG: , _
   IniRead, MixedADS, %settings%, MixedADS: , _
   IniRead, StartMixedInADS, %settings%, StartMixedInADS: , _
   IniRead, Rmode, %settings%, Rmode: , _
   IniRead, CenterCamera, %settings%, CenterCamera: , _
   IniRead, AutoRoll, %settings%, AutoRoll: , _
   IniRead, AutoWalk, %settings%, AutoWalk: , _

   ;Tab 2: Timings
   IniRead, nADS1st, %settings%, nADS1st: , _
   IniRead, nADS, %settings%, nADS: , _
   IniRead, nADS2, %settings%, nADS2: , _
   IniRead, nADScb, %settings%, nADScb: , _
   IniRead, yADS1st, %settings%, yADS1st: , _
   IniRead, yADS, %settings%, yADS: , _
   IniRead, yADScb, %settings%, yADScb: , _
   IniRead, airT, %settings%, airT: , _

   ;Tab 3: Crafting
   IniRead, DisableCrafting, %settings%, DisableCrafting: , _
   IniRead, AutoCraftAlways, %settings%, AutoCraftAlways: , _
   IniRead, CraftMagSize, %settings%, CraftMagSize: , _

   ;Tab 4: Ammo+
   IniRead, DisableAmmoPlus, %settings%, DisableAmmoPlus: , _
   IniRead, AutoSync, %settings%, AutoSync: , _
   IniRead, PrimaryType, %settings%, PrimaryType: , _
   IniRead, StartPrimary, %settings%, StartPrimary: , _
   IniRead, PrimaryJump, %settings%, PrimaryJump: , _
   IniRead, ReturnPrimary, %settings%, ReturnPrimary: , _
   IniRead, ReloadPrimary, %settings%, ReloadPrimary: , _
   IniRead, ReloadPrimary2, %settings%, ReloadPrimary2: , _
   IniRead, SwapPrimary, %settings%, SwapPrimary: , _
   IniRead, AmmoSelect, %settings%, AmmoSelect: , _
   IniRead, Support1Type, %settings%, Support1Type: , _
   IniRead, Support2Type, %settings%, Support2Type: , _
   IniRead, Support3Type, %settings%, Support3Type: , _
   IniRead, Support4Type, %settings%, Support4Type: , _
   IniRead, Support1AfterReload, %settings%, Support1AfterReload: , _
   IniRead, Support2AfterReload, %settings%, Support2AfterReload: , _
   IniRead, Support3AfterReload, %settings%, Support3AfterReload: , _
   IniRead, Support4AfterReload, %settings%, Support4AfterReload: , _
   IniRead, Support1Jump, %settings%, Support1Jump: , _
   IniRead, Support2Jump, %settings%, Support2Jump: , _
   IniRead, Support3Jump, %settings%, Support3Jump: , _
   IniRead, Support4Jump, %settings%, Support4Jump: , _
   IniRead, Support1ADS, %settings%, Support1ADS: , _
   IniRead, Support2ADS, %settings%, Support2ADS: , _
   IniRead, Support3ADS, %settings%, Support3ADS: , _
   IniRead, Support4ADS, %settings%, Support4ADS: , _
   IniRead, Support1AR, %settings%, Support1AR: , _
   IniRead, Support2AR, %settings%, Support2AR: , _
   IniRead, Support3AR, %settings%, Support3AR: , _
   IniRead, Support4AR, %settings%, Support4AR: , _
   IniRead, Support1Next, %settings%, Support1Next: , _
   IniRead, Support2Next, %settings%, Support2Next: , _
   IniRead, Support3Next, %settings%, Support3Next: , _
   IniRead, Support4Next, %settings%, Support4Next: , _
   IniRead, Support1Cap, %settings%, Support1Cap: , _
   IniRead, Support2Cap, %settings%, Support2Cap: , _
   IniRead, Support3Cap, %settings%, Support3Cap: , _
   IniRead, Support4Cap, %settings%, Support4Cap: , _
   IniRead, HPswapPercent, %settings%, HPswapPercent: , _

   IniRead, Support1Limit, %settings%, Support1Limit: , _
   IniRead, Support2Limit, %settings%, Support2Limit: , _
   IniRead, Support3Limit, %settings%, Support3Limit: , _
   IniRead, Support4Limit, %settings%, Support4Limit: , _
   IniRead, Support1Action, %settings%, Support1Action: , _
   IniRead, Support2Action, %settings%, Support2Action: , _
   IniRead, Support3Action, %settings%, Support3Action: , _
   IniRead, Support4Action, %settings%, Support4Action: , _

   ;Tab 5: Controls
   IniRead, keyForward, %settings%, keyForward: , _
   IniRead, keyBack, %settings%, keyBack: , _
   IniRead, keyLeft, %settings%, keyLeft: , _
   IniRead, keyRight, %settings%, keyRight: , _
   IniRead, keyReload, %settings%, keyReload: , _
   IniRead, keyRoll, %settings%, keyRoll: , _
   IniRead, keyCamera, %settings%, keyCamera: , _
   IniRead, keyFire, %settings%, keyFire: , _
   IniRead, keyADS, %settings%, keyADS: , _
   IniRead, keyEnable, %settings%, keyEnable: , _
   IniRead, keyDisable, %settings%, keyDisable: , _
   IniRead, keyExit, %settings%, keyExit: , _
   IniRead, keyStop, %settings%, keyStop: , _
   IniRead, keyEscShot, %settings%, keyEscShot: , _
   IniRead, keyAmmoSync, %settings%, keyAmmoSync: , _
   IniRead, keyPrimary, %settings%, keyPrimary: , _
   IniRead, keySupport1, %settings%, keySupport1: , _
   IniRead, keySupport2, %settings%, keySupport2: , _
   IniRead, keySupport3, %settings%, keySupport3: , _
   IniRead, keySupport4, %settings%, keySupport4: , _

      ;Apply Script Hotkeys
   if !((keyEnable="") or (keyEnable=ERROR))
      Hotkey , %keyEnable% , Enable
   if !((keyDisable="") or (keyDisable=ERROR))
      Hotkey , %keyDisable% , Disable
   if !((keyExit="") or (keyExit=ERROR))
      Hotkey , %keyExit% , Exit
   if !((keyStop="") or (keyStop=ERROR))
      Hotkey , %keyStop% , Stop
   if !((keyEscShot="") or (keyEscShot=ERROR))
      Hotkey , %keyEscShot% , EscShot
   if !((keyAmmoSync="") or (keyAmmoSync=ERROR))
      Hotkey , %keyAmmoSync% , AmmoSync
   if !((keyPrimary="") or (keyPrimary=ERROR))
      Hotkey , %keyPrimary% , Primary
   if !((keySupport1="") or (keySupport1=ERROR))
      Hotkey , %keySupport1% , Support1
   if !((keySupport2="") or (keySupport2=ERROR))
      Hotkey , %keySupport2% , Support2
   if !((keySupport3="") or (keySupport3=ERROR))
      Hotkey , %keySupport3% , Support3
   if !((keySupport4="") or (keySupport4=ERROR))
      Hotkey , %keySupport4% , Support4
}

ReadSettings(){

   ;read settings from ini file and update gui
   ;Tab 1: General
   IniRead, ADSmode_, %settings%, ADSmode: , _
   GuiControl,Choose,ADSmode_, %ADSmode_%
   IniRead, SMG_, %settings%, SMG: , _
   GuiControl,,SMG_, %SMG_%  
   IniRead, MixedADS_, %settings%, MixedADS: , _
   GuiControl,,MixedADS_,%MixedADS_%
   IniRead, StartMixedInADS_, %settings%, StartMixedInADS: , _
   GuiControl,,StartMixedInADS_,%StartMixedInADS_%
   IniRead, Rmode_, %settings%, Rmode: , _
   GuiControl,Choose,Rmode_, %Rmode_%
   IniRead, CenterCamera_, %settings%, CenterCamera: , _
   GuiControl,,CenterCamera_, %CenterCamera_%
   IniRead, AutoRoll_, %settings%, AutoRoll: , _
   GuiControl,,AutoRoll_, %AutoRoll_%
   IniRead, AutoWalk_, %settings%, AutoWalk: , _
   GuiControl,,AutoWalk_, %AutoWalk_%

   ;Tab 2: Timings
   IniRead, nADS1st_, %settings%, nADS1st: , _
   GuiControl,,nADS1st_, %nADS1st_%
   IniRead, nADS_, %settings%, nADS: , _
   GuiControl,,nADS_, %nADS_%
   IniRead, nADS2_, %settings%, nADS2: , _
   GuiControl,,nADS2_, %nADS2_%
   IniRead, nADScb_, %settings%, nADScb: , _
   GuiControl,,nADScb_, %nADScb_%
   IniRead, yADS1st_, %settings%, yADS1st: , _
   GuiControl,,yADS1st_, %yADS1st_%
   IniRead, yADS_, %settings%, yADS: , _
   GuiControl,,yADS_, %yADS_%
   IniRead, yADScb_, %settings%, yADScb: , _
   GuiControl,,yADScb_, %yADScb_%
   IniRead, airT_, %settings%, airT: , _
   GuiControl,,airT_, %airT_%

   ;Tab 3: Crafting
   IniRead, DisableCrafting_, %settings%, DisableCrafting: , _
   GuiControl,,DisableCrafting_, %DisableCrafting_%
   IniRead, AutoCraftAlways_, %settings%, AutoCraftAlways: , _
   GuiControl,,AutoCraftAlways_, %AutoCraftAlways_%

   IniRead, HbMenu_, %c_settings%, Menu: , _
   if HbMenu_=ERROR
      GuiControl,Choose,HbMenu_, 1
   else
      GuiControl,Choose,HbMenu_, %HbMenu_%

   IniRead, Slot1_, %c_settings%, Slot1: , _
   if Slot1_=ERROR
      GuiControl,Choose,Slot1_, 1
   else{
      Slot1_ := Slot1_ + 1 
      GuiControl,Choose,Slot1_, %Slot1_%
   }
   IniRead, Slot2_, %c_settings%, Slot2: , _
   if Slot2_=ERROR
      GuiControl,Choose,Slot2_, 1
   else{
      Slot2_ := Slot2_ + 1 
      GuiControl,Choose,Slot2_, %Slot2_%
   }
   IniRead, Slot3_, %c_settings%, Slot3: , _
   if Slot3_=ERROR
      GuiControl,Choose,Slot3_, 1
   else{
      Slot3_ := Slot3_ + 1 
      GuiControl,Choose,Slot3_, %Slot3_%
   }

   ;Tab 4: Ammo+
   IniRead, DisableAmmoPlus_, %settings%, DisableAmmoPlus: , _
   GuiControl,,DisableAmmoPlus_, %DisableAmmoPlus_%
   IniRead, AutoSync_, %settings%, AutoSync: , _
   GuiControl,,AutoSync_, %AutoSync_%

   IniRead, PrimaryType_, %settings%, PrimaryType: , _
   ComboChoose := ControlChooseStrExact(Primaryhwnd, AmmoName(PrimaryType_))
   ;If no Ammo match found, choose fisrt slot
   if (ComboChoose = 0) ;Returns 0 if no match is found
      GuiControl,Choose,PrimaryType_, 1
   else
      GuiControl,Choose,PrimaryType_, %ComboChoose%

   IniRead, StartPrimary_, %settings%, StartPrimary: , _
   GuiControl,,StartPrimary_, %StartPrimary_%
   IniRead, PrimaryJump_, %settings%, PrimaryJump: , _
   GuiControl,,PrimaryJump_, %PrimaryJump_%
   IniRead, ReturnPrimary_, %settings%, ReturnPrimary: , _
   GuiControl,,ReturnPrimary_, %ReturnPrimary_%
   IniRead, ReloadPrimary_, %settings%, ReloadPrimary: , _
   GuiControl,,ReloadPrimary_, %ReloadPrimary_%
   IniRead, ReloadPrimary2_, %settings%, ReloadPrimary2: , _
   GuiControl,,ReloadPrimary2_, %ReloadPrimary2_%
   IniRead, SwapPrimary_, %settings%, SwapPrimary: , _
   GuiControl,,SwapPrimary_, %SwapPrimary_%

   IniRead, AmmoSelect_, %settings%, AmmoSelect: , _
   GuiControl,Choose,AmmoSelect_, %AmmoSelect_%

   IniRead, Support1Type_, %settings%, Support1Type: , _
   ComboChoose := ControlChooseStrExact(Support1hwnd, AmmoName(Support1Type_))
   ;If no Ammo match found, choose fisrt slot
   if (ComboChoose = 0) ;Returns 0 if no match is found
      GuiControl,Choose,Support1Type_, 1
   else
      GuiControl,Choose,Support1Type_, %ComboChoose%

   IniRead, Support1AfterReload_, %settings%, Support1AfterReload: , _
   GuiControl,,Support1AfterReload_, %Support1AfterReload_%

   IniRead, Support1Jump_, %settings%, Support1Jump: , _
   GuiControl,,Support1Jump_, %Support1Jump_%

   IniRead, Support1ADS_, %settings%, Support1ADS: , _
   GuiControl,,Support1ADS_, %Support1ADS_%

   IniRead, Support1AR_, %settings%, Support1AR: , _
   GuiControl,,Support1AR_, %Support1AR_%

   IniRead, Support1Next_, %settings%, Support1Next: , _
   GuiControl,,Support1Next_, %Support1Next_%

   IniRead, Support1Cap_, %settings%, Support1Cap: , _
   GuiControl,,Support1Cap_, %Support1Cap_%

   IniRead, Support1Limit_, %settings%, Support1Limit: , _
   if Support1Limit_=ERROR
      GuiControl,Choose,Support1Limit_, 1
   else{
      Support1Limit_ := Support1Limit_ + 1 
      GuiControl,Choose,Support1Limit_, %Support1Limit_%
   }

   IniRead, Support1Action_, %settings%, Support1Action: , _
   GuiControl,Choose,Support1Action_, %Support1Action_%

   IniRead, Support2Type_, %settings%, Support2Type: , _
   ComboChoose := ControlChooseStrExact(Support2hwnd, AmmoName(Support2Type_))
   ;If no Ammo match found, choose fisrt slot
   if (ComboChoose = 0) ;Returns 0 if no match is found
      GuiControl,Choose,Support2Type_, 1
   else
      GuiControl,Choose,Support2Type_, %ComboChoose%

   IniRead, Support2AfterReload_, %settings%, Support2AfterReload: , _
   GuiControl,,Support2AfterReload_, %Support2AfterReload_%

   IniRead, Support2Jump_, %settings%, Support2Jump: , _
   GuiControl,,Support2Jump_, %Support2Jump_%

   IniRead, Support2ADS_, %settings%, Support2ADS: , _
   GuiControl,,Support2ADS_, %Support2ADS_%

   IniRead, Support2AR_, %settings%, Support2AR: , _
   GuiControl,,Support2AR_, %Support2AR_%

   IniRead, Support2Next_, %settings%, Support2Next: , _
   GuiControl,,Support2Next_, %Support2Next_%

   IniRead, Support2Cap_, %settings%, Support2Cap: , _
   GuiControl,,Support2Cap_, %Support2Cap_%

   IniRead, Support2Limit_, %settings%, Support2Limit: , _
   if Support2Limit_=ERROR
      GuiControl,Choose,Support2Limit_, 1
   else{
      Support2Limit_ := Support2Limit_ + 1 
      GuiControl,Choose,Support2Limit_, %Support2Limit_%
   }

   IniRead, Support2Action_, %settings%, Support2Action: , _
   GuiControl,Choose,Support2Action_, %Support2Action_%

   IniRead, Support3Type_, %settings%, Support3Type: , _
   ComboChoose := ControlChooseStrExact(Support3hwnd, AmmoName(Support3Type_))
   ;If no Ammo match found, choose fisrt slot
   if (ComboChoose = 0) ;Returns 0 if no match is found
      GuiControl,Choose,Support3Type_, 1
   else
      GuiControl,Choose,Support3Type_, %ComboChoose%

   IniRead, Support3AfterReload_, %settings%, Support3AfterReload: , _
   GuiControl,,Support3AfterReload_, %Support3AfterReload_%

   IniRead, Support3Jump_, %settings%, Support3Jump: , _
   GuiControl,,Support3Jump_, %Support3Jump_%

   IniRead, Support3ADS_, %settings%, Support3ADS: , _
   GuiControl,,Support3ADS_, %Support3ADS_%

   IniRead, Support3Next_, %settings%, Support3Next: , _
   GuiControl,,Support3Next_, %Support3Next_%

   IniRead, Support3AR_, %settings%, Support3AR: , _
   GuiControl,,Support3AR_, %Support3AR_%

   IniRead, Support3Cap_, %settings%, Support3Cap: , _
   GuiControl,,Support3Cap_, %Support3Cap_%

   IniRead, Support3Limit_, %settings%, Support3Limit: , _
   if Support3Limit_=ERROR
      GuiControl,Choose,Support3Limit_, 1
   else{
      Support3Limit_ := Support3Limit_ + 1 
      GuiControl,Choose,Support3Limit_, %Support3Limit_%
   }

   IniRead, Support3Action_, %settings%, Support3Action: , _
   GuiControl,Choose,Support3Action_, %Support3Action_%

   IniRead, Support4Type_, %settings%, Support4Type: , _
   ComboChoose := ControlChooseStrExact(Support4hwnd, AmmoName(Support4Type_))
   ;If no Ammo match found, choose fisrt slot
   if (ComboChoose = 0) ;Returns 0 if no match is found
      GuiControl,Choose,Support4Type_, 1
   else
      GuiControl,Choose,Support4Type_, %ComboChoose%

   IniRead, Support4AfterReload_, %settings%, Support4AfterReload: , _
   GuiControl,,Support4AfterReload_, %Support4AfterReload_%

   IniRead, Support4Jump_, %settings%, Support4Jump: , _
   GuiControl,,Support4Jump_, %Support4Jump_%

   IniRead, Support4ADS_, %settings%, Support4ADS: , _
   GuiControl,,Support4ADS_, %Support4ADS_%

   IniRead, Support4AR_, %settings%, Support4AR: , _
   GuiControl,,Support4AR_, %Support4AR_%

   IniRead, Support4Next_, %settings%, Support4Next: , _
   GuiControl,,Support4Next_, %Support4Next_%

   IniRead, Support4Cap_, %settings%, Support4Cap: , _
   GuiControl,,Support4Cap_, %Support4Cap_%

   IniRead, Support4Limit_, %settings%, Support4Limit: , _
   if Support4Limit_=ERROR
      GuiControl,Choose,Support4Limit_, 1
   else{
      Support4Limit_ := Support4Limit_ + 1 
      GuiControl,Choose,Support4Limit_, %Support4Limit_%
   }

   IniRead, Support4Action_, %settings%, Support4Action: , _
   GuiControl,Choose,Support4Action_, %Support4Action_%

   IniRead, HPswapPercent_, %settings%, HPswapPercent: , _
   GuiControl,Choose,HPswapPercent_, %HPswapPercent_%

   ;Tab 5: Controls
   IniRead, keyForward_, %settings%, keyForward: , _
   GuiControl,,keyForward_, %keyForward_%
   IniRead, keyBack_, %settings%, keyBack: , _
   GuiControl,,keyBack_, %keyBack_%
   IniRead, keyLeft_, %settings%, keyLeft: , _
   GuiControl,,keyLeft_, %keyLeft_%
   IniRead, keyRight_, %settings%, keyRight: , _
   GuiControl,,keyRight_, %keyRight_%
   IniRead, keyReload_, %settings%, keyReload: , _
   GuiControl,,keyReload_, %keyReload_%
   IniRead, keyRoll_, %settings%, keyRoll: , _
   GuiControl,,keyRoll_, %keyRoll_%
   IniRead, keyAmmoUp_, %a_settings%, keyAmmoUp: , _
   GuiControl,,keyAmmoUp_, %keyAmmoUp_%
   IniRead, keyAmmoDown_, %a_settings%, keyAmmoDown: , _
   GuiControl,,keyAmmoDown_, %keyAmmoDown_%
   IniRead, keyCamera_, %settings%, keyCamera: , _
   GuiControl,,keyCamera_, %keyCamera_%
   IniRead, keyFire_, %settings%, keyFire: , _
   GuiControl,,keyFire_, %keyFire_%
   IniRead, keyADS_, %settings%, keyADS: , _
   GuiControl,,keyADS_, %keyADS_%
   ;
   IniRead, keyEnable_, %settings%, keyEnable: , _
   GuiControl,,keyEnable_, %keyEnable_%
   IniRead, keyDisable_, %settings%, keyDisable: , _
   GuiControl,,keyDisable_, %keyDisable_%
   IniRead, keyExit_, %settings%, keyExit: , _
   GuiControl,,keyExit_, %keyExit_%
   IniRead, keyStop_, %settings%, keyStop: , _
   GuiControl,,keyStop_, %keyStop_%
   IniRead, keyEscShot_, %settings%, keyEscShot: , _
   GuiControl,,keyEscShot_, %keyEscShot_%
   IniRead, keyAmmoSync_, %settings%, keyAmmoSync: , _
   GuiControl,,keyAmmoSync_, %keyAmmoSync_%
   IniRead, keyPrimary_, %settings%, keyPrimary: , _
   GuiControl,,keyPrimary_, %keyPrimary_%
   IniRead, keySupport1_, %settings%, keySupport1: , _
   GuiControl,,keySupport1_, %keySupport1_%
   IniRead, keySupport2_, %settings%, keySupport2: , _
   GuiControl,,keySupport2_, %keySupport2_%
   IniRead, keySupport3_, %settings%, keySupport3: , _
   GuiControl,,keySupport3_, %keySupport3_%
   IniRead, keySupport4_, %settings%, keySupport4: , _
   GuiControl,,keySupport4_, %keySupport4_%

   ;Other
   IniRead, KeepOnTop_, %settings%, KeepOnTop: , _
   GuiControl,,KeepOnTop_, %KeepOnTop_%

}

ApplySettings(){
   Submit_All()
   ;write gui settings into the ini file(s)
   ;Tab 1: General
   IniWrite, %ADSmode_%, %settings%, ADSmode: , _
   IniWrite, %SMG_%, %settings%, SMG: , _
   IniWrite, %MixedADS_%, %settings%, MixedADS: , _
   IniWrite, %StartMixedInADS_%, %settings%, StartMixedInADS: , _
   IniWrite, %Rmode_%, %settings%, Rmode: , _
   IniWrite, %CenterCamera_%, %settings%, CenterCamera: , _
   IniWrite, %AutoRoll_%, %settings%, AutoRoll: , _
   IniWrite, %AutoWalk_%, %settings%, AutoWalk: , _

   ;Tab 2: Timings
   IniWrite, %nADS1st_%, %settings%, nADS1st: , _
   IniWrite, %nADS_%, %settings%, nADS: , _
   IniWrite, %nADS2_%, %settings%, nADS2: , _
   IniWrite, %nADScb_%, %settings%, nADScb: , _
   IniWrite, %yADS1st_%, %settings%, yADS1st: , _
   IniWrite, %yADS_%, %settings%, yADS: , _
   IniWrite, %yADScb_%, %settings%, yADScb: , _
   IniWrite, %airT_%, %settings%, airT: , _

   ;Tab 3: Crafting
   IniWrite, %DisableCrafting_%, %settings%, DisableCrafting: , _
   IniWrite, %AutoCraftAlways_%, %settings%, AutoCraftAlways: , _
   IniWrite, %HbMenu_%, %c_settings%, Menu: , _
   IniWrite, %Slot1_%, %c_settings%, Slot1: , _
   IniWrite, %Slot2_%, %c_settings%, Slot2: , _
   IniWrite, %Slot3_%, %c_settings%, Slot3: , _
   IniWrite, %CraftMagSize_%, %settings%, CraftMagSize: , _

   ;Tab 4: Ammo+
   IniWrite, %DisableAmmoPlus_%, %settings%, DisableAmmoPlus: , _
   IniWrite, %AutoSync_%, %settings%, AutoSync: , _
   AmmoID:=AmmoID(PrimaryType_)
   IniWrite, %AmmoID%, %settings%, PrimaryType: , _
   IniWrite, %StartPrimary_%, %settings%, StartPrimary: , _
   IniWrite, %PrimaryJump_%, %settings%, PrimaryJump: , _
   IniWrite, %ReturnPrimary_%, %settings%, ReturnPrimary: , _
   IniWrite, %ReloadPrimary_%, %settings%, ReloadPrimary: , _
   IniWrite, %ReloadPrimary2_%, %settings%, ReloadPrimary2: , _
   IniWrite, %SwapPrimary_%, %settings%, SwapPrimary: , _

   IniWrite, %AmmoSelect_%, %settings%, AmmoSelect: , _
   AmmoID:=AmmoID(Support1Type_)
   IniWrite, %AmmoID%, %settings%, Support1Type: , _
   AmmoID:=AmmoID(Support2Type_)
   IniWrite, %AmmoID%, %settings%, Support2Type: , _
   AmmoID:=AmmoID(Support3Type_)
   IniWrite, %AmmoID%, %settings%, Support3Type: , _
   AmmoID:=AmmoID(Support4Type_)
   IniWrite, %AmmoID%, %settings%, Support4Type: , _
   IniWrite, %Support1AfterReload_%, %settings%, Support1AfterReload: , _
   IniWrite, %Support2AfterReload_%, %settings%, Support2AfterReload: , _
   IniWrite, %Support3AfterReload_%, %settings%, Support3AfterReload: , _
   IniWrite, %Support4AfterReload_%, %settings%, Support4AfterReload: , _
   IniWrite, %Support1Jump_%, %settings%, Support1Jump: , _
   IniWrite, %Support2Jump_%, %settings%, Support2Jump: , _
   IniWrite, %Support3Jump_%, %settings%, Support3Jump: , _
   IniWrite, %Support4Jump_%, %settings%, Support4Jump: , _
   IniWrite, %Support1ADS_%, %settings%, Support1ADS: , _
   IniWrite, %Support2ADS_%, %settings%, Support2ADS: , _
   IniWrite, %Support3ADS_%, %settings%, Support3ADS: , _
   IniWrite, %Support4ADS_%, %settings%, Support4ADS: , _
   IniWrite, %Support1AR_%, %settings%, Support1AR: , _
   IniWrite, %Support2AR_%, %settings%, Support2AR: , _
   IniWrite, %Support3AR_%, %settings%, Support3AR: , _
   IniWrite, %Support4AR_%, %settings%, Support4AR: , _
   IniWrite, %Support1Next_%, %settings%, Support1Next: , _
   IniWrite, %Support2Next_%, %settings%, Support2Next: , _
   IniWrite, %Support3Next_%, %settings%, Support3Next: , _
   IniWrite, %Support4Next_%, %settings%, Support4Next: , _
   IniWrite, %Support1Cap_%, %settings%, Support1Cap: , _
   IniWrite, %Support2Cap_%, %settings%, Support2Cap: , _
   IniWrite, %Support3Cap_%, %settings%, Support3Cap: , _
   IniWrite, %Support4Cap_%, %settings%, Support4Cap: , _
   IniWrite, %HPswapPercent_%, %settings%, HPswapPercent: , _
   IniWrite, %Support1Limit_%, %settings%, Support1Limit: , _
   IniWrite, %Support2Limit_%, %settings%, Support2Limit: , _
   IniWrite, %Support3Limit_%, %settings%, Support3Limit: , _
   IniWrite, %Support4Limit_%, %settings%, Support4Limit: , _
   IniWrite, %Support1Action_%, %settings%, Support1Action: , _
   IniWrite, %Support2Action_%, %settings%, Support2Action: , _
   IniWrite, %Support3Action_%, %settings%, Support3Action: , _
   IniWrite, %Support4Action_%, %settings%, Support4Action: , _

   ;Tab 5: Controls
   Iniwrite, %keyForward_%, %settings%, keyForward: , _
   Iniwrite, %keyBack_%, %settings%, keyBack: , _
   Iniwrite, %keyLeft_%, %settings%, keyLeft: , _
   Iniwrite, %keyRight_%, %settings%, keyRight: , _
   Iniwrite, %keyReload_%, %settings%, keyReload: , _
   Iniwrite, %keyRoll_%, %settings%, keyRoll: , _
   Iniwrite, %keyAmmoUp_%, %a_settings%, keyAmmoUp: , _
   Iniwrite, %keyAmmoDown_%, %a_settings%, keyAmmoDown: , _
   Iniwrite, %keyCamera_%, %settings%, keyCamera: , _
   Iniwrite, %keyFire_%, %settings%, keyFire: , _
   Iniwrite, %keyADS_%, %settings%, keyADS: , _
   ;............................................
   Iniwrite, %keyEnable_%, %settings%, keyEnable: , _
   Iniwrite, %keyDisable_%, %settings%, keyDisable: , _
   Iniwrite, %keyExit_%, %settings%, keyExit: , _
   Iniwrite, %keyStop_%, %settings%, keyStop: , _
   Iniwrite, %keyEscShot_%, %settings%, keyEscShot: , _
   Iniwrite, %keyAmmoSync_%, %settings%, keyAmmoSync: , _
   Iniwrite, %keyPrimary_%, %settings%, keyPrimary: , _
   Iniwrite, %keySupport1_%, %settings%, keySupport1: , _
   Iniwrite, %keySupport2_%, %settings%, keySupport2: , _
   Iniwrite, %keySupport3_%, %settings%, keySupport3: , _
   Iniwrite, %keySupport4_%, %settings%, keySupport4: , _

   ;Other:
   Iniwrite, %KeepOnTop_%, %settings%, KeepOnTop: , _

   LoadSettings()
   ReadSettings()
   ReadSettings()
   ReadSettings()

}

