current = window.get_active_class().lower()
if 'slack' in current:
    keyboard.send_keys('<ctrl>+t')   
else:
    #keyboard.send_keys('<backspace>')  
    window.activate('slack.Slack', switchDesktop=True, matchClass=True)
