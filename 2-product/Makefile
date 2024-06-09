BASE = $(shell /bin/pwd)
PRODUCT_DIR = $(BASE)/src
BUILD_DIR = $(BASE)/build
DIST_DIR = $(BASE)/dist
TEMP_DIR = $(BASE)/temp

PRODUCT_NAME = isv_product_roles
ARTIFACT_FILE = $(PRODUCT_NAME).tar.gz

ARTIFACT_BUCKET = reinforce-grc442-artifact
ARTIFACT_HASH = $(shell sha256sum $(BUILD_DIR)/$(ARTIFACT_FILE) | cut -d" " -f 1)
ARTIFACT_KEY = $(PRODUCT_NAME)-$(ARTIFACT_HASH).tar.gz

PREVIOUS_HASH = $(shell sha256sum $(TEMP_DIR)/$(ARTIFACT_FILE) | cut -d" " -f 1)

CURRENT_DATE = $(shell date '+%Y-%m-%d_%H_%M_%S')
ARTIFACT_VERSIONED_KEY = $(PRODUCT_NAME)-v$(CURRENT_DATE).tar.gz

.PHONY: all build upload clean

all: test build upload clean

test: _test _clean_test

build: clean
	# tar -czvf {destination} -C {source} .
	tar -czvf $(BUILD_DIR)/$(ARTIFACT_FILE) -C $(PRODUCT_DIR) .

version:
	if [[ "$(ARTIFACT_HASH)" != "$(PREVIOUS_HASH)" ]]; then cp $(BUILD_DIR)/$(ARTIFACT_FILE) $(TEMP_DIR)/$(ARTIFACT_FILE); cp $(BUILD_DIR)/$(ARTIFACT_FILE) $(DIST_DIR)/$(ARTIFACT_VERSIONED_KEY); fi

upload:
	# copy file, rename to version by date and upload to s3 here
	aws s3 sync $(DIST_DIR) s3://$(ARTIFACT_BUCKET)/

clean:
	rm -f $(BUILD_DIR)/*
	rm -rf $(PRODUCT_DIR)/.terraform
	rm -f $(PRODUCT_DIR)/.terraform*

clean_all:
	rm -f $(BUILD_DIR)/*
	rm -f $(DIST_DIR)/*
	rm -f $(TEMP_DIR)/*
	rm -rf ./product/.terraform*

delete_bucket: clean_all
	aws s3 sync $(DIST_DIR) s3://$(ARTIFACT_BUCKET)/ --delete

_test:
	# terraform init and then run test
	cd $(PRODUCT_DIR) ; terraform init ; terraform test

_clean_test:
	rm -rf $(PRODUCT_DIR)/.terraform
	rm -f $(PRODUCT_DIR)/.terraform*