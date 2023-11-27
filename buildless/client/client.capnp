@0x9284cee513b94f17;

# Copyright 2023 Elide Ventures LLC
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
# the License. You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

# Specifies records which detail information about build cache clients.

using Java = import "/capnp/java.capnp";
using Version = import "../common.capnp".Version;

$Java.package("buildless.client");
$Java.outerClassname("Client");


# Cache Client Agent
#
# Specifies known cache client engines which can be used with Buildless.
enum CacheClientAgent {
  # No client is specified; this is a default value which may indicate a protocol-incompatible enumeration.
  clientUnspecified @0;

  # Generic cache clients of any type.
  generic @1;

  # Cache client: Gradle.
  gradle @2;

  # Cache client: Maven.
  maven @3;

  # Cache client: Bazel/Blaze.
  bazel @4;

  # Cache client: CCache.
  ccache @5;

  # Cache client: SCCache, an extension of CCache.
  sccache @6;

  # Cache client: Turborepo.
  turbo @7;

  # Cache client: Nix.
  nix @8;

  # Cache client: Docker.
  docker @9;

  # Cache client: GitHub Actions.
  githubActions @10;

  # Cache client: Raw Redis.
  redis @11;
}

# Cache Client Spec
#
# Specifies basic information about a build cache client. Only fields which have known values are filled in. Clients
# can be specified via a known enumeration (`CacheClient`) or an arbitrary user-agent string. When specifying a known
# cache client, the `agent` string may be enclosed as additional version material, if known.
struct CacheClientSpec {
    # Known client, if applicable and available.
    agent @0 :CacheClientAgent;

    # User-agent string, if available.
    ua @1 :Text;

    # Version detected for the client, if available and applicable.
    version @2 :Version;
}

# Cache Client
#
# Specifies information about a cache client, to the extent it is identifiable from protocol material. This may include
# the type of client, the version of the client, and any known or declared capabilities.
struct CacheClient {
    # Basic information about the client, including the type of client and version, if known.
    info @0 :CacheClientSpec;
}
