function runTestsForArtist(artist) {

    var target = UIATarget.localTarget();
    var app = target.frontMostApp();
    var window = app.mainWindow();

    // Tap View List Button
    window.buttons()["View List"].tap();

    UIALogger.logStart("Test: Add Album to List");

    var oldCount = window.tableViews()[0].cells().length;
    UIALogger.logDebug("List count at start of test: " + oldCount);

    // Tap Search Button
    app.navigationBar().rightButton().tap();

    // Tap the Search Bar and Enter "trivium"
    window.tableViews()[0].searchBars()[0].tap();
    app.keyboard().typeString(artist);
    app.keyboard().typeString("\n");

    // Delay for 0.5 to wait for search results
    target.delay(0.5);
    // Tap the First Result
    window.tableViews()[0].cells()[0].tap();

    // Delay for 0.5 to wait for album list
    target.delay(0.5);
    window.tableViews()[0].cells()[0].tap();

    // Delay for 2 seconds to wait for image to be retrieved
    target.delay(1.0);
    window.buttons()["Save to List"].tap();

    // Capture the updated list count
    var newCount = window.tableViews()[0].cells().length;
    UIALogger.logDebug("List count after Album added: " + newCount);

	target.delay(0.5);
	
    if (artist == "justin bieber") {
        UIALogger.logFail("EPIC FAIL: YOU SAVED A JUSTIN BIEBER ALBUM");
    }

    if (newCount == (oldCount + 1)) {
        UIALogger.logPass("Album correctly added.");
    } else {
        UIALogger.logFail("Failed to add Album.");
    }


    UIALogger.logStart("Test: Delete Added Album");

    // Get reference to the top cell
    var topCell = window.tableViews()[0].cells()[0];

    // Define a swipe from left to right
    var swipeOptions = {
        startOffset: {
            x: 0.0,
            y: 0.5
        },
        endOffset: {
            x: 0.5,
            y: 0.5
        },
        duration: 0.1
    };
    topCell.dragInsideWithOptions(swipeOptions);

    // Wait for delete button to animate in
    target.delay(0.5);

    // topCell is undefined at this point, lookup top cell and tap button
    window.tableViews()[0].cells()[0].buttons()[0].tap();

    // Wait for deletion animation to complete
    target.delay(0.5);

    newCount = window.tableViews()[0].cells().length;
    UIALogger.logDebug("List count after Album added: " + newCount);

    if (newCount == oldCount) {
        UIALogger.logPass("Album successfully deleted.");
    } else {
        UIALogger.logFail("Attempted album delete failed.");
    }

    app.navigationBar().leftButton().tap();
}

var artistNames = ["iron maiden", "slayer", "justin bieber"];
for (i = 0; i < artistNames.length; i++) {
    runTestsForArtist(artistNames[i]);
}

