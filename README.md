# SwiftUI Base Template
**SwiftUI Base** is a boilerplate project created by Rootstrap for new projects using SwiftUI. The main objective is helping any new projects jump start into feature development by providing a handful of functionalities.

## Features
This template comes with:
#### Main
- Complete integration with API service using [**RSSwiftNetworking**](https://github.com/rootstrap/RSSwiftNetworking).
- Examples for **account creation**.
- Useful classes to **manage User and Session data**.
- Handy **helpers** and **extensions** to make your coding experience faster and easier.
- Use SPM to manage packages

To use them simply download the branch and locally rebase against master/develop from your initial **SwiftUI Base** clone.

## How to use
1. Clone repo.
3. Run `./init` from the recently created folder.
4. Initialize a new git repo and add your remote url.
5. Done!

To manage user and session persistence after the original sign in/up we store that information in the native UserDefaults. The parameters that we save are due to the usage of [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth) for authentication on the server side. Suffice to say that this can be modified to be on par with the server authentication of your choice.

## Credits

**SwiftUI Base** is maintained by [Rootstrap](http://www.rootstrap.com) with the help of our [contributors](https://github.com/rootstrap/POCWatchOSConnectivity/graphs/contributors).
