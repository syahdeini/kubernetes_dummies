.phony: run-dev
run-dev: 
	docker run -v ${PWD}/src:/src --rm -it ubuntu /bin/bash
