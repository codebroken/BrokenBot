## Change Log:

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