### Aliases ###

# Navigation
# Open DJ project, source the virtual environment and delete all of the merged branches
alias wdj "cd ~/Projects/dj_sanction_lists/dj_sanction_lists_spiders ; 
source venv/bin/activate.fish ; git branch --merged | grep -E -v '(^\*|master|staging|integration|dev|adp)' | xargs git branch -d 2>/dev/null"

# Open RnC project and source poetry
alias wrnc "cd ~/Projects/rnc_internal/rnc_internal_spiders ; poetry shell"

# Scripts
# usage: rescrape <spider_name> <num_runs>
alias rescrape "~/Scripts/rescrape.sh"
