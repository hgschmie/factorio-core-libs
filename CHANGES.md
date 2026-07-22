## Version 3

* Rewrote Ghost Manager - From Fiber Optics

  - Per type ghost callback
  - Framework.Ghost (not Framework.ghost_manager)

* Rewrote Tombstone Manager - from Miniloader

  - migrate with migrations/migrations/migrate_tombstone_manager.lua
  - Use Framework.Tombstone, not Framework.tombstone

* Move ticker state into framework storage

migrate with migrations/migrate_ticker.lua

``` lua
local Ticker = require('framework.ticker')

This, Framework = require('lib.init')()

if storage.ticker then
    local state = Ticker.state()

    for ticker_id, ticker in pairs(storage.ticker) do
        state[ticker_id] = ticker
    end

    storage.ticker = nil
end
```

* Manage pre-build events per ghost - From Miniloader

## Version 2

* Add code for ticker jobs
* Add matchers for event fields
* Add support for RemoteApis

* Change remote_api to 'ExportApis'

* Fixes for settings and gui

## Version 1

* Initial Import
