from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class dcat(ColorScheme):
    progress_bar_color = white

    def use(self, context):
      if context.text:
        if context.highlight:
          attr |= reverse
      if context.in_browser or context.in_titlebar or context.in_statusbar:
        if context.selected:
          return 253, 252, bold
        return white, black, normal
      return black, white, normal
