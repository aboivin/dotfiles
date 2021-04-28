current = window.get_active_class().lower()
if 'terminator' in current.lower():
   keyboard.send_keys('<ctrl>+l')
   keyboard.send_keys('cd ~/**')
   keyboard.send_keys('<tab>')
else: 
   window.activate('terminator.Terminator', switchDesktop=True, matchClass=True)