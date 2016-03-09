help = ->
  str = """
Manage your Windows apps from command line.

Usage:
  medic [command] [options]

Commands:
  update, list, reset, help

Options:
  --id

Examples:
  medic update --id="APP_ID"  creates new submission of app in the store
  medic list                  print list of all your apps
  medic reset                 delete cache and all medic settings
        """

  console.log str

# Creates new submission in the store for the app.
# export
module.exports = help