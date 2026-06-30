# julesr 0.1.0

* Initial release of `julesr`, an R client for the Jules API.
* Support for listing and getting sources, sessions, and activities.
* Support for creating sessions, approving plans, and sending messages.
* Built-in authentication handling via API keys.
* Automatic conversion of API responses to tibbles for easy data manipulation.
* Fixed 400 Bad Request in `jules_session_create` by ensuring correct resource name prefixes.
