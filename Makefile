##
## @khalidbelk, 2025
## File description:
## Makefile
##

GREEN=\033[0;32m
RESET=\033[0m

NAME = a.out


all: $(NAME)

$(C_YESCRYPT_LIB):
	${MAKE} -C ${C_YESCRYPT_LIB_DIR}

$(NAME):
	@echo "${GREEN}Building${RESET} $(NAME)..."
	@dune build bin/main.exe
	@install -m 755 _build/default/bin/main.exe $(NAME)
	@echo "${GREEN}✔ Done.${RESET}"

clean:
	@echo "Cleaning..."
	@dune clean

fclean: clean
	@echo "${GREEN}Removing${RESET} $(NAME)..."
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean