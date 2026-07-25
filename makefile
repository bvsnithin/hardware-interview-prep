CLEAN_TARGETS = xrun.log xrun.history xcelium.d waves.shm xrun.key .simvision

.PHONY: clean

clean:
	@echo "Cleaning up Xcelium Simulation Files"
	@for target in $(CLEAN_TARGETS); do \
		find . -name "$$target" -exec rm -rf {} +; \
	done
	@echo "Clean complete"
	-exec clear