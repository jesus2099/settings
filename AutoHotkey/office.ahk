﻿groupadd notesInbox, Courrier - Courrier en arrivée - IBM Lotus Notes ahk_exe notes2.exe, , , Entrez votre code P&IN

; -----------------------*-------------- fin var début macros -*--------------------------------------
; !alt +shift ^ctrl #win

menu, tray, icon, %programfiles% (x86)\Notes-852\notes.exe

; ###################################
; win7 : BACKSPACE hack comme dans XP
; ###################################

#IfWinActive, ahk_class CabinetWClass
$backspace::
	ControlGet renamestatus,Visible,,Edit1,A
	ControlGetFocus focussed, A
	if (renamestatus!=1&&(focussed="DirectUIHWND3"||focussed="SysTreeView321")) {
		sendinput !{up}
	} else {
		sendinput {backspace}
	}
#IfWinActive
return

#IfWinActive ahk_exe notes2.exe ;-------------------- LOTUS NOTES (rédaction)
^f:: ;rechercher
	send !v
	sleep 100
	sendinput u
	return
;^s:: ;(texte) souligné et vert
;	WinMenuSelectItem, , , texte, souligné
;	WinMenuSelectItem, , , texte, couleur, vert foncé
;	return
^r:: ;(texte) rayé et rouge
	WinMenuSelectItem, , , texte, barré
	WinMenuSelectItem, , , texte, couleur, rouge
	return
^l::
	sendinput ^s
	currentkeydelay := A_KeyDelay
	setkeydelay 100
	send !cy
	setkeydelay currentkeydelay
	return
+^f:: ;FRANÇAIS(FR)
	sendinput ^y
	winwait ahk_class ibw:0, InfoBox DLL, 1
	if not ErrorLevel {
		coordmode, caret, window
		mouseclick, left, A_CaretX+80, A_CaretY+120
		winwait ahk_class ibw:2, InfoBox DLL, 1
		if not ErrorLevel {
			sendinput {home}g{up 3}{enter}{esc}
		}
	}
	return
+^e:: ;ENGLISH(UK)
	sendinput ^y
	winwait ahk_class ibw:0, InfoBox DLL, 1
	if not ErrorLevel {
		coordmode, caret, window
		mouseclick, left, A_CaretX+80, A_CaretY+120
		winwait ahk_class ibw:2, InfoBox DLL, 1
		if not ErrorLevel {
			sendinput {home}b{up 17}{enter}{esc}
		}
	}
	return
#IfWinActive ahk_group notesInbox
$F9::
	currentkeydelay := A_KeyDelay
	setkeydelay 100
	send {F9}!flr
	setkeydelay currentkeydelay
	winwait Réplication de Tristan Daniel
	ifwinnotactive Réplication de Tristan Daniel, , winactivate, Réplication de Tristan Daniel
	winwaitactive Réplication de Tristan Daniel
	sendinput !e{enter}
	return

; SUPER FIN ----------------------------------------------------------------------------------------------------------------------
return
return