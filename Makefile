BIN=node_modules/.bin

TESTS ?= "**/*.tests.js"
SRC_FILES ?= "{server,index,{api,config}/**/*}.js"

## Set default test NODE_ENV to test_local
# test: NODE_ENV ?= test_local
ifneq ($(NODE_ENV), test_ci)
NODE_ENV = test_local
endif

lint:
	$(BIN)/eslint $(SRC_FILES)


## Run all Tests and Generate Coverage Report
#    `make test` will invoke all tests
#
## Run specified tests and generate coverage report
#    `make TESTS="./**/sample.tests.js" test`
test:
	rm -rf coverage
	$(BIN)/istanbul cover $(BIN)/_mocha -x $(TESTS) -- \
	--compilers js:babel-register --reporter dot $(TESTS)

## Open the html report in the system default browser
report:
	open ./coverage/lcov-report/index.html

## Send the coverage information to coveralls
coveralls:
	cat ./coverage/lcov.info | $(BIN)/coveralls

.PHONY: lint test report coveralls coverage