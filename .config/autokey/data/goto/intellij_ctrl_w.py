selection = ''
keyboard.send_keys('<shift>+<home>')
time.sleep(0.02)
pos = len(clipboard.get_selection())

keyboard.send_keys('<home><shift>+<end>')
time.sleep(0.01)
line = clipboard.get_selection()
time.sleep(0.01)

right = 0;
while pos + right < len(line) and not line[pos+right].isupper() and line[pos+right] not in [' ', '_', '-']:
    right = right + 1  
    

left = 0;
while pos -1 -left >= 0 and not line[pos-1-left].isupper() and line[pos-1-left] not in [' ', '_', '-']:
    left = left + 1

#dialog.info_dialog('pos', 'pos: ' + str(pos) + ' left: ' + str(left) + ' right: ' + str(right))


command = '<left>'
for i in range(pos-left):
    command = command + '<right>'
command = command + '<shift>'
for i in range(left+right):
    command = command + '<shift>+<right>'


keyboard.send_keys(command)
