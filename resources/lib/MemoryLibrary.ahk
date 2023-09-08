;;==============================[MHWI MemReadInfo]=============================
global prcName := "MonsterHunterWorld.exe"
global bAddress := 0x140000000
global prcId := Memory_GetProcessID(prcName)
global prcHandle := Memory_GetProcessHandle(prcId)

global stateOffsets := [0x506D270, 0x80, 0x6278]
global stateAddress := GetAddressPtrChain(stateOffsets)  ;Action ID
global animIDOffsets := [0x506D270, 0x80, 0x468, 0x238]
global animIDAddress := GetAddressPtrChain(animIDOffsets)  ;Primary Animation ID
global animID2Offsets := [0x506D270, 0x80, 0x468, 0x27A8]
global animID2Address := GetAddressPtrChain(animID2Offsets)  ;Secondary Animation ID

global ammoOffsets := [0x506D270, 0x80, 0x76B0, 0x23A8]
global ammoAddress := GetAddressPtrChain(ammoOffsets)

global ammoTypeOffsets := [0x506D270, 0x80, 0x76B0, 0x27C8]
global ammoTypeAddress := GetAddressPtrChain(ammoTypeOffsets)

global posXOffsets := [0x506D270, 0x80, 0x160]
global posXAddress := GetAddressPtrChain(posXOffsets)
global posYOffsets := [0x506D270, 0x80, 0x164]
global posYAddress := GetAddressPtrChain(posYOffsets)
global posZOffsets := [0x506D270, 0x80, 0x168]
global posZAddress := GetAddressPtrChain(posZOffsets)

global mon1MaxHpOffsets := [0x5074180,0xE58, 0x7670, 0x60]
global mon1MaxHpAddress := GetAddressPtrChain(mon1MaxHpOffsets)
global mon1HpOffsets := [0x5074180, 0xE58, 0x7670, 0x64]
global mon1HpAddress := GetAddressPtrChain(mon1HpOffsets)

OnExit("CleanExit")

;;===========================[MHW Mem ReadFunctions]===========================
;;Run to rescan ptr addresses
ReScanPtrs(){
   stateAddress := GetAddressPtrChain(stateOffsets)
   animIDAddress := GetAddressPtrChain(animIDOffsets)
   animID2Address := GetAddressPtrChain(animID2Offsets)
   ammoAddress := GetAddressPtrChain(ammoOffsets)
   ammoTypeAddress := GetAddressPtrChain(ammoTypeOffsets)
   posXAddress := GetAddressPtrChain(posXOffsets)
   posYAddress := GetAddressPtrChain(posYOffsets)
   posZAddress := GetAddressPtrChain(posZOffsets)
   mon1MaxHpAddress := GetAddressPtrChain(mon1MaxHpOffsets)
   mon1HpAddress := GetAddressPtrChain(mon1HpOffsets)
}
/*
  Ammo Type IDs
  Type -1 = disabled / don't use 
  Type 0/1/2 = Normal 1/2/3    | Type 3/4/5 = Pierce 1/2/3    | Type 6/7/8 = Spread 1/2/3
  Type 9/10/11 = Cluster 1/2/3 | Type 13/14/15 = Sticky 1/2/3 | Type 21 = Dragon Ammo
  Type 24/25 = Para 1/2        | Type 26/27 = Sleep 1/2
  Type 28/29 = Exhaust 1/2     | Type 36 = Tranq
*/
;;Update Ammo Type
GetAmmoType() {
   return Memory_Read(prcHandle, ammoTypeAddress)
}

;;Get Ammo Mag Count for specific ammo type
GetAmmoCount(type) {
   return Memory_Read(prcHandle, ammoAddress + 0x18 * type)
}

;;Get Ammo Clip Count for specific ammo type
GetAmmoCount2(type) {
   return Memory_Read(prcHandle, ammoAddress + (0x18 * type) + 0x04)
}

