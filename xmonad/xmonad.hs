import XMonad
import XMonad.Config.Gnome
import XMonad.Layout.Gaps

myLayouts = gaps [(U, 24)] $ layoutHook gnomeConfig

myManageHook = composeAll (
                           [
                            manageHook gnomeConfig
                           , className =? "Unity-2d-panel" --> doIgnore
                           , className =? "Unity-2d-launcher" --> doIgnore
                           ])

main = xmonad gnomeConfig
       { modMask = mod4Mask
       , manageHook = myManageHook
       , layoutHook = myLayouts
       , focusFollowsMouse = False
       }
