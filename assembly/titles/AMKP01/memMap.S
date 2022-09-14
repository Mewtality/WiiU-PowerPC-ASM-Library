/*
* File: memMap.S
* Author: Mewtality
* Date: 2022-09-06 20:34:05
* YouTube: https://www.youtube.com/c/Mewtality
* Discord: Mewtality#0666
*/
	.equiv section_rodata, 0x10000000
	.equiv section_data, 0x101805E0
	.equiv section_bss, 0x101AA500
	.equiv section_module_id, 0x106AC400

	.equiv offsetDiffFromTurboDemo, 0x502200

	.equiv _text, 0x0E180020
	.equiv _rodata, offsetDiffFromTurboDemo + section_rodata # 0x10502200
	.equiv _data, offsetDiffFromTurboDemo + section_data
	.equiv _bss, offsetDiffFromTurboDemo + section_bss
	.equiv _module_id, offsetDiffFromTurboDemo + section_module_id

	# Common Addresses
	.equiv cameraManagement, _data + 0x820 # 0x10683000
	.equiv raceManagement, _data + 0x7F2C # 0x1068A70C
	.equiv menuManagement, _data + 0x7F58 # 0x1068A738
	.equiv raceKartManagement, _data + 0x7F38 # 0x1068A718
	.equiv itemDirector, _data + 0x7F3C # 0x1068A71C
	.equiv GUIManagement, _data + 0x9B8C # 0x1068C36C

	.equiv static.address, _bss + 0x43900 # 0x106F0000
