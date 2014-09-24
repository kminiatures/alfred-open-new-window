on replace(src, tg, rp)
  set oldDel to AppleScript's text item delimiters
  set AppleScript's text item delimiters to tg
  set myList to text items of src
  set AppleScript's text item delimiters to rp
  set myText to myList as string
  set AppleScript's text item delimiters to oldDel
  return myText
end replace

on search_app(_folder, _app_name)
  set AppList to list folder _folder without invisibles
  repeat with a_app in AppList
    if a_app contains _app_name then
      return a_app
    end if
  end repeat
end search_app

property UP_ARROW : 126
property DOWN_ARROW : 125
property RETURN_KEY : 36

on open_new_window(app_name)
  tell application "Dock"
    activate
  end tell
  tell application "System Events"
    tell process "Dock"
      tell list 1
        perform action "AXShowMenu" of UI element app_name
        tell UI element app_name
          tell menu 1
            pick menu item "新規ウインドウ"
          end tell
        end tell
      end tell
    end tell
  end tell
end open_new_window

on run argv
  if count of argv is 0
    if _query is "{" & "query}" then
      set _query to "MacVim"
    end if
  else
    set _query to item 1 of argv
  end if

  set _query to replace(_query, "/Applications/", "")

  set _app to search_app("Macintosh HD:Applications:", _query)
  set app_name to replace(_app, ".app", "")

  if application _app is not running then
    tell application _app to launch
    activate application _app
  else
    open_new_window(app_name)
  end if
end run
