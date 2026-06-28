# julesr

`julesr` is an unofficial R client for the Google Jules REST API (`v1alpha`).

## Installation

```r
# Install from GitHub (once available)
# remotes::install_github("username/julesr")
```

## Authentication

You need a Jules API Key. You can set it as an environment variable:

```bash
export JULES_API_KEY="your_api_key"
```

Or set it in your R session:

```r
library(julesr)
jules_auth("your_api_key")
```

## Usage

### Sources

```r
# List sources
sources <- list_sources()

# Get a specific source
source <- get_source("sources/123")
```

### Sessions

```r
# List sessions
sessions <- list_sessions()

# Create a new session
new_session <- create_session()

# Send a message to a session
response <- send_message(new_session$name, "Hello Jules!")

# Approve a plan
approve_plan(new_session$name)
```

### Activities

```r
# List activities for a session
activities <- list_activities("sessions/123")
```

## Disclaimer

This is an unofficial package. The Jules API is currently in alpha and may change without notice.
