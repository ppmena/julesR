# julesr

R Client for Jules API.

## Uso básico

```r
library(julesr)

jules_auth()

sources <- jules_sources()

task <- jules_session_create(
  prompt = "Añade tests unitarios para las funciones principales.",
  source = sources$sources[[1]]$name,
  branch = "main",
  title = "Añadir tests unitarios",
  require_plan_approval = TRUE
)

jules_session_get(task$name)

jules_message_send(
  session = task$name,
  message = "Continúa con la implementación."
)

jules_activities(task$name)
```
