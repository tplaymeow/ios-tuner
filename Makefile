test:
	@xcodebuild test \
	-scheme Tuner \
	-project App/Tuner.xcodeproj \
	-destination "platform=iOS Simulator,name=iPhone 14,OS=17.0"
