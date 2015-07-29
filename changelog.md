## Change Log:

### v3.2.0 Final
* MASSIVE stability improvements
* Some DARK TROOPS ARE BACK! ...mostly... -- this feature remains BETA!
* Bot no longer makes computer unresponsive during image searches
* Added King/Queen upgrading (thanks obudu)
* Added reduce memory function to clean up unused resources periodically (thanks Hungrypoo)
* Added new option to switch to experience mode if you reach specified criteria
* Added full dark elixir storage as a criteria to halt bot
* GUI config for upgrade now properly saved (Thanks drummernick12)
* PushBullet now includes date and time in messages (Thanks slam666)
* Incorporated new experience mode that uses AQ or BK (Thanks drummernick12)
* Improved army camp detection when text is obstructed
* Clicking "Attack now" now respects the proper type of attack to perform based on base being live or dead
* Modified troop lab upgrading to work when Golems are selected
* Updated language files (Thanks Electroz)
* Added new sum option for resources
* When using fewer than 4 sided attack, sides are now randomized
* Added donate while idling if a new request is made
* Improved text detection
* Improvements to work on multiple COC game languages other than English
* Modifications to restarting BlueStacks for consistency
* Bug fixes for experience mode (thanks drummernick12)
* Fixed bug that crashed in certain instances when training custom troops
* Fixed troop deployment speeds
* Fixed sniping in correct location
* Fixed CC deployment
* Fixed King/Queen being detected
* Fixed King/Queen activation on low health
* Fixed number of troops on sides being more consistent
* Fixed bot not training wallbreakers in barracks mode
* Fixed lab upgrading for those w/ maxed out laboratories (thanks obudu)

### v3.1.0
* Custom troops fixed, you no longer just have to use barracks training
* Modified sniping - improved, but still occasionally having a few issues with attacking wrong side of base, please continue bringing incorrect behaviour to our attention
* Longer time available to click "Attack Now" button
* King/Queen activation modified
* Better stopping attack during snipe if you have gained a star
* More text reading improvements
* Fixed behaviour when using donate/train only mode
* More non English languages now supported - if you find issues, please report them and use English
* Various crashes fixed

### v3.0.5 BETA
* Fixed early return home
* Sniping:  Now leaves after one star is achieved
* CC troops can now be deployed
* Zapping will now zap DE pumps of dead bases
* Multi-language support is hopefully restored

### v3.0.0 BETA
* Compatible with Clash of Clans™ July 2015 Update - but not yet optimized in order to get you up and getting loot faster as we continue development.
* "My Stats" submission. Results of your earnings can now be submitted and viewed online.  This will allow you to monitor and trend your income over time, in 15min increments. Click “My Stats” in the forum navigation to view.
* - On "Services" tab enter username and password for BrokenBot.org forums and click on the validate button.  If your settings are correct then it will change to say “VALID”. Don't worry about password field being empty after clicking the button, it is now stored encrypted on your computer away from all other BrokenBot files.
* - BrokenBot will attempt to submit after every attack but will only succeed every 15min to limit the load on the server. Do not worry if you see it fail submitting as long as your username and password are verified in the “Services” tab. It will re-attempt.
* "Stats" tab. The stats are now correctly read and summarized in this tab of the bot.
* New donation text and resource reading. We have implemented our brand new text and number reading functionality. No more will the bot stop reading after not knowing a letter or a symbol! Finally perfect donations for all.
* Town Hall sniping. Now if the bot attacks a Town Hall by sniping, either based on search conditions page or the “Snipe if trophies below” setting, it will send out a “trickle attack”.  BrokenBot sends progressively larger waves if it does not recognize a loot change or there has been a long delay.  The bot stops deploying more troops once you have earned one star. The order of troops is hardcoded, but it starts with barbarians and archers and progressively adds stronger troops including heroes and your clan castle if things get really bad if selected/available.
* New UI option on “General” tab: "Snipe if trophies below". Enter a number here and if you have fewer trophies than this value, it will snipe both live and dead outside Town Halls to bring your trophy count up. Will continue using normal search conditions and attacks at the same time if a target is found.
* Collector attacking. You can now focus attacks on the resource collectors.  There are 2 options available described below.  They can be chosen on the attack methods tab.  Both methods must temporarily activate red-line mode if you don't have it already active.  They will only focus attacks on those collectors near the outer edges of the base (existence of walls does not mean the collector is inside).
* - Attack collectors - deploy all troops: This method will deploy all the troops you have, spread out among all the collectors.
* - Attack collectors - troop saver: This method deploys a few troops on some of the collectors. Once the income has stopped it checks to see what collectors are still left standing and if you haven't already sent troops there it does another round of attacking.
* Clear the Field.  Checking "Clear the Field" on the "Misc" tab will have the bot remove obstacles that it finds if you have a free builder.  It will only remove up to 5 obstacles with each loop.  Also it will not touch your holiday themed obstacles so those are safe.
* BrokenBot attack visualization / Debug Mode.  If you have debug mode checked then you can actually see what the bot is trying to attack and where it is dropping troops as it works.  Works best with background mode activated but will try to show you its actions even if you don't have it on.  If you do have background mode on and BlueStacks isn't hidden then it will pop up on top of any other work you may be doing.
* Dark Elixir Zapping - BrokenBot will now zap DE Drills due to the Clash of Clans™ July 2015 update. We are aware that it will zap regardless of the base being dead or alive and will resolve shortly.
* Modified decision to return home.  Will now return home quicker if the battle is completely ended, and will start the delay again if it senses a change in loot.  Previously if your loot stopped changing then it would return home after a set time even if you starting gaining loot again.
* Changed the way attack delays are processed.  You now get more accurate and consistent (but still randomized) delays between dropping troops and waves of troops.  Also modified available choices for troop delay for those that want an even longer delay between deploying troops.
* Cost per search.  This is now implemented fully automatically.
* Average hourly income stats. These are only shown in the log (GUI is crowded enough) and are shown after each attack. “Stat submission” must be enabled to view this information.
* Lower CPU utilization. Changed bot to use less CPU when idling.  Thanks w0lv3r1nixclash
* "PushBullet" tab renamed to "Services".

### v2.8.0
* Major stability enhancements
* Speed optimization - we cut the time it takes to find a well hidden TH by 60% from our previous release. It now takes 1.2sec on average vs never finding it or taking 20 seconds like our competitors.  **speedBoost must be enabled.
* Precision enhancements - We have reduced our image recognition error rate from 4% down to 2.4% - Nearly 10 times better than other bots!
* Resource collection - we had to lower the thresholds to make sure we collect some of your harder to detect resources. The side-effect is you will see it clicking walls sometimes for a fraction of a second. This is expected and controlled, it will not perform an erroneous action.
* Implemented speedBoost - found on the config tab. Check this to locate DE and TH faster at the cost of more CPU load during searching.
* Fixed PushBullet. We now check the server for up to 3 new commands once every minute.  Bot may respond to commands slightly slower but this will prevent us from being blocked from using their servers.
* Various bug fixes related to searching.

### v2.7.1
* Improved townhall recognition.  No, seriously.  It is so much better than it was before!  No more trying to attack outside townhalls that don't exist or skipping over perfectly good bases with tons of loot just because the bot can't recognize the townhall.
* Some more dark elixir storage tweaks.  We are trying to make sure you don't waste those zaps.
* Moved resource collection to our improved image recognition system.

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