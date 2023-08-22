test:
	@xcodebuild test \
	-scheme Tuner \
	-project App/Tuner.xcodeproj \
	-destination "platform=iOS Simulator,name=IPhone 14,OS=16.0"
