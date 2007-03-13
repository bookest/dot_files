from pprint import pprint as pp
from pdb import pm
import os
import sys

def has_readline():
    try:
        import readline
        return True
    except ImportError:
        return False

    
def setup_history():
    """Setup a persisitent history file."""
    import os
    import readline
    histfile = os.path.join(os.environ["HOME"], ".pyhist")
    try:
        readline.read_history_file(histfile)
    except IOError:
        pass
    import atexit
    atexit.register(readline.write_history_file, histfile)

    
def setup_completer():
    """Setup readline completetion."""
    import readline
    import rlcompleter
    readline.parse_and_bind("tab: complete")


def setup_prompt():
    import os
    import sys
    BLUE = "\033[1;34m"
    NOCOLOR = "\033[0m"
    if os.environ['TERM'] != 'dumb':
        sys.ps1 = "%s>>> %s" % (BLUE, NOCOLOR)

        
if has_readline():
    setup_history()
    setup_completer()

    def hcl():
        """Clear readline history."""
        try:
            clear = raw_input("Clear history? [y|N]: ")
            if clear in ('y', 'Y', 'yes', 'Yes'):
                import readline
                readline.clear_history()

        except EOFError:
            pass

           
setup_prompt()
        
del(has_readline, setup_history, setup_completer, setup_prompt)
