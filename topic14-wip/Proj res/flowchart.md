
```mermaid
flowchart TD
  A[Raw XML bytes] --> B[Optional schema validation]
  B --> C[Parse to XML surface AST]
  C --> D[Decode to domain ADTs]
  D --> E[Business logic]
  E --> F[Encode domain to XML AST]
  F --> G[Render XML bytes]
