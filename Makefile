build:
	docker build -t joshhsoj1902/docker-ogpagent .
start:
	docker run --rm joshhsoj1902/docker-ogpagent:latest

.PHONY: build
