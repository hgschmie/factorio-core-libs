## Version 3

* Rewrote Tombstone Manager - from Miniloader

  Reset tombstone manager with `Framework.TombstoneManager:state(true)` in a migration.

Use Framework.Tombstone, not Framework.tombstone

* Move ticker state into framework storage

migrate with

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



## Version 2

* Add code for ticker jobs
* Add matchers for event fields
* Add support for RemoteApis

* Change remote_api to 'ExportApis'

* Fixes for settings and gui

## Version 1

* Initial Import
