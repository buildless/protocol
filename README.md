
# `protocol`

> Protocol definitions for Buildless and foreign build caching protocols.

- **[Buildless Protocol][1]:** Specifies protocol definitions for the [Buildless][0] service and clients. [Browse docs][2].
- **[Google APIs][3]:** Google's build caching-related APIs for [Bazel][4] are in `third_party/google` and `third_party/bazel`.
- **[Microsoft BuildXL][5]:** Microsoft's [BuildXL][6]-related build caching APIs are in `third_party/microsoft`.

## What's this for?

Sometimes you need to reference the low-level structures for build cache APIs. This repo helps you do that across providers and specifications. There are READMEs in each protocol module which describe where source originates from.

You can use this repository via [Buf][7].


[0]: https://less.build
[1]: ./buildless
[2]: https://buf.build/buildless/buildless
[3]: ./third_party/google
[4]: https://bazel.build
[5]: ./third_party/microsoft
[6]: https://github.com/microsoft/BuildXL
[7]: https://buf.build/buildless/spec
