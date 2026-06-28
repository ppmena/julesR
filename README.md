# julesr

`julesr` is an R client for the [Jules API](https://jules.googleapis.com).

## Status

**Project Status: Alpha**

The Jules API is currently in **alpha** (v1alpha) and is subject to change. This package should be considered experimental and may have breaking changes in the future.

## Installation

You can install the development version of `julesr` from GitHub (once available) or by using `devtools`:

```r
# Install devtools if you haven't already
# install.packages("devtools")

# Install julesr
# devtools::install_github("google/julesr")
```

## Configuration

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
sources <- list_sources()
print(sources)
```

### Create a Session

```r
session <- create_session(list(
  prompt = "Analyze the project structure",
  sourceContext = list(source = "sources/my-repo")
))
print(session$name)
```

### Send a Message

```r
response <- send_message(session$name, "What are the main entry points?")
```

## Best Practices

- Always keep your API key secure. Do not commit it to version control.
- Use environment variables for API keys when possible.
- Check the API documentation for rate limits and best practices for the Jules API.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contribution

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.
