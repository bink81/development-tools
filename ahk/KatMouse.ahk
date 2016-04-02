CoordMode, Mouse, Screen
return
#MaxHotkeysPerInterval 200
WheelUp::
   MouseGetPos, m_x, m_y
   hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

   ; WM_MOUSEWHEEL
   ;   WHEEL_DELTA = 120
   SendMessage, 0x20A, 120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
return

WheelDown::
   MouseGetPos, m_x, m_y
   hw_m_target := DllCall( "WindowFromPoint", "int", m_x, "int", m_y )

   ; WM_MOUSEWHEEL
   ;   WHEEL_DELTA = 120
   SendMessage, 0x20A, -120 << 16, ( m_y << 16 )|m_x,, ahk_id %hw_m_target%
return