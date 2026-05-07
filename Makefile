.PHONY: golden-test golden-update golden-report golden-clean

# verify mode: checks current goldens and generates *_compare.png on failure
golden-test:
	flutter test --tags golden
	@dart run tool/aggregate_golden_report.dart || echo "Some goldens failed - open build/reports/golden/index.html"

# record mode: updates committed golden images
golden-update:
	flutter test --update-goldens --tags golden

# rebuilds only the HTML report from existing partial JSON files
golden-report:
	dart run tool/aggregate_golden_report.dart

# removes generated local golden artifacts
golden-clean:
	rm -rf build/outputs/golden build/test-results/golden build/reports/golden
