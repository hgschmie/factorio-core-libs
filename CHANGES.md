## Version 4

* Stdlib - From Electric Locomotives

Reconciled Electric Locomotives `a97bd00` into the reset core_libs baseline
`6adf920`. The later annotation changes from `c2ff188` are excluded. The last
copied stdlib trees are identical: Electric Locomotives `c6e3129` and core_libs
`9f97024` (23 files). Four subsequent mod commits changed four stdlib files;
the other 19 files have no mod-specific changes to import. Framework
changes from Electric Locomotives and Fiber Optics are also included below.

Type hints and documentation:

| File / API | Mod change | Source commit | Resolution |
| --- | --- | --- | --- |
| `stdlib/area/area.lua` | Replace `BoundingBox.0` with `BoundingBox.struct`. | `521993d` | Already imported in `f2f808f`; retain the current `Area.Area` class and its field annotations. |
| `stdlib/utils/is.lua`: `Is.Assert(...)`, `Is.Assert.Not(...)` | Cast the computed `_level` to `integer`, instead of annotating only the fallback literal. | `48f6f2c` | Imported both casts. |
| `stdlib/utils/is.lua`: `Callable` | Replace LDoc parameter/return tags with `any` input and named `boolean` result annotations. | `bf3e97f` | Equivalent annotations already present from `6adf920`; retained. |
| `stdlib/game.lua`: `Game.get_player` | Accept optional integer index, name, player, or `EventData`; document an optional player result and narrow table/player branches. | `03ac6b6` | Imported the signature and event-table cast; retained the canonical LuaPlayer cast and runtime guards. |
| `stdlib/event/player.lua`: `Player.get` | Add optional integer/event inputs and nullable player/data results; type player data as `table<string, any>`. | `03ac6b6` | Imported; retained the canonical usage example. |
| `stdlib/event/player.lua`: `Player.pdata` | Rename `index` to `player_index`, use `uint32`, and specify non-null `table<string, any>` data. | `03ac6b6` | Imported. |
| `stdlib/event/player.lua`: `Player.init` | Rename `event` to `mixed`, use the optional player input union, and declare an optional data-table return. | `03ac6b6` | Imported. |

Runtime fixes and behavior changes:

| File / API | Mod change | Source commit | Resolution |
| --- | --- | --- | --- |
| `stdlib/utils/is.lua`: `Unsigned` | Call `M.Number` directly instead of going through the public `Is.Number` proxy. | `48f6f2c` | Imported as an internal cleanup; ordinary predicate results are unchanged. |
| `stdlib/game.lua`: `Game.get_player` | Return `nil`, rather than `false`, for an invalid player object. | `03ac6b6` | Already implemented by `6adf920`; retained its additional string/number input guard. |
| `stdlib/event/player.lua`: `Player.get` | Avoid indexing a missing player; return `nil, nil` when lookup fails. | `03ac6b6` | Imported. |
| `stdlib/event/player.lua`: `Player.pdata` | Assert that initialization returns data instead of allowing a missing result. | `03ac6b6` | Imported; invalid uncached indexes now raise an assertion. |
| `stdlib/event/player.lua`: `Player.init` | Return `nil` instead of the Player module when no individual data table is created. | `03ac6b6` | Imported; this includes bulk initialization and an already initialized player without overwrite. |
| `stdlib/event/player.lua`: `Player.init` | Remove flushing and clearing of `storage._print_queue`. | `03ac6b6` | Imported as requested. `Game.print_all` still queues messages when no players exist; Player initialization no longer delivers or clears them. |
| `stdlib/event/player.lua`: `Player.update_force` | Update saved force data only when both player and data exist. | `03ac6b6` | Imported. |

The existing `6adf920` annotations and runtime fixes remain intact, including
`Game.print_all` returning zero when it queues a message. The Electric Locomotives stdlib import changed
`stdlib/game.lua`, `stdlib/event/player.lua`, and `stdlib/utils/is.lua`.

* Additional stdlib fixes and annotations

Modernize LuaLS and EmmyLua annotations, including optional player results,
prototype types, and generic table helpers. `Table.keys` accounts for optional
string conversion; `Table.array_to_dictionary` documents its value/boolean modes.

`Area.flip` always returns its area, and position distance helpers default an
omitted second position to the origin. `Core.log_and_print` returns false when
nothing is printed. Game helpers validate player/force inputs, and
`Game.print_all` returns zero when it queues a message.

* Blueprint Manager - From Electric Locomotives

Require both a player and player data before handling blueprint events. Return
nil when no accessible blueprint stack is available. Update annotations for
LuaRecord blueprint sources and optional callbacks.

* Ghost Manager - From Fiber Optics and Electric Locomotives

Fix premature deletion of unrelated ghosts. Check entity validity directly and
assert that registered ghosts have entity keys and unit numbers.

* GUI - From Train Tracker, Electric Locomotives, and Fiber Optics

Add `addTags` for GUI links outside the element tree. Normalize present GUI type
tags to strings while continuing to ignore elements without a GUI type tag.
Allow event definitions to omit the event table, initialize it at registration,
and safely return false when dispatch finds no event table or handler.

Assert tab/content definitions and provide clearer errors for missing GUI type
or player index. Simplify handler cleanup and player-index access. Refine GUI
context, element, and handler annotations.

* Settings - From LTN-Space Exploration and Electric Locomotives

Support numeric debug levels from the startup dropdown, with a zero fallback.
Ignore writes for missing players without changing player defaults. Iterate
settings providers when adding defaults or flushing caches, and assert valid
settings groups before reading or writing.

* Logger - From LTN-Space Exploration

Provide level-based logging and printing, fix log-level assignment, and remove
the unused stdlib logger dependency.

* Tombstones and translations - From Electric Locomotives

Convert blueprint entity names to strings before applying tombstone callbacks
and simplify callback name normalization. Translation helpers rely on
`Player.pdata` to assert that player data exists.

* Shared framework cleanup - From Electric Locomotives

Remove the unused Is dependency from event matchers and assert GUI style tables
before defining slot styles. Update framework and prototype-helper annotations.

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
