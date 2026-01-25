##
## @khalidbelk, 2025
## File description:
## Makefile
##

GREEN=\033[0;32m
RESET=\033[0m

EXEC = a.out

LIB_NAME=ocaml-yescrypt

OPAM_FILE=${LIB_NAME}.opam

all: ${LIB_NAME}
	@${MAKE} doc

doc:
	@dune build @doc

${LIB_NAME}:
	@echo "${GREEN}Building${RESET} $(LIB_NAME) library..."
	@dune build @install
	@echo "${GREEN}✔ Done.${RESET} Library successfully built."

exec-test:
	@echo "${GREEN}Building${RESET} $(EXEC) test executable..."
	@dune build bin/main.exe
	@install -m 755 _build/default/bin/main.exe $(EXEC)
	@echo "${GREEN}✔ Done.${RESET}"

opam:
	@echo "${GREEN}Generating${RESET} $(OPAM_FILE)..."
	@dune build ${OPAM_FILE}

clean:
	@echo "Cleaning..."
	@dune clean

fclean: clean
	@echo "${GREEN}Removing${RESET} $(NAME)..."
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean