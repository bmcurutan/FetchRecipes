# Fetch Recipes

### Steps to Run the App

- No special setup required. Download project from Github and run on an iOS 18+ device/simulator.
- App's main page loads with the "Fetch Recipes" logo and title, filter buttons to shortlist recipes by cuisine, and the list of recipes.
- The cuisines are sourced from the json data. Tapping on a cuisine (e.g., "Canadian") updates the list to only show recipes from the selected cuisine. Tap the selected cuisine again to unselect.
- Pull recipe list down to refresh the json data and reset the cuisine filter.
- Tap on the notes icon (intended as a recipe icon) to view a web view with the recipe, if available.
- Tap on the video icon to view the Youtube video, if available. 
- Scroll down the list fast - images load as the list item becomes visible.
- Tap the "Go Fetch!" button for the app to randomly choose a recipe for you.
- Restarting the app refreshes the data.
- The app doesn't support orientations other than upright portrait.

![recording](https://github.com/user-attachments/assets/f91b1be5-30ac-44c4-8f9f-86b934e0db55)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

- Architecture: MVVM architecture pattern widely used in iOS and Android development. It separates business logic (i.e., view model) and UI (i.e., views) and improves scability, reusability, testability, and maintainability. For example, views only store the data they use. Since this is a simple app, folders are organized by type (e.g., Views), but in a larger app, it may make more sense to organize by module (e.g., Recipe views and view model)
- UI/UX: Created a clean, aesthetic user interface that is intuitive and effortless. Used iOS conventions (SwiftUI) and techniques and maintaining a focus on scability and maintainability. 
- Performance: Load data and download images async when needed (refreshed) and cache images to disk to reduce network usage with the Kingfisher package.
- Testing: Test coverage for the recipe models and view model.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

- Not certain, but 5+ hours with the added enhancements.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

- Cuisines could be an enum if we know them rather than sourcing strings from the json data. Since the latter was implemented, the selected cuisine is stored here as a string instead of an index if there's a version of this app where the data is different upon a re-fetch and the cuisine list changes (e.g., cuisines added or removed).
- Didn't optimize for dark mode, accessibility, lost network connection, nor opening relevant installed apps as applicable (e.g., tap on video button opens Youtube app instead of web view if the app is installed). 

### Weakest Part of the Project: What do you think is the weakest part of your project?

- App's initial loading time could be faster.
- Missing loading states for slow image and web view loading (although for images there is a default image).
- Depends on external package for image handling. In this case, Kingfisher is a popular package with regular updates, but outsourced solutions could have unforeseen consequences.  

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
- [Kingfisher](https://github.com/onevcat/Kingfisher) library used for downloading and caching images.
- [Gemini](https://gemini.google.com/) used to generate logo.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

- Additional improvement: When a cuisine button is partially visible and that cuisine is selected, automatically scroll the filter view to fully display the selected button.
- Additional improvement: Add a save state (even if it's just stored locally and without authentication, such as with User Defaults), so user can shortlist favorite recipes.
- Additional improvement: Add some UI tests.
- Additional improvement: Add tap functionality to the list item image (sourced by small URL) to show a full screen view of the image (sourced by large URL).
- Additional improvement: Peek the web view sheet before showing it fullscreen.
- Recipe URL is hardcoded in app - would be improved by providing the URL from a backend.
- Could have added pagination, but the current list seems palatable in the app without it and the endpoint doesn't have a pagination query.
- Could have added some UIKit views to show the interactability with SwiftUI and leverage the strengths of both frameworks.
- RecipesEmptyView and RecipesErrorView are so similar here that the same SwiftUI file could be used for both, but decided against it since there's a version of this app where these screens include different details and UI. 
- The added cuisine filter is built on the recipes list provided and so the user is unable to do fuzzy search (e.g., if the list is longer and more difficult to browse, if a recipe follows more than one cuisine, if there are typos in the cuisines)
- Had another idea to integrate AI-powered chat and suggest recipe-related prompts, such as "how do you roll fondant".

