current = window.get_active_class().lower()
if 'jetbrains-idea' not in current.lower():
   window.activate('jetbrains-idea.jetbrains-idea', switchDesktop=True, matchClass=True)
