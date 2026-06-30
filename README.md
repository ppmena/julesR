# julesr

An R client for the [Jules API](https://jules.googleapis.com).

## Project Status: Alpha

The Jules API is currently in **alpha** (v1alpha) and is subject to change. This package should be considered experimental and may have breaking changes in the future.

## Installation

You can install the development version of `julesr` from GitHub:

```r
# install.packages("devtools")
devtools::install_github("ppmena/julesR")
```

## Authentication

To use `julesr`, you need a Jules API key. You can set it in two ways:

1.  Set the `JULES_API_KEY` environment variable in your `.Renviron` file:
    ```
    JULES_API_KEY=your_api_key_here
    ```
2.  Use the `jules_auth()` function at the beginning of your session:
    ```r
    library(julesr)
    jules_auth("your_api_key_here")
    ```

## Basic Usage

### List Sources

```r
library(julesr)
jules_auth()

repos <- jules_sources()
print(repos)
```

### Creating a Session

You can create a session using either the fully qualified source name or just the source ID:

```r
# Using a source ID from jules_sources()
task <- jules_session_create(
    prompt = "Add unit tests for the utils module.",
    source = repos$name[[1]]
)
print(task$name)
```

### Getting a Session

```r
# You can use the full name "sessions/xxx" or just "xxx"
jules_session_get(task$name)
```

### Sending a Message

```r
jules_message_send(
    task$name,
    "Please continue with the implementation."
)
```

### List Activities

```r
jules_activities(task$name)
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
