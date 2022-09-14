/*
* File: tools.S
* Author: Mewtality
* Date: 2022-09-08 13:02:51
* YouTube: https://www.youtube.com/c/Mewtality
* Discord: Mewtality#0666
*/

	.include "C:/devkitPro/devkitPPC/assembly/common.S"
	.include "C:/devkitPro/devkitPPC/assembly/titles/AMKP01/functions.S"
	.include "C:/devkitPro/devkitPPC/assembly/titles/AMKP01/memMap.S"

	# DRC Activators
	.equiv A, 0x00000001
	.equiv B, 0x00000002
	.equiv X, 0x00000008
	.equiv Y, 0x00000010
	.equiv L, 0x00002000
	.equiv R, 0x00004000
	.equiv ZL, 0x00000004
	.equiv ZR, 0x00000020
	.equiv START, 0x00000C00
	.equiv SELECT, 0x00001200
	.equiv DPAD_UP, 0x00010000
	.equiv DPAD_DOWN, 0x00020000
	.equiv DPAD_LEFT, 0x00040000
	.equiv DPAD_RIGHT, 0x00080000
	.equiv LEFT_STICK_PRESS, 0x00000080
	.equiv LEFT_STICK_UP, 0x00100000
	.equiv LEFT_STICK_DOWN, 0x00200000
	.equiv LEFT_STICK_LEFT, 0x00400000
	.equiv LEFT_STICK_RIGHT, 0x00800000
	.equiv RIGHT_STICK_PRESS, 0x00000040
	.equiv HOME, 0x00000100
	.equiv TOUCH_SCREEN, 0x00008000
	.equiv SHAKE_UP, 0x01000000
	.equiv SHAKE_DOWN, 0x02000000
	.equiv SHAKE_LEFT, 0x04000000
	.equiv SHAKE_RIGHT, 0x08000000

	# Common Offsets
	.equiv UIRaceItem.matrix.scale.X, 0x4C
	.equiv UIRaceItem.matrix.scale.Y, 0x50
	.equiv UIRaceItem.visibility, 0x54
	.equiv UIRaceItem.matrix.rotate.X, 0x6C
	.equiv UIRaceItem.matrix.rotate.Y, 0x58
	.equiv UIRaceItem.matrix.skew.X, 0x5C
	.equiv UIRaceItem.matrix.skew.Y, 0x68
	.equiv UIRaceItem.matrix.translate.X, 0x64
	.equiv UIRaceItem.matrix.translate.Y, 0x74
	.equiv UIRaceItem.matrix.translate.Z, 0x84
	.equiv UIRaceItem.image, 0xB4
	.equiv UIRaceItem.image.blendRGBA.gradient.TL, 0xB8
	.equiv UIRaceItem.image.blendRGBA.gradient.TR, 0xBC
	.equiv UIRaceItem.image.blendRGBA.gradient.BL, 0xC0
	.equiv UIRaceItem.image.blendRGBA.gradient.BR, 0xC4
	.equiv UIRaceItem.image.blendMode, 0xC8

	# Macros
	.macro isRaceReady loc
		dereference("raceManagement")
		cmpwi r12, 0
		beq \loc
		lwz r12, 0x23C (r12)
		cmpwi r12, 0
		beq \loc
		lbz %a0, 0x3E (r12)
		cmpwi %a0, 0
		beq \loc
	.endm

	.macro isRacePaused loc
		dereference(0x40120F1C)
		rlwinm. r0, r12, 8, 31, 31
		bne \loc
	.endm

	.macro isRaceState loc
		call("object_IsRaceState")
		cmpwi %a3, 0
		beq \loc
	.endm

	.macro isActivator loc, btn
		lis %a5, \btn@h
		ori %a5, %a5, \btn@l
		and %a6, %a3, %a5
		cmpw %a5, %a6
		bne \loc
	.endm

	.macro isActivatorToggle loc, btn, flag
		lbz %a7, \flag+0x1@l (r31)
		isActivator(0x24), \btn
		lbz %a0, \flag@l (r31)
		cmpwi %a0, 0
		li %a0, 0x1
		stb %a0, \flag@l (r31)
		bne 0x18
		xori %a7, %a7, 0x1
		stb %a7, \flag+0x1@l(r31)
		b 0xC
		li %a0, 0
		stb %a0, \flag@l (r31)
		cmpwi %a7, 0
		beq \loc
	.endm

	.macro reset loc, size="0"
		li %a0, 0
		stw %a0, \loc@l (r31)
		.if \size >= 1
		stw %a0, \loc+0x4@l (r31)
		.endif
		.if \size >= 2
		stw %a0, \loc+0x8@l (r31)
		.endif
		.if \size >= 3
		.err
		.endif
	.endm

	.macro setFlag termination flag
		lbz %a0, \flag@l (r31)
		cmpwi %a0, 0
		bne \termination
		li %a0, 1
		stb %a0, \flag@l (r31)
	.endm

	.macro resetFlag loc
		li %a0, 0
		stb %a0, \loc@l (r31)
	.endm

	.macro getDRCPlayer loc
		call("object_RaceIndex__DRCPlayer2Kart")
		cmplwi %a3, 0xB
		bgt \loc
	.endm

	.macro getDRCKartUnit loc
		getDRCPlayer(\loc)
		call("object_KartInfoProxy_getKartUnit")
	.endm

	.macro getDRCUI loc
		getDRCPlayer(\loc)
		dereference("GUIManagement"), 0x10, 0x4, 0x1A0
		call("ui_Page_Race_findWindowByKartIndex"), "mr %a4, %a3; mr %a3, r12"
	.endm

	.macro getUIRaceItem null
		lwz %a3, 0x18 (%a3)
		lwz r12, 0x50 (%a3)
		lwz r12, 0x38 (r12)
	.endm