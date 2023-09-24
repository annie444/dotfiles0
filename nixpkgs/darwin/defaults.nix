{
  system.defaults.NSGlobalDomain = {
    "com.apple.keyboard.fnState" = false;
    "com.apple.mouse.tapBehavior" = null;
    "com.apple.sound.beep.feedback" = 1;
    "com.apple.sound.beep.volume" = 1.000;
    "com.apple.springing.delay" = 0.5;
    "com.apple.springing.enabled" = true;
    "com.apple.swipescrolldirection" = true;
    "com.apple.trackpad.enableSecondaryClick" = true;
    "com.apple.trackpad.scaling" = 2.0;
    "com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    _HIHideMenuBar = false;
    AppleEnableMouseSwipeNavigateWithScrolls = true;
    AppleEnableSwipeNavigateWithScrolls = true;
    AppleFontSmoothing = 2;
    AppleICUForce24HourTime = true;
    AppleInterfaceStyleSwitchesAutomatically = true;
    AppleKeyboardUIMode = 3;
    AppleMeasurementUnits = "Inches";
    AppleMetricUnits = 0;
    ApplePressAndHoldEnabled = true;
    AppleScrollerPagingBehavior = true;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    AppleShowScrollBars = "Automatic";
    AppleTemperatureUnit = "Fahrenheit";
    AppleWindowTabbingMode = "always";
    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    NSAutomaticCapitalizationEnabled = true;
    NSAutomaticDashSubstitutionEnabled = true;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = true;
    NSAutomaticSpellingCorrectionEnabled = true;
    NSAutomaticWindowAnimationsEnabled = true;
    NSDisableAutomaticTermination = false;
    NSDocumentSaveNewDocumentsToCloud = true;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    NSScrollAnimationEnabled = true;
    NSTableViewDefaultSizeMode = 2;
    NSTextShowsControlCharacters = false;
    NSUseAnimatedFocusRing = true;
    NSWindowResizeTime = 0.2;
    PMPrintingExpandedStateForPrint = true;
    PMPrintingExpandedStateForPrint2 = true;
  };

  system.checks.verifyNixChannels = true;
  system.checks.verifyNixPath = true;

  # Firewall
  system.defaults.alf = {
    globalstate = 1;
    allowsignedenabled = 1;
    allowdownloadsignedenabled = 1;
    stealthenabled = 1;
    loggingenabled = 1;
  };

  system.defaults.ActivityMonitor = {
    IconType = 5;
    OpenMainWindow = true;
    ShowCategory = 105;
    SortColumn = "CPUUsage";
    SortDirection = 0;
  };

  system.defaults.screencapture = {
    disable-shadow = false;
    location = "{$HOME}/Desktop";
    type = "png";
  };

  # Dock and Mission Control
  system.defaults.dock = {
    appswitcher-all-displays = true;
    enable-spring-load-actions-on-all-items = true;
    expose-animation-duration = 0.5;
    largesize = null;
    launchanim = true;
    mineffect = "genie";
    minimize-to-application = false;
    orientation = "bottom";
    show-process-indicators = true;
    show-recents = true;
    showhidden = false;
    autohide = false;
    expose-group-by-app = false;
    mru-spaces = false;
    tilesize = 64;
    wvous-bl-corner = 1;
    wvous-br-corner = 1;
    wvous-tl-corner = 5;
    wvous-tr-corner = 12;
  };

  # Login and lock screen
  system.defaults.loginwindow = {
    GuestEnabled = false;
    DisableConsoleAccess = true;
    PowerOffDisabledWhileLoggedIn = false;
    RestartDisabled = false;
    RestartDisabledWhileLoggedIn = false;
    SHOWFULLNAME = false;
    ShutDownDisabled = false;
    ShutDownDisabledWhileLoggedIn = false;
    SleepDisabled = false;
  };
  
  # Menubar clock
  system.defaults.menuExtraClock = {
    IsAnalog = false;
    Show24Hour = true;
    ShowAMPM = false;
    ShowDate = 0;
    ShowDayOfMonth = true;
    ShowDayOfWeek = true;
    ShowSeconds = false;
  };

  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

  system.defaults.smb = {
    NetBIOSName = "AnnieMBP";
    ServerDescription = "Annie’s MacBook Pro";
  };

  # Spaces
  system.defaults.spaces.spans-displays = false;

  # Trackpad
  system.defaults.trackpad = {
    ActuationStrength = 1;
    Dragging = false;
    FirstClickThreshold = 1;
    SecondClickThreshold = 1;
    TrackpadThreeFingerDrag = false;
    Clicking = true;
    TrackpadRightClick = true;
  };

  # Finder
  system.defaults.finder = {
    _FXShowPosixPathInTitle = false;
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    CreateDesktop = true;
    FXPreferredViewStyle = "Nlsv";
    QuitMenuItem = false;
    ShowPathbar = true;
    ShowStatusBar = true;
    FXEnableExtensionChangeWarning = true;
  };
}
