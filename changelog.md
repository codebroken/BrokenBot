## Change Log:

### v2.7.0
* Improved image recognition system.  Does a much better job of finding the dark elixir storage.
* Search delay is randomized now.  You still use the same UI selection for the general speed of searching but the actual speed is randomized near the value you select.
* Donation blacklist now added.  If you check the box to turn on blacklist then it will not donate to people if the words you list are anywhere in the request text.
* You may now specify having a King or Queen available as a search condition. For example: if you specify that you require the King and Queen both for live bases then it will only search for dead bases until your King or Queen are available.
* Hid some options for upgrading that didn't function properly. Will be reinstated once fixed.
* Main loop sped up.  Less time just sitting there waiting while it's doing something.
* Various speed and stability improvements.

### v2.6.0
* Much faster troop deployment.  Might not want to do 1/1 anymore
* Temporary fix for those whose camp numbers can't be read. Unfortunately this may reintroduce a problem where training gets stuck for those people.  If you have this issue please temporarily use barracks training mode until this can be fully fixed.

### v2.5.9
* Emergency fix for occasional crash

### v2.5.8
* Additional randomization for deployment of troops and deploy timing
* Removed "randomize" check box, it was terrible method of randomization.  You are now always somewhat randomized, but you can modify the average delay by adjusting the unit delay and wave delay
* Pushbullet last raid now sends how much loot was available
* Pushbullet village report is now not sent until at least 1 hour has passed
* Pushbullet now has multi-user support.  Add your village name to settings page and all new messages will be appended with [username] so you can keep your bots straight.  Additionally bot commands should now have your user name added at the end so you are sending it to the correct bot (for example: "bot pause broken")
* Bug report removes your username to prevent you accidentally uploading that information
* Modified bug reporting button to include settings on your current strategy

### v2.5.7
* Fixed pushbullet pause command, if you pause mid-battle by pushbullet then the pause will not take effect until you have returned to main screen
* Allow user to pause bot at just about anytime if they actually click the button
* Fix added for wall breaker not being recognized
* Modified troop training order to start with troops that take longer to produce
* Significant modification to trophy dropping.  Now will zap DE if you have spells available and there is enough DE in there as entered into the Strategies/Spells/Zap field.  Will next drop king or queen if available.  Finally will resort to any other troop you have.  Additionally the location of the drop has been randomized and it uses red-line detection.

### v2.5.6
* Fix for bot thinking it is making troops but barracks aren't making anything
* Failsafe added so that it will eventually start attacking even without full army camp if it gets really stuck (such as you have 199/200 troops but all barracks are trying to make giants)
* Increased amount of information sent out in push bullet messages
* Added customizable decreases in required loot levels for searching

### v2.5.5
* Fix for having alternate language selected but still displaying English

### v2.5.4
* Fixed spells not being detected
* Fix for archers not being detected
* DLL update for resolving those few people that still had an issue

### v2.5.3
* Fixed display of townhall levels in search results.
* Fixed color recognition for archers.
* Added hidden setting for adjusting font size of log.  Add it to the [hidden] section of your ini file.  For example: "fontsize=6"

### v2.5.2
* Improved auto-update.  Now bot actually can download and apply the update for you.
* Improved DLL error detection. Informs the user if they are missing the proper version and directs them about how to resolve. Falls back to dropping troops at the edge if DLL isn't working.

### v2.5.1
* Added DLL dependancy for some machines that may be missing it.

### v2.5.0
* Initially tracked release.  Future releases to include full changelog to track all progress.
* Modification of red-line attacking.  Near instantaneous now.  Additionally added GUI control that allows you to set how certain you want to be of deployment.  All the way to the left will be closer but generate more errors, while all the way to the right will launch troops at the edges of the map.
* Addition of multilingual support.  Simply add a new language.ini file to the BrokenBot.org\languages folder.  The bot will automatically recognize the addition.  Make a translation for each key listed in the English.ini file.  Anytime you are using a different language and a key is not found it will automatically default back to English.
* Incorporation of bug fixes and stability improvements from Cool7su.
* Improved wall images.