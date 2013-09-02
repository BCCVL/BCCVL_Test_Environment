plone:
    admin: admin
    password: admin
    hostname: 192.168.100.100

    # mr_developer_always_checkout
    #
    # Affects how submodules in src are updated.
    #
    # 'true' for development (updates unless repo is dirty) - project default
    # 'false' for production (only checks out once - never updates)
    # 'force' for testing (always updates, even if repo is dirty)
    #
    mr_developer_always_checkout: true

    # site_replace
    #
    # Affects whether a site with same id is replaced, or remains
    # untouched.
    #
    # 'false' to NOT replace an existing site, if one is found - project default
    # 'true' to replace the existing site, if one is found
    site_replace: false
