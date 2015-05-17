#include "Attack.au3"
#include "Config.au3"
#include "GUIControl.au3"
#include "GUIDesign.au3"
#include "PrepareAttack.au3"
#include "PrepNextBattle.au3"
#include "ReadyCheck.au3"
#include "Search.au3"

$StratNames = "Standard"

Global $prevTroopComp = -1
Global $BarbariansComp, $ArchersComp, $GiantsComp, $GoblinsComp, $WBComp
Global $fullarmy, $fullSpellFactory
Global $stuckCount = 0
