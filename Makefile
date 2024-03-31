# 
# Rules for compiling and linking the NotSql interpreter
#
# Type
#   make         to rebuild the executable files
#   make clean   to remove all intermediate and temporary files
#   

# Files that need to be generated from other files
DEPEND += NotSqlTokens.hs Main.hs

# When "make" is invoked with no arguments, we build an executable 
#  after building everything that it depends on
all: $(DEPEND) Main

# Build an executable for Main
Main: $(DEPEND) Main.hs
	ghc -o Main Main.hs

# Generate ML files from a lexer definition file
NotSqlTokens.hs : NotSqlTokens.x
	@rm -f NotSqlTokens.hs
	alex NotSqlTokens.x
	@chmod -w NotSqlTokens.hs

# Clean up the directory
clean::
	rm -rf NotSqlTokens.hs Main *.hi *.o *.info

# Commit at regular intervals
checkpoint:
	git add -A
	git commit -m "Committing: Checkpoint at $(shell date)"
	git pull
	git push