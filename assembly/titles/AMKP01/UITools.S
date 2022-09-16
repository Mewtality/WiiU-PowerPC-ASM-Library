		b _start
	.func printDialog
_printDialog:
		stackUpdate(3)
		push(29); push(30); push(31)

		dereference("GUIManagement"), 0x10, 0x4
		lwz r31, 0x1C (r12)
		mr r30, %a3
		mr r29, %a4

		call("ui_Page_Dialog_isClose"), "mr %a3, r31"
		cmpwi %a3, 0
		beq _printDialogEnd

		call("ui_Page_Dialog_in"), "mr %a3, r31"

		mr %a3, r30
		lwz r12, 0x5AC (r31)
		lwz %a4, 0x5C (r12)
		li %a5, -1
		li %a6, 1
		call("ui_RegisterScalableFontText")

		mr %a3, r29
		lwz r12, 0x5CC (r31)
		lwz %a4, 0xF4 (r12)
		li %a5, -1
		li %a6, 1
		call("ui_RegisterScalableFontText")

_printDialogEnd:
		pop(29); pop(30); pop(31)
		stackReset()
		blr
	.endfunc