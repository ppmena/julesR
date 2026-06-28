# julesr

`julesr` is an R client for the [Jules API](https://jules.googleapis.com).

## Project Status: Alpha

The Jules API is currently in **alpha** (v1alpha) and is subject to change. This package should be considered experimental and may have breaking changes in the future.

## Installation

You can install the development version of `julesr` from GitHub using `devtools`:

```r
# install.packages("devtools")
devtools::install_github("google/julesr")
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
if (nzchar(Sys.getenv("JULES_API_KEY"))) {
  sources <- list_sources()
  print(sources)
}
```

### Creating a Session

```r
if (nzchar(Sys.getenv("JULES_API_KEY"))) {
  session <- create_session(list(
    prompt = "Analyze the project structure",
    sourceContext = list(source = "sources/my-repo")
  ))
  print(session$name)
}
```

### Sending a Message

```r
if (nzchar(Sys.getenv("JULES_API_KEY"))) {
  response <- send_message("sessions/my-session-id", "What are the main entry points?")
  print(response)
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contribution

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.

If you want to contribute, please follow the [tidyverse style guide](https://style.tidyverse.org/) and ensure all tests pass before submitting a pull request.
