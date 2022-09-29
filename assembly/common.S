/*
* File: common.S
* Author: Mewtality
* Date: Thursday, September 29, 2022 @ 12:59:30 PM
* YouTube: https://www.youtube.com/c/Mewtality
* Discord: Mewtality#8315
*/

	# Common Variables
	.equiv false, 0
	.equiv true, 1
	.equiv null, -1

	.equiv unicode, 0x2

	# Macro Flags
	.set stackUpdate.space, null
	.set push, null

	# Fastcalls
	.equiv Unk_0x0000, 0x0000
	.equiv SyncEIEIO, 0x0001
	.equiv LoadContext, 0x0006
	.equiv SaveContext, 0x0007
	.equiv SetCurrentContext, 0x0008
	.equiv GetCurrentFPUContext, 0x0009
	.equiv SetCurrentFPUContext, 0x000A
	.equiv CompareAndSwapCurrentFPUContext, 0x000B
	.equiv WriteGatherInit, 0x000C
	.equiv SetPerformanceMonitor, 0x000D
	.equiv FlushDMAQueue, 0x000E
	.equiv Nothing_rfi, 0x000F
	.equiv DisableFPU, 0x0010
	.equiv ReadRegister32Ex, 0x0011
	.equiv WriteRegister32Ex, 0x0012
	.equiv Unk_0x0013, 0x0013
	.equiv Unk_0x0014, 0x0014
	.equiv Unk_0x0015, 0x0015
	.equiv Unk_0x0016, 0x0016
	.equiv WriteGatherGetPtr, 0x0017
	.equiv EnableFPU, 0x0018
	.equiv GetSecurityLevel, 0x0019
	.equiv BadFastCall, 0x001A

	# Syscalls
	.equiv ConsoleWrite, 0x0000
	.equiv AppPanic, 0x0100
	.equiv EffectiveToPhysical, 0x0200
	.equiv PhysicalToEffectiveCached, 0x0300
	.equiv PhysicalToEffectiveUncached, 0x0400
	.equiv ValidateAddrRange, 0x0500
	.equiv UpdateCoreTime, 0x0600
	.equiv SetUserModeExHandler, 0x0800
	.equiv AllocateTimer, 0x0B00
	.equiv FreeTimer, 0x0C00
	.equiv PrimeTimer, 0x0D00
	.equiv StopTimer, 0x0E00
	.equiv DumpModuleList, 0x0F00
	.equiv SetInterruptHandler, 0x1000
	.equiv GetInterruptHandler, 0x1100
	.equiv DisableInterrupt, 0x1200
	.equiv EnableInterrupt, 0x1300
	.equiv ClearAndEnableInterrupt, 0x1400
	.equiv GetInterruptStatus, 0x1500
	.equiv ClearInterruptStatus, 0x1600
	.equiv FindClosestSymbol, 0x1700
	.equiv Halt, 0x1900
	.equiv GetInfo, 0x1A00
	.equiv SetInfo, 0x1B00
	.equiv ReleaseCore, 0x1C00
	.equiv SendICI, 0x1D00
	.equiv IPCKDriver_LoaderOpen, 0x1E00
	.equiv IPCKDriver_LoaderClose, 0x1F00
	.equiv IPCKDriver_SubmitRequest, 0x2000
	.equiv GetEnvironmentVariable, 0x2200
	.equiv GetNotifyTarget, 0x2700
	.equiv ReleaseForeground, 0x2800
	.equiv GetForegroundBucket, 0x2900
	.equiv RequestSwitch, 0x2A00
	.equiv LaunchTitleArgvStr, 0x2B00
	.equiv ProcYield, 0x2C00
	.equiv GetSystemMessage, 0x2E00
	.equiv GetCallArgs, 0x2F00
	.equiv GetAbsoluteSystemTimeInternal, 0x3000
	.equiv SetAbsoluteSystemTimeInternal, 0x3100
	.equiv Driver_Register, 0x3200
	.equiv Driver_Deregister, 0x3300
	.equiv AllocVirtAddr, 0x3800
	.equiv FreeVirtAddr, 0x3900
	.equiv GetMapVirtAddrRange, 0x3A00
	.equiv GetDataPhysAddrRange, 0x3B00
	.equiv GetAvailPhysAddrRange, 0x3C00
	.equiv MapMemory, 0x3D00
	.equiv UnmapMemory, 0x3E00
	.equiv LogBuffer, 0x3F00
	.equiv LogArgs, 0x4000
	.equiv LogFunc, 0x4100
	.equiv LogReportKernel, 0x4200
	.equiv LogRetrieve, 0x4300
	.equiv KeLoadContext, 0x4400
	.equiv KeProcYield, 0x4500
	.equiv save_fpu, 0x4600
	.equiv Driver_CopyFromSaveArea, 0x4700
	.equiv Driver_CopyToSaveArea, 0x4800
	.equiv SavesDone_ReadyToRelease, 0x4900
	.equiv SetAlarm, 0x4A00
	.equiv SetDABR, 0x4B00
	.equiv SetIABR, 0x4C00
	.equiv GetProcessInfo, 0x4D00
	.equiv GetCodegenVirtAddrRange, 0x4E00
	.equiv LoaderCall, 0x4F00
	.equiv RPLLoaderResumeContext, 0x5000
	.equiv WaitIopComplete, 0x5200
	.equiv FlushCode, 0x5300
	.equiv FlushData, 0x5400
	.equiv UpdateHeartbeat, 0x5500
	.equiv LogEntry, 0x5600
	.equiv FastClearMemory, 0x5700
	.equiv GetBusClockSpeed, 0x5800
	.equiv GetSharedArea, 0x5900
	.equiv SendPolicy, 0x5A00
	.equiv GetProcessIndex, 0x5B00
	.equiv IPCKDriver_PollLoaderCompletion, 0x5C00
	.equiv BlockLogSave, 0x5D00
	.equiv FinishInitandPreload, 0x5E00
	.equiv ContinueStartProcess, 0x5F00
	.equiv OpenMCP, 0x6000
	.equiv QuerySwitchReady, 0x6100
	.equiv launch_title, 0x6200
	.equiv call_title, 0x6300
	.equiv SetTimeInternal, 0x6400
	.equiv Nothing_blr, 0x6500
	.equiv ProfileEntry, 0x6600
	.equiv RequestFastExit, 0x6700
	.equiv CoreInitDone, 0x6800
	.equiv GetSwitchTarget, 0x6900
	.equiv AcquireDone, 0x6A00
	.equiv GetBuiltSDKVersion, 0x6B00
	.equiv SystemFatal, 0x6C00
	.equiv SwitchSecCodeGenMode, 0x6E00
	.equiv IopShell_RegisterCallback, 0x6F00
	.equiv GetTitleVersion, 0x7000
	.equiv IsTestKernel, 0x7100
	.equiv ForceFullRelaunch, 0x7200
	.equiv Recycle, 0x7300
	.equiv get_mode_flags, 0x7400
	.equiv QueryVirtAddr, 0x7500
	.equiv GetCodegenCore, 0x7600
	.equiv GetSecCodeGenMode, 0x7700
	.equiv CodegenCopy, 0x7800
	.equiv LoadShared, 0x7900
	.equiv SetExceptionCallback, 0x7A00
	.equiv IopShell_InjectCommand, 0x7B00
	.equiv Kill, 0x7C00
	.equiv EnableOverlayArena, 0x7D00
	.equiv DisableOverlayArena, 0x7E00
	.equiv GetSystemMode, 0x7F00
	.equiv SystemMode_RegisterCallback, 0x8000
	.equiv ZeroProcessMemory, 0x8100
	.equiv HandleIopPowerEvents, 0x8200
	.equiv ConsoleTimestamp, 0x8300
	.equiv ValidateOverlayRange, 0x8400
	.equiv BadSysCall, 0x8500

	# Macros
	.macro fastCall loc, args
		\args
		sc \loc@l
	.endm

	.macro sysCall loc, args
		\args
		li %a0, \loc@l
		sc
		nop
	.endm

	.macro moduleCall loc, args
	.if \loc == 0
	.err
	.endif
		\args
		bla \loc
	.endm

	.macro call loc, args
	.if \loc == 0
	.err
	.endif
		\args
	.if \loc != null
		lis %a0, \loc@h
		ori %a0, %a0, \loc@l
	.endif
		mtspr %ctr, %a0
		bctrl
	.endm

	.macro stackUpdate space
	stackUpdate.space = \space

	.if stackUpdate.space >= 0
		mfspr %a0, %lr
		stw %a0, 0x4 (%sp) # Stack[0x4]:4 <local_res4>
		stwu %sp, -0x8 - \space * 4 (%sp) # Stack[-0x8]:4 <local_8>
	.endif
	.endm

	.macro stackReset null
	.if stackUpdate.space >= 0
		lwz %a0, 0xC + stackUpdate.space * 4 (%sp) # <local_res4>
		mtspr %lr, %a0
		addi %sp, %sp, 0x8 + stackUpdate.space * 4
	.endif

	push = null
	.endm

	# Tools
	.macro KernelCopyData from, to, length
		moduleCall("DCFlushRange"), "lis %a3, \to@h; ori %a3, %a3, \to@l; li %a4, \length"

		bl \from

		sysCall("EffectiveToPhysical"), "mflr %a3"
		sysCall(0x2500)/* KernelCopyData */, "mr %a4, %a3; lis %a3, \to|0x80000000@h; ori %a3, %a3, \to|0x80000000@l; li %a5, \length"
	.endm

	.macro dereference source, depth1="null", depth2="null", depth3="null", depth4="null", depth5="null", depth6="null"
	dereference.source = \source
	dereference.source.16high = dereference.source >> 0x10
	dereference.source.16low = dereference.source % 0x10000

	.if dereference.source.16low >= 0x8000
		dereference.source.16high = dereference.source.16high + 1
	.endif
		
	.if \source != null
		lis r12, dereference.source.16high@l
		lwz r12, dereference.source.16low@l (r12)
	.endif

	.if \depth1 != null
		lwz r12, \depth1 (r12)
	.else
	.exitm
	.endif

	.if \depth2 != null
		lwz r12, \depth2 (r12)
	.else
	.exitm
	.endif

	.if \depth3 != null
		lwz r12, \depth3 (r12)
	.else
	.exitm
	.endif

	.if \depth4 != null
		lwz r12, \depth4 (r12)
	.else
	.exitm
	.endif

	.if \depth5 != null
		lwz r12, \depth5 (r12)
	.else
	.exitm
	.endif

	.if \depth6 != null
		lwz r12, \depth6 (r12)
	.else
	.exitm
	.endif
	.endm

	.macro push register
	push = push + 1

	.if \register == 0
	push.GPR00 = 0x8 + push * 4
		stw \register, push.GPR00 (%sp)
	.elseif \register == 1
	push.GPR01 = 0x8 + push * 4
		stw \register, push.GPR01  (%sp)
	.elseif \register == 2
	push.GPR02 = 0x8 + push * 4
		stw \register, push.GPR02  (%sp)
	.elseif \register == 3
	push.GPR03 = 0x8 + push * 4
		stw \register, push.GPR03  (%sp)
	.elseif \register == 4
	push.GPR04 = 0x8 + push * 4
		stw \register, push.GPR04  (%sp)
	.elseif \register == 5
	push.GPR05 = 0x8 + push * 4
		stw \register, push.GPR05  (%sp)
	.elseif \register == 6
	push.GPR06 = 0x8 + push * 4
		stw \register, push.GPR06  (%sp)
	.elseif \register == 7
	push.GPR07 = 0x8 + push * 4
		stw \register, push.GPR07  (%sp)
	.elseif \register == 8
	push.GPR08 = 0x8 + push * 4
		stw \register, push.GPR08  (%sp)
	.elseif \register == 9
	push.GPR09 = 0x8 + push * 4
		stw \register, push.GPR09  (%sp)
	.elseif \register == 10
	push.GPR10 = 0x8 + push * 4
		stw \register, push.GPR10  (%sp)
	.elseif \register == 11
	push.GPR11 = 0x8 + push * 4
		stw \register, push.GPR11  (%sp)
	.elseif \register == 12
	push.GPR12 = 0x8 + push * 4
		stw \register, push.GPR12  (%sp)
	.elseif \register == 13
	push.GPR13 = 0x8 + push * 4
		stw \register, push.GPR13  (%sp)
	.elseif \register == 14
	push.GPR14 = 0x8 + push * 4
		stw \register, push.GPR14  (%sp)
	.elseif \register == 15
	push.GPR15 = 0x8 + push * 4
		stw \register, push.GPR15  (%sp)
	.elseif \register == 16
	push.GPR16 = 0x8 + push * 4
		stw \register, push.GPR16  (%sp)
	.elseif \register == 17
	push.GPR17 = 0x8 + push * 4
		stw \register, push.GPR17  (%sp)
	.elseif \register == 18
	push.GPR18 = 0x8 + push * 4
		stw \register, push.GPR18  (%sp)
	.elseif \register == 19
	push.GPR19 = 0x8 + push * 4
		stw \register, push.GPR19  (%sp)
	.elseif \register == 20
	push.GPR20 = 0x8 + push * 4
		stw \register, push.GPR20  (%sp)
	.elseif \register == 21
	push.GPR21 = 0x8 + push * 4
		stw \register, push.GPR21  (%sp)
	.elseif \register == 22
	push.GPR22 = 0x8 + push * 4
		stw \register, push.GPR22  (%sp)
	.elseif \register == 23
	push.GPR23 = 0x8 + push * 4
		stw \register, push.GPR23  (%sp)
	.elseif \register == 24
	push.GPR24 = 0x8 + push * 4
		stw \register, push.GPR24  (%sp)
	.elseif \register == 25
	push.GPR25 = 0x8 + push * 4
		stw \register, push.GPR25  (%sp)
	.elseif \register == 26
	push.GPR26 = 0x8 + push * 4
		stw \register, push.GPR26  (%sp)
	.elseif \register == 27
	push.GPR27 = 0x8 + push * 4
		stw \register, push.GPR27  (%sp)
	.elseif \register == 28
	push.GPR28 = 0x8 + push * 4
		stw \register, push.GPR28  (%sp)
	.elseif \register == 29
	push.GPR29 = 0x8 + push * 4
		stw \register, push.GPR29  (%sp)
	.elseif \register == 30
	push.GPR30 = 0x8 + push * 4
		stw \register, push.GPR30  (%sp)
	.elseif \register == 31
	push.GPR31 = 0x8 + push * 4
		stw \register, push.GPR31  (%sp)
	.else
	.err
	.endif
	.endm

	.macro pushf register
	push = push + 1

	.if \register == 0
	push.FPR00 = 0x8 + push * 4
		stw \register, push.FPR00 (%sp)
	.elseif \register == 1
	push.FPR01 = 0x8 + push * 4
		stw \register, push.FPR01  (%sp)
	.elseif \register == 2
	push.FPR02 = 0x8 + push * 4
		stw \register, push.FPR02  (%sp)
	.elseif \register == 3
	push.FPR03 = 0x8 + push * 4
		stw \register, push.FPR03  (%sp)
	.elseif \register == 4
	push.FPR04 = 0x8 + push * 4
		stw \register, push.FPR04  (%sp)
	.elseif \register == 5
	push.FPR05 = 0x8 + push * 4
		stw \register, push.FPR05  (%sp)
	.elseif \register == 6
	push.FPR06 = 0x8 + push * 4
		stw \register, push.FPR06  (%sp)
	.elseif \register == 7
	push.FPR07 = 0x8 + push * 4
		stw \register, push.FPR07  (%sp)
	.elseif \register == 8
	push.FPR08 = 0x8 + push * 4
		stw \register, push.FPR08  (%sp)
	.elseif \register == 9
	push.FPR09 = 0x8 + push * 4
		stw \register, push.FPR09  (%sp)
	.elseif \register == 10
	push.FPR10 = 0x8 + push * 4
		stw \register, push.FPR10  (%sp)
	.elseif \register == 11
	push.FPR11 = 0x8 + push * 4
		stw \register, push.FPR11  (%sp)
	.elseif \register == 12
	push.FPR12 = 0x8 + push * 4
		stw \register, push.FPR12  (%sp)
	.elseif \register == 13
	push.FPR13 = 0x8 + push * 4
		stw \register, push.FPR13  (%sp)
	.elseif \register == 14
	push.FPR14 = 0x8 + push * 4
		stw \register, push.FPR14  (%sp)
	.elseif \register == 15
	push.FPR15 = 0x8 + push * 4
		stw \register, push.FPR15  (%sp)
	.elseif \register == 16
	push.FPR16 = 0x8 + push * 4
		stw \register, push.FPR16  (%sp)
	.elseif \register == 17
	push.FPR17 = 0x8 + push * 4
		stw \register, push.FPR17  (%sp)
	.elseif \register == 18
	push.FPR18 = 0x8 + push * 4
		stw \register, push.FPR18  (%sp)
	.elseif \register == 19
	push.FPR19 = 0x8 + push * 4
		stw \register, push.FPR19  (%sp)
	.elseif \register == 20
	push.FPR20 = 0x8 + push * 4
		stw \register, push.FPR20  (%sp)
	.elseif \register == 21
	push.FPR21 = 0x8 + push * 4
		stw \register, push.FPR21  (%sp)
	.elseif \register == 22
	push.FPR22 = 0x8 + push * 4
		stw \register, push.FPR22  (%sp)
	.elseif \register == 23
	push.FPR23 = 0x8 + push * 4
		stw \register, push.FPR23  (%sp)
	.elseif \register == 24
	push.FPR24 = 0x8 + push * 4
		stw \register, push.FPR24  (%sp)
	.elseif \register == 25
	push.FPR25 = 0x8 + push * 4
		stw \register, push.FPR25  (%sp)
	.elseif \register == 26
	push.FPR26 = 0x8 + push * 4
		stw \register, push.FPR26  (%sp)
	.elseif \register == 27
	push.FPR27 = 0x8 + push * 4
		stw \register, push.FPR27  (%sp)
	.elseif \register == 28
	push.FPR28 = 0x8 + push * 4
		stw \register, push.FPR28  (%sp)
	.elseif \register == 29
	push.FPR29 = 0x8 + push * 4
		stw \register, push.FPR29  (%sp)
	.elseif \register == 30
	push.FPR30 = 0x8 + push * 4
		stw \register, push.FPR30  (%sp)
	.elseif \register == 31
	push.FPR31 = 0x8 + push * 4
		stw \register, push.FPR31  (%sp)
	.else
	.err
	.endif
	.endm

	.macro pop register
	.if \register == 0
		lwz \register, push.GPR00 (%sp)
	.elseif \register == 1
		lwz \register, push.GPR01 (%sp)
	.elseif \register == 2
		lwz \register, push.GPR02 (%sp)
	.elseif \register == 3
		lwz \register, push.GPR03 (%sp)
	.elseif \register == 4
		lwz \register, push.GPR04 (%sp)
	.elseif \register == 5
		lwz \register, push.GPR05 (%sp)
	.elseif \register == 6
		lwz \register, push.GPR06 (%sp)
	.elseif \register == 7
		lwz \register, push.GPR07 (%sp)
	.elseif \register == 8
		lwz \register, push.GPR08 (%sp)
	.elseif \register == 9
		lwz \register, push.GPR09 (%sp)
	.elseif \register == 10
		lwz \register, push.GPR10 (%sp)
	.elseif \register == 11
		lwz \register, push.GPR11 (%sp)
	.elseif \register == 12
		lwz \register, push.GPR12 (%sp)
	.elseif \register == 13
		lwz \register, push.GPR13 (%sp)
	.elseif \register == 14
		lwz \register, push.GPR14 (%sp)
	.elseif \register == 15
		lwz \register, push.GPR15 (%sp)
	.elseif \register == 16
		lwz \register, push.GPR16 (%sp)
	.elseif \register == 17
		lwz \register, push.GPR17 (%sp)
	.elseif \register == 18
		lwz \register, push.GPR18 (%sp)
	.elseif \register == 19
		lwz \register, push.GPR19 (%sp)
	.elseif \register == 20
		lwz \register, push.GPR20 (%sp)
	.elseif \register == 21
		lwz \register, push.GPR21 (%sp)
	.elseif \register == 22
		lwz \register, push.GPR22 (%sp)
	.elseif \register == 23
		lwz \register, push.GPR23 (%sp)
	.elseif \register == 24
		lwz \register, push.GPR24 (%sp)
	.elseif \register == 25
		lwz \register, push.GPR25 (%sp)
	.elseif \register == 26
		lwz \register, push.GPR26 (%sp)
	.elseif \register == 27
		lwz \register, push.GPR27 (%sp)
	.elseif \register == 28
		lwz \register, push.GPR28 (%sp)
	.elseif \register == 29
		lwz \register, push.GPR29 (%sp)
	.elseif \register == 30
		lwz \register, push.GPR30 (%sp)
	.elseif \register == 31
		lwz \register, push.GPR31 (%sp)
	.elseif \register == 30
		lwz \register, push.GPR30  (%sp)
	.elseif \register == 31
		lwz \register, push.GPR31  (%sp)
	.else
	.err
	.endif
	.endm

	.macro popf register
	.if \register == 0
		lfs \register, push.FPR00 (%sp)
	.elseif \register == 1
		lfs \register, push.FPR01 (%sp)
	.elseif \register == 2
		lfs \register, push.FPR02 (%sp)
	.elseif \register == 3
		lfs \register, push.FPR03 (%sp)
	.elseif \register == 4
		lfs \register, push.FPR04 (%sp)
	.elseif \register == 5
		lfs \register, push.FPR05 (%sp)
	.elseif \register == 6
		lfs \register, push.FPR06 (%sp)
	.elseif \register == 7
		lfs \register, push.FPR07 (%sp)
	.elseif \register == 8
		lfs \register, push.FPR08 (%sp)
	.elseif \register == 9
		lfs \register, push.FPR09 (%sp)
	.elseif \register == 10
		lfs \register, push.FPR10 (%sp)
	.elseif \register == 11
		lfs \register, push.FPR11 (%sp)
	.elseif \register == 12
		lfs \register, push.FPR12 (%sp)
	.elseif \register == 13
		lfs \register, push.FPR13 (%sp)
	.elseif \register == 14
		lfs \register, push.FPR14 (%sp)
	.elseif \register == 15
		lfs \register, push.FPR15 (%sp)
	.elseif \register == 16
		lfs \register, push.FPR16 (%sp)
	.elseif \register == 17
		lfs \register, push.FPR17 (%sp)
	.elseif \register == 18
		lfs \register, push.FPR18 (%sp)
	.elseif \register == 19
		lfs \register, push.FPR19 (%sp)
	.elseif \register == 20
		lfs \register, push.FPR20 (%sp)
	.elseif \register == 21
		lfs \register, push.FPR21 (%sp)
	.elseif \register == 22
		lfs \register, push.FPR22 (%sp)
	.elseif \register == 23
		lfs \register, push.FPR23 (%sp)
	.elseif \register == 24
		lfs \register, push.FPR24 (%sp)
	.elseif \register == 25
		lfs \register, push.FPR25 (%sp)
	.elseif \register == 26
		lfs \register, push.FPR26 (%sp)
	.elseif \register == 27
		lfs \register, push.FPR27 (%sp)
	.elseif \register == 28
		lfs \register, push.FPR28 (%sp)
	.elseif \register == 29
		lfs \register, push.FPR29 (%sp)
	.elseif \register == 30
		lfs \register, push.FPR30 (%sp)
	.elseif \register == 31
		lfs \register, push.FPR31 (%sp)
	.elseif \register == 30
		lfs \register, push.FPR30  (%sp)
	.elseif \register == 31
		lfs \register, push.FPR31  (%sp)
	.else
	.err
	.endif
	.endm