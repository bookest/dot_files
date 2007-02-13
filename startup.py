from pprint import pprint as pp
from pdb import pm

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
    
if has_readline():
    setup_history()
    setup_completer()

del(has_readline, setup_history, setup_completer)
