# Command to set Window title
function wtitle() {
  wmctrl -r :ACTIVE: -T "$*"
}
