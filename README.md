# visit
oh-my-zsh custom plugin for faster navigation

Created by Justin Chang

### installation
Clone this repository into oh-my-zsh's plugin folder (`~/.oh-my-zsh/plugins/` by default).

### usage
- `visit FOO`: Change directory to FOO and mark current directory as the origin.
- `back`: If not in origin directory, navigate to origin. If in origin directory, navigate to last location this command was invoked from.
- `origin`: List origin and visit locations.
