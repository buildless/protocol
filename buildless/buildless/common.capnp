@0xe903b55d96c97efb;

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

# Provides common records, enumerations, and definitions for the Buildless application. These objects are used in the
# Buildless API and the Buildless UI.
#
# **Note:** Because common objects in Buildless' model are not versioned, records should only be placed here which
#           outlive individual API versions. Care must be exercised to maintain forward and backward compatibility.

using Java = import "/capnp/java.capnp";

$Java.package("buildless");
$Java.outerClassname("Common");


#
struct Tenant {}

# Directory Provider
#
# Enumerates known providers which can be installed as a SCIM-based managed directory. Providers in this enumerate are
# generally also identity providers, in addition to directory providers.
enum DirectoryProvider {
    # Specifies an unknown or unrecognized directory provider; this value should not be used by regular application code
    # and typically signifies a backwards-incompatible value.
    directoryProviderUnknown @0;

    # Specifies Google Workspace as a directory provider.
    googleWorkspace @1;

    # Specifies Microsoft Azure AD as a directory provider.
    azureAd @2;

    # Specifies Okta as a directory provider.
    okta @3;

    # Specifies OneLogin as a directory provider.
    onelogin @4;

    # Specifies Ping Identity as a directory provider.
    pingIdentity @5;
}

# Account Provider
#
# Specifies identity or account providers which are integrated with Buildless. A user's primary identity originates
# from one of these providers in every case.
enum AccountProvider {
    # Specifies an unknown, or unrecognized, account or identity provider. This value indicates a backwards-incompatible
    # enumerated option and should not be used directly by code. Often, passing this value may result in an error.
    providerUnknown @0;

    # Specifies an account managed directly by Buildless. This account provider type covers email and phone-based
    # accounts, as well as enterprise account root users.
    inHouse @1;

    # Specifies an account which is managed by Google, as a consumer account. This usually indicates an individual who
    # has created a Buildless account through their Google account.
    google @2;

    # Specifies an account which is managed by GitHub, as a consumer account. This usually indicates a Marketplace Plan
    # enrollment from an individual GitHub account.
    github @3;

    # Specifies an account which is managed by Atlassian, as a consumer account. This usually indicates a Marketplace
    # Plan enrollment from an individual BitBucket account.
    atlassian @4;

    # Specifies an account which is managed by Microsoft, as a consumer account. This usually indicates a Microsoft
    # user who has enrolled for a Buildless individual account.
    microsoft @5;

    # Specifies an Enterprise directory account. Enterprise accounts are usually managed through SCIM, and originate
    # from an enterprise identity provider.
    directory @6;
}

#
struct User {}

#
struct Account {}

# Version
#
# Specifies generic versioning information, in the style of Semantic Versioning or in a string.
struct Version {
    # Semantic Version
    #
    # Specifies a "semver"-style version, with major, minor, and patch components.
    struct SemanticVersion {
        # The major version, e.g 10 for the value 10.2.3.
        major @0 :UInt16;

        # The minor version, e.g. 2 for the value 10.2.3.
        minor @1 :UInt16;

        # The patch version, e.g 3 for the value 10.2.3.
        patch @2 :UInt32;
    }

    # Specifies the version value enclosed within this record, either as a structured version or string version.
    value :union {
        # Semantic version, structurally expressed as numeric components.
        semver @0 :SemanticVersion;

        # Arbitrary version string.
        text @1 :Text;
    }
}
