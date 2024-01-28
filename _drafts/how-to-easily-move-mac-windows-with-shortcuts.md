---
layout: post
title: How To Easily Move Mac Windows With Shortcuts
subtitle: Craft products better with better systematic design judgment
banner:
  image: "/assets/images/newbusinessflowchart/pro.png)"
  opacity: 0.3
category: Engineering/General/Philosophy/History/Social Sciences/Natural Sciences/Applied
  Sciences/Arts/Sports/HealthAndMedicine/LanguageAndLiterature/CultureAndEducation/GeographyHistoryAndBiography/Kindle/BusinessAndManagement
tags: Hardware/Software/Network/Security/Software Engineering/InformationSystems/ArtificialIntelligence/TheoryOfComputation/Human-ComputerInteraction
---
How To Easily Move Mac Windows With Shortcuts

## 



https://github.com/eczarny/spectacle

例えば、「Magnet」、「BetterSnapTool」、「Spectacle」などのアプリケーションを使用することで、キーボードショートカットをカスタマイズし、ウィンドウの移動やサイズ変更を簡単に行うことができます。
これらのアプリは、ウィンドウを画面の特定の部分にスナップさせる、特定のサイズに変更するなど、様々な便利な機能を提供します。
AutomatorやAppleScriptの使用:

MacにはAutomatorやAppleScriptといった強力なツールが内蔵されており、これらを使用してウィンドウを移動するためのショートカットを作成することができます。
これは少し高度な方法ですが、カスタムスクリプトを作成して特定のキー操作でウィンドウを移動させることが可能

```
tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    set frontAppName to name of first application process whose frontmost is true
    tell process frontAppName
        set frontWindow to window 1
        set {windowX, windowY, windowWidth, windowHeight} to bounds of frontWindow
        set screenWidth to do shell script "defaults read /Library/Preferences/com.apple.windowserver DisplayResolutionWidth"
        set screenHeight to do shell script "defaults read /Library/Preferences/com.apple.windowserver DisplayResolutionHeight"
        set newWidth to screenWidth / 2
        set newHeight to screenHeight
        set newBounds to {newWidth, windowY, screenWidth, windowHeight}
        set bounds of frontWindow to newBounds
    end tell
end tell
``` 
