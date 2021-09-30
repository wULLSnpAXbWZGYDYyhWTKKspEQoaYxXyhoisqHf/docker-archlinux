dcmd = docker
dfile = Dockerfile
dtag = immawanderer/archlinux:testbuild
dargs = build -t $(dtag) --no-cache --pull - < $(dfile)
cleanargs = image rm -f $(dtag)
pruneargs = system prune -af
dargskaniko = run --rm -it -w=$(kanikowdir) -v $$PWD:$(kanikowdir)
kanikoexecutorimg = gcr.io/kaniko-project/executor@sha256:6ecc43ae139ad8cfa11604b592aaedddcabff8cef469eda303f1fb5afe5e3034
kanikowdir = /src
kanikocontext = .
kanikoargs = -f=$(dfile) -c=$(kanikocontext) --use-new-run --snapshotMode=redo --no-push
hadolintimg = hadolint/hadolint:v2.7.0-alpine
hadolintargs = run --rm -i -v $$PWD/.hadolint.yaml:/root/.config/hadolint.yaml

.PHONY: hadolint build kaniko clean test prune

hadolint:
	$(dcmd) $(hadolintargs) $(hadolintimg) < $(dfile)

kaniko:
	$(dcmd) $(dargskaniko) $(kanikoexecutorimg) $(kanikoargs)

build:
	$(dcmd) $(dargs)

clean:
	$(dcmd) $(cleanargs)

test: hadolint build kaniko

prune:
	$(dcmd) $(pruneargs)
