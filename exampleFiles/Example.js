#import "../core/core.js"

Given(/^I am on the main page$/, function(target, window){
      
      ASSERT(isMainPage(window), "it's not the main window");
      
})

When(/^I tap the "Add Item" but$/, function(target, window){
     
     var navBar = window.navigationBar()
     var addButton = navBar.buttons()["Add"];
     addButton.tap();
     
})

Then(/^I should see the "Add Item" page$/, function(target, window){
     
     ASSERT(false, "I fail because i care");
     
});
