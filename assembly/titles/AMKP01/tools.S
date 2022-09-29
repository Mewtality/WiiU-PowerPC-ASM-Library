/*
* File: tools.S
* Author: Mewtality
* Date: Thursday, September 29, 2022 @ 12:59:30 PM
* YouTube: https://www.youtube.com/c/Mewtality
* Discord: Mewtality#8315
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
	.equiv FLICK_UP, 0x01000000
	.equiv FLICK_DOWN, 0x02000000
	.equiv FLICK_LEFT, 0x04000000
	.equiv FLICK_RIGHT, 0x08000000

	# Macro Flags
	prepareDialogPage.reg = null
	string.flag = false

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
		call("object::IsRaceState()")
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

	.macro isSent termination flag
		lis r12, \flag@h
		lbz %a0, \flag@l (r12)
		cmpwi %a0, 0
		bne \termination
		li %a0, 1
		stb %a0, \flag@l (r12)
	.endm

	.macro resetFlag loc
		li %a0, 0
		stb %a0, \loc@l (r31)
	.endm

	.macro getDRCPlayer loc
		call("object::RaceIndex_::DRCPlayer2Kart()")
		cmplwi %a3, 0xB
		bgt \loc
	.endm

	.macro getDRCKartUnit loc
		getDRCPlayer(\loc)
		call("object::KartInfoProxy::getKartUnit()")
	.endm

	.macro getDRCUI loc
		getDRCPlayer(\loc)
		dereference("GUIManagement"), 0x10, 0x4, 0x1A0
		call("ui::Page_Race::findWindowByKartIndex()"), "mr %a4, %a3; mr %a3, r12"
	.endm

	.macro prepareDialogPage reg
		prepareDialogPage.reg = \reg

		dereference("GUIManagement"), 0x10, 0x4
		lwz \reg, 0x1C (r12)
	.endm

	.macro isDialogPageClosed loc
	.if prepareDialogPage.reg == null
	.err
	.endif
		call("ui::Page_Dialog::isClose()"), "mr %a3, prepareDialogPage.reg"
		cmpwi %a3, 0
		beq \loc
	.endm

	.macro isDialogPageOpen loc
	.if prepareDialogPage.reg == null
	.err
		call("ui::Page_Dialog::isClose()"), "mr %a3, prepareDialogPage.reg"
		cmpwi %a3, 0
		bne \loc
	.endm

	.macro requestDialogPage null
		call("ui::Page_Dialog::in_()"), "mr %a3, prepareDialogPage.reg"
	.endm

	.macro printDialogBodyText string
		\string
		lwz r12, 0x5AC (prepareDialogPage.reg)
		lwz %a4, 0x5C (r12)
		li %a5, null
		li %a6, true
		call("ui::RegisterScalableFontText()")
	.endm

	.macro printDialogButtonText string
		\string
		lwz r12, 0x5CC (prepareDialogPage.reg)
		lwz %a4, 0xF4 (r12)
		li %a5, null
		li %a6, true
		call("ui::RegisterScalableFontText()")
	.endm

	.macro getString loc
		bl \loc
		mfspr %a3, %lr
	.endm

	.macro string encoding name string start length
	.if string.flag == false
		b _start
	.endif
	string.flag = true
\name:
		blrl
		.incbin "\string", \encoding * \start, \encoding * \length
		.align \encoding
	.endm