/* Action IDs
  0 - Stand        	  1 - Moving (Unsheathed)        2 - Stopping (Unsheathed)	4 - Moving (Sheathed)	5 - Stopping (Sheathed)
 23 - Falling Unsheath 	 25 - Landed Unsheath Neutral   27 - Landed Unsheath Moving
 65 - ADS Transition ON  66 - ADS transition OFF	67 - ADS 
 71 - Stopping ADS 	 73 - VeryHigh Recoil Shot(LBG) 78 - Very High Reload (LBG)
 81 - Reload Air (LBG)	 82 - Reload Air (HBG)		83 - Reload Landing (LBG)	84- Reload Landing (LBG)
 97 - Air Shot (LBG) 	104 - Air Shot (HBG)
313 - Quest Start Walk	314 - Bird Quest Entrance	318->319 - Drunkbird Quest Entrance (319 items active)

*/

;;Get the Action ID of your character
GetActionID() {
   return Memory_Read(prcHandle, stateAddress)
}

;;Get the Primary Animation ID of your character. 33 = HBG Unsheath
GetAnimID() {
   return Memory_Read(prcHandle, animIDAddress)
}

;;Get the Secondary Animation ID of your character. 107 = Average-> Fast HBG/LBG(?) reload 
GetAnim2ID() {
   return Memory_Read(prcHandle, animID2Address)
}

;;Get the X position of your character
GetXpos(){
   return Memory_Read(prcHandle, posXAddress, "float")
}

;;Get the Y position of your character
GetYpos(){
   return Memory_Read(prcHandle, posYAddress, "float")
}

;;Get the Z position of your character
GetZpos(){
   return Memory_Read(prcHandle, posZAddress, "float")
}

;;Get the max HP of Monster 1
GetMon1MaxHP(){
   return Memory_Read(prcHandle, mon1MaxHpAddress, "float")
}

;;Get the current HP of Monster 1
GetMon1HP(){
   return Memory_Read(prcHandle, mon1HpAddress, "float")
}

;;==============================[Memory Library]===============================
;;Check if current active window is correct
CheckWindow() {
   return WinActive("ahk_exe " . prcName)
}

;;Runs clean up tasks prior to exiting
CleanExit() {
   Memory_CloseHandle(prcHandle)
}

;;Based on: https://github.com/kevrgithub/autohotkey/blob/master/Lib/Memory.ahk

Memory_GetProcessID(process_name) {
    Process, Exist, %process_name%
    return ErrorLevel
}

Memory_GetProcessHandle(process_id) {
    return DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", false, "UInt", process_id, "Ptr") ; PROCESS_ALL_ACCESS
}

Memory_CloseHandle(process_handle) {
    DllCall("CloseHandle", "Ptr", process_handle)
}

Memory_Read(process_handle, address, t="UInt", size=4) {
    VarSetCapacity(value, size, 0)
    DllCall("ReadProcessMemory", "UInt", process_handle, "UInt", address, "Str", value, "UInt", size, "UInt *", 0)
    return NumGet(value, 0, t)
}

Memory_ReadEx(process_handle, address, size)
{
    VarSetCapacity(value, size, 0)
    DllCall("ReadProcessMemory", "UInt", process_handle, "UInt", address, "Str", value, "UInt", size, "UInt *", 0)

    Return, NumGet(value, 0, "UInt")
}

Memory_Write(process_handle, address, value)
{
    DllCall("VirtualProtectEx", "UInt", process_handle, "UInt", address, "UInt", 4, "UInt", 0x04, "UInt *", 0) ; PAGE_READWRITE

    DllCall("WriteProcessMemory", "UInt", process_handle, "UInt", address, "UInt *", value, "UInt", 4, "UInt *", 0)
}

;;Get final target address of a pointer chain
GetAddressPtrChain(ptrOffsets) {
   address := bAddress
   last := ptrOffsets.MaxIndex()
   for k,v in ptrOffsets
   {
      address := address + v
      if (k != last) {
         address := Memory_Read(prcHandle, address, "Int64", 8)
      }
   }
   return address
}
