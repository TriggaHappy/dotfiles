# ----------------------------------------------------
# HELPERS
# ----------------------------------------------------

## help: print this help message
.PHONY: help 
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /'

## confirm: helper to confirm commands
.PHONY: confirm
confirm:
	@echo -n 'Are you sure? [y/N]' && read ans && [ $${ans:-N} = y ]

# -----------------------------------------------------
# GOODIES
# -----------------------------------------------------

## stow: uses gnu stow --adopt . after confirmation
.PHONY: stow
stow: confirm
	@stow --adopt .
