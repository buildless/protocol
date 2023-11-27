@0xb3a63c18d8b78827;

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

# Describes common structures used by the Buildless Build Cache, including any protocol extensions to standard build
# cache protocols.

using Java = import "/capnp/java.capnp";

$Java.package("buildless.buildcache");
$Java.outerClassname("Tag");


# Cache Tag
#
# Specifies the conceptual structure of a "cache tag," N+ of which may be applied to an object stored within the
# Buildless build cache; tags are a fundamental concept which are used by the Buildless service, and are _also_ exposed
# for direct use by end-users.
#
# ### Cached objects are taggable
#
# Cache tags may be affixed to a cached object, in which case they are stored in the object's metadata blob in-memory.
# Object metadata may be queried without fetching the whole object, and tags can additionally be used to govern things
# like access control and flush boundaries.
#
# ### The Buildless service applies some tags
#
# In some cases, tags are automatically applied to objects under the hood, according to how the Buildless service
# processed or understood them. For example, objects are auto-tagged with the client agent detected by Buildless, and
# with details like the related project, repository, or commit (as applicable).
#
# ### No object key impact
#
# Cache tags are not enclosed within the object key, so tags may safely be changed over an object's lifecycle without
# requiring a change in client behavior.
#
# ### Known tags vs. keyed tags
#
# "Known tags" are enumerated within the Buildless protocol, whereas keyed tags are addressed by a string key value.
# The "key" value, if specified, is a "dotted.path.style" value. Any path works, with some exceptions:
#
# - Keys cannot begin with `system`, `elide`, or `buildless`
# - Keys cannot begin or end with a number or symbol
# - Keys can only contain `A-Z,0-9,-,_`
#
# Users are encouraged to use consistent keys which group together via some meaningful relation.
struct CacheTag {
    # Cache Tags: Well Known
    #
    # Specifies the exhaustive set of "well-known" cache tags for a given Buildless protocol revision. From time to
    # time, this list may grow as new WKT are added.
    enum WellKnown {
        # Value which represents a protocol-incompatible enumeration. This value should not be used by regular code.
        unknownTag @0;
    }

    # Cache Tags: Key
    #
    # Specifies the structure of a "keyed" cache tag, which associates a key value with a tag. All user-defined cache
    # tags are keyed cache tags; the alternative is a "Well-Known Tag," each instance of which is enumerated
    # exhaustively in the `WellKnown` enum type.
    struct Key {
        # Specifies the string value constituting this key.
        key @0 :Text;

        # Specifies that this key is generated/used by the Buildless service; output-only.
        system @1 :Bool;
    }

    # Cache Tags: Typed Value
    #
    # Encapsulates a "typed" value, declared with a `@value` property which maps to a Protocol Buffers type.
    struct TypedValue {
        # Specifies the type of this record; this should be a well-formed URL referencing a Protocol Buffers type. For
        # supported/available types, see main API documentation.
        type @0 :Text;

        # Specifies the typed data described by `type`, encoded as JSON.
        data @1 :Data;
    }

    # Cache Tags: Value
    #
    # Specifies the "value" of a cache tag; cache tag values are optional. The presence of a tag is sufficient to match
    # across cached objects. In some cases, it may be desirable to associate custom value data with tags. This data is
    # otherwise unavailable to a user except when (1) fetching object metadata, or (2) matching objects.
    struct TagValue {
        # Whether data is present for this tag value; defaults to `false`.
        present @0 :Bool;

        # Whether this data is "derived" by the Buildless service; output-only.
        derived @1 :Bool;

        # Actual value attached to the tag, if present.
        value :union {
            # Specifies the value associated with this tag value. Any value may be provided within the boundaries of
            # JSON and Protocol Buffers. Raw binary values are converted to Base64.
            inline @2 :Data;

            # Specifies a "typed" value which refers to a Protocol Buffer type.
            typed @3 :TypedValue;
        }
    }

    # Specifies the addressable ID for this cache tag.
    id :union {
        # Specifies a well-known tag type for this cache tag.
        type @0 :WellKnown;

        # Specifies a key, making this tag a "keyed" cache tag.
        tagKey @1 :Key;
    }

    # Specifies the value associated with this tag, if any.
    tagValue @2 :TagValue;
}
