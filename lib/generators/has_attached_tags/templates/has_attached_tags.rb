# frozen_string_literal: true

# Maps the `Tag` and `Tagging` models into the local application namespace.
# Remove these lines if you have a conflict, or do not want this behaviour.
Tag     = HasAttachedTags::Tag
Tagging = HasAttachedTags::Tagging
