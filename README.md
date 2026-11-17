# Star Wars: Return of the Sith

Text MUD based on SMAUG and the SWFotE (Star Wars: Fall of the Empire) codebase.
Restored 2020 by Randal. Updated November 16, 2026.

This codebase is a RotS distribution of SWFotE. The original project lived at
http://swfote.sourceforge.net. SMAUG 1.0 was written in 1994-1997 by Derek
Snider and the SMAUG team. The force skill system was written in 2001 by
Richard Berrill (Bambua), with later changes by Tawnos. In-game help
(`help`, `wizhelp`, `hlist`, `changes`) is more detailed than this file.

A premade level 36 administrator is named `User`. The password is `password`.
Change the name and password before anyone else can connect.

## Build

From `src`, with gcc:

```
make swr
```

The Makefile passes `-fcommon`. This code defines the same globals in more
than one file, which current gcc rejects unless that flag is set.

Clean objects and rebuild:

```
make clean
make swr
```

`startup` is a csh script. On Ubuntu install it with `sudo apt-get install csh`.
From `src`:

```
./startup
```

Or, so the process survives a logout:

```
nohup ./startup 1111 &
```

## Port

The port is 1111, set in `src/startup`. The game also opens `port+1`,
`port+10`, and `port+20`.

## Layout

- `area` — world files. Boot list is `area/area.lst`.
- `planets` — planet files. Boot list is `planets/planet.lst`.
- `space` — star systems and ships. Boot list is `space/space.lst`.
- `ships` — ship prototypes.
- `system` — skills, commands, socials, sysdata.
- `force` — force skill list and help.
- `clans` — clan files.
- `player` — player files. Idle purge is 30 days for players and 5 days for newbies (`Newbie_purge` and `Regular_purge` in `system/sysdata.dat`).
- `doc` — original SMAUG notes. Online help is more current.
- `src` — C source. Space combat is in `space.c`, `ships.c`, and `11.c`. Force code is in `force.c`, `finfo.c`, `fskills.c`, and `new_fskills.c`.

## What you can do

This is a Star Wars SMAUG. You walk rooms, talk, fight, buy gear, join a
clan, and fly a ship between star systems. The port is 1111.

**On the ground.** `look` describes the room and can draw a small map.
`map` shows that map once. `automap` turns it on or off. `alias` stores up
to eight shortcuts on your character (`alias n north`, `alias greet say
Hello there.`, `alias n` to remove one). The saved name has to match the
whole word, so a short alias does not swallow a longer command.

**Houses.** `buyhouse` buys the room you are standing in for 25,000 credits.
One house per character. It starts locked. `house lock` and `house unlock`
close and open it. `house guest <name>` and `house unguest <name>` name who
may enter while it is locked. The owner, a named guest, and immortals can
always enter. Houses are saved in `system/houses.dat`. They are separate
from clan storerooms.

**Quests.** Builder quests live in `system/quests.dat`. Each one has an id,
a name, a giver, a credit prize, and up to six stages. A stage is visit a
room or kill a mobile. At the giver, `qaccept` starts it, `qstat` shows the
current stage, and `qfinish` pays you when every stage is done. Progress is
saved on the character. One sample is loaded: an Academy errand from the
receptionist on Honoghr. The older `quest` command is still the quest talk
channel.

**Force.** Jedi and Sith do not use the old "feel" skill. Alignment runs
from -100 to 100. Opposite alignment (a Jedi at -100, a Sith at 100) causes
pain and skill loss. Skill numbers follow `force/forceskills.lst`. See
Force below for the saved fields.

**Ships and space.** You buy, launch, and fight in ships. Primaries and
secondaries are separate weapon types and counts. Speed, maneuver, and size
decide whether a shot hits. Barrel roll evades beams. Juke evades warheads.
A black-market yard is any room flagged `blackmarket`. Simulators are ships
flagged `simulator` with a return room (`simvnum`). Clan shipyards are Sienar Fleet Systems and SoroSuub. Every prototype
the game loads is listed under Ships.

**Uncharted space.** Besides the named systems below, space holds 8,000
seeded systems. From a launched ship, `survey` jumps to a new one.
`explore` lands you on a small surface with wildlife and records the world.
`guide` lists the worlds you have walked. `warp <planet>` returns you only
to a world already in that guide. Charts are saved in `space/charts`. Each
character's guide is `space/guides/<name>.guide`.

**Prestige.** Five classes cap at level 10: Medic, Mandalorian, Inquisitor,
Royal Guard, and Gunner. `level` lists them. `help medic`, `help
mandalorian`, `help inquisitor`, `help royal guard`, and `help gunner` list
the requirements. Trainable skills include Command, Bargain, Gunnery, and
Beast Handling. Gunner levels also raise Gunnery.

**Law.** Infamy tracks theft and player killing. At 15 an equal bounty
hunter travels by ship, then on foot, and warns you as it gets close.
Killing it drops the contract for a while. At 35 a public trial jails you.
The sentence only ticks while you are online, then you are returned to the
room you left. Immortals can force it with `sendhunter <player>`. `infamy`
shows your score.

**Clans.** Booted clans are The Republic, The Sith Empire, The Jedi Order,
Antarian Rangers, The BlackSun Syndicate, Sienar Fleet Systems, SoroSuub,
and the Bounty Hunters Guild. There is no separate Galactic Empire clan.
Worlds that would be Imperial are held by The Sith Empire.

**Clients.** A client that accepts MSDP (telnet option 69) is offered
health, max health, movement, max movement, the room name, and the room
vnum with each prompt, so it can draw bars and a map beside the text.

In-game `help`, `wizhelp`, `hlist`, and `changes` are more detailed than
this file. Topic help includes `help map`, `help survey`, `help alias`,
`help house`, and `help qaccept`.

## Planets

Sixty worlds are on `planets/planet.lst` and load at boot. The system name
is the name in the `.system` file, which is what the ship computer shows.
A few film worlds sit in a system whose name is not the planet's name.
Those are called out in the last column.

`ossus.are` and `guild.are` are not on `area/area.lst`. Their room numbers
collide with Tatooine and the Sith academy. Ossus is in the Adegan system
but has no landing area until that file is renumbered. Alassa is not a
Star Wars planet and is not booted.

### The Sith Empire

| World | System | Note |
|---|---|---|
| Coruscant | Coruscant | |
| Corellia | Corell | system file `corell.system` |
| Kashyyyk | Kashyyyk | |
| Endor | Endor | |
| Bakura | Bakura | |
| Byss | Byss | |
| Bilbringi | Bilbringi | |
| Honoghr | Honoghr | |
| Korriban | Horuset | |
| Geonosis | Geonosis | |
| Mustafar | Mustafar | |
| Scarif | Scarif | |
| Eadu | Eadu | |
| Exegol | Exegol | |
| Malachor | Malachor | |
| Eriadu | Eriadu | |

### The Republic

| World | System | Note |
|---|---|---|
| Mon Calamari | Calamari | |
| Yavin IV | Yavin | |
| Naboo | Naboo | |
| Kamino | Kamino | |
| Christophsis | Christophsis | |
| Polis Massa | Polis Massa | |
| Hoth | Hoth | |
| Alderaan | Alderaan | |
| Crait | Crait | |
| Lothal | Lothal | |
| Dantooine | Dantooine | |
| Sullust | Sullust | |

### The Jedi Order

| World | System | Note |
|---|---|---|
| Ossus | Adegan | planet record only; no ground area |

### Neutral

| World | System | Note |
|---|---|---|
| Tatooine | Tatoo | Tatoo I and Tatoo II |
| Nal Hutta | Y'toub | shares the system with Nar Shaddaa |
| Nar Shaddaa | Y'toub | |
| Ord Mantell | Bright Jewel | |
| Bespin | Bespin | |
| Thorne Asteroid | Thorne | not a film world |
| XN1224-a | AB90152 - Asteroid belt | shares the belt with HP9015-l |
| HP9015-l | AB90152 - Asteroid belt | |
| Utapau | Utapau | |
| Felucia | Felucia | |
| Mygeeto | Mygeeto | |
| Saleucami | Saleucami | |
| Cato Neimoidia | Cato Neimoidia | |
| Dagobah | Dagobah | |
| Jedha | Jedha | |
| Jakku | Jakku | |
| Takodana | Takodana | |
| Ahch-To | Ahch-To | |
| Dathomir | Dathomir | |
| Mandalore | Mandalore | |
| Ryloth | Ryloth | |
| Kessel | Kessel | |
| Ilum | Ilum | |
| Onderon | Onderon | |
| Kuat | Kuat | |
| Bothawui | Bothawui | |
| Rodia | Rodia | |
| Umbara | Umbara | |
| Fondor | Fondor | |
| Florrum | Florrum | |
| Kalee | Kalee | |

## Star systems

`space/space.lst` loads 61 systems. Fifty-nine of them hold the worlds in
the tables above. Two do not:

| System | File | What it is |
|---|---|---|
| Simulator | `simulator.system` | cockpit simulators, not a place you hyperspace to |
| AB77173 - Asteroid belt | `AB77173.system` | a second belt, with no planet file |

Every other booted system has at least one planet. Shared systems:

| System | Worlds |
|---|---|
| Tatoo | Tatooine |
| Y'toub | Nal Hutta, Nar Shaddaa |
| Bright Jewel | Ord Mantell |
| Horuset | Korriban |
| Adegan | Ossus |
| Calamari | Mon Calamari |
| Yavin | Yavin IV |
| Corell | Corellia |
| Thorne | Thorne Asteroid |
| AB90152 - Asteroid belt | XN1224-a, HP9015-l |

The other 49 systems use the same name as their one world: Coruscant,
Kashyyyk, Endor, Bakura, Byss, Bespin, Honoghr, Bilbringi, Naboo, Kamino,
Geonosis, Mustafar, Utapau, Felucia, Mygeeto, Christophsis, Saleucami,
Polis Massa, Cato Neimoidia, Hoth, Dagobah, Alderaan, Scarif, Jedha, Eadu,
Jakku, Takodana, Ahch-To, Crait, Exegol, Lothal, Dathomir, Mandalore,
Ryloth, Kessel, Ilum, Malachor, Onderon, Dantooine, Kuat, Sullust, Eriadu,
Bothawui, Rodia, Umbara, Fondor, Florrum, and Kalee.

`survey` can still drop you in one of the 8,000 uncharted systems. Those
are not in `space.lst`. They are created when someone surveys, then saved
under `space/charts`.

## Ships

`ships/prototype.lst` loads 33 prototypes. The name is the first `Name`
line in each file, which is the hull you buy and fly. Later `Name` lines
in the same file are rooms inside that hull.

| Hull | File |
|---|---|
| X-Wing Multipurpose Fighter | `X-Wing.proto` |
| A-Wing Scout Fighter | `A-Wing.proto` |
| B-Wing Heavy Fighter | `B-Wing.proto` |
| Y-Wing Bomber | `Y-Wing.proto` |
| Incom Z-95 Headhunter | `Z-95.proto` |
| T-Wing Multirole Interceptor | `T-Wing.proto` |
| R-41 Starchaser | `R-41.proto` |
| HLAF-500 Light Attack Fighter | `HLAF-500.proto` |
| A-24 Sleuth Scout Ship | `A-24.proto` |
| Modified CloakShape Fighter | `C-Shape.proto` |
| Toscan Q-8 Multirole Starfighter | `Q-8.proto` |
| Preybird Heavy Assault Starfighter | `Preybird.proto` |
| GAT-12j Skipray Blastboat | `GAT-12j.proto` |
| XG-1 Assault Gunboat | `XG-1.proto` |
| XM-1 Missile Boat | `XM-1.proto` |
| Subpro TL-118 StarHammer | `TL-118.proto` |
| Twin Ion Engine Fighter | `TIE.proto` |
| TIE Bomber | `TIE.B.proto` |
| TIE Defender | `TIE.D.proto` |
| TIE Interceptor | `TIE.I.proto` |
| TIE Advanced x1 | `TIE.A.proto` |
| Firespray-31 Patrol Craft | `Firespray.proto` |
| YT-1300 Transport Freighter | `YT-1300.proto` |
| Ghtroc 720 Light Freighter | `G-720.proto` |
| Incom X-29 StarCarry | `X-29.proto` |
| T-4a Lambda Class Shuttle | `T-4a.proto` |
| GR-75 Medium Transport | `GR-75.proto` |
| Blockade Runner Corvette | `BRC.proto` |
| Nebulon-B Escort Frigate | `NebulonB.proto` |
| MC80 Star Cruiser | `MC80.proto` |
| MC-90 Mon Calamari Cruiser | `MC-90.proto` |
| Imperial class Star Destroyer | `ISD.proto` |
| Super class Star Destroyer | `SSD.proto` |

Four more prototype files sit in `ships/` and are not on `prototype.lst`, so they do not load: `CSH.proto` (Corellian System Hopper), `K-Wing.proto` (K-Wing Heavy Bomber), `CCC.proto` (Crusader Class Cruiser), and `Lambda.proto` (a second copy of the T-4a Lambda). The loaded Lambda is `T-4a.proto`.

## Force

Force does not use the old "feel" skill. A player's force block looks like:

```
Force           ## 0 #### ####
ForceControl    ##
ForceSense      ##
ForceAlter      ##
ForceChance     0 or 1
ForceId         0 or 1
ForceAlign      -100 to 100
ForceConverted  0 or 1
ForceType       0, 1, or 2
ForceLvlStatus  0, 1, 2, or 3
ForceSkill      ## ###
```

`ForceType` is 1 for Jedi and 2 for Sith. `ForceLvlStatus` is 1 apprentice,
2 knight or lord, 3 master. Skill numbers follow `force/forceskills.lst`.
Learned percent is 0 through 100. Opposite alignment (Jedi at -100, Sith at
100) causes pain and skill loss.

## Ships

Primaries and secondaries are `primaryType`, `secondaryType`, and their
counts, not a single laser stat. Hit checks use speed, maneuver, and ship
size. Barrel roll evades beams. Juke evades warheads.

A black-market yard is a room with the `blackmarket` flag. The list is
rebuilt on boot from clan ships. Simulators need `setship <ship> flags
simulator` and `setship <ship> simvnum <room>`. Without the return room,
destroying the simulator can crash the game.

If `shipvnum.are` is corrupt, replace it with `shipvnum.are.CLEAN` and
remove bought ships from the space directory.

## Older fixes

Players can save without being a graduate. Search `CODELYFE` in
`src/act_comm.c` and `src/save.c`. The starting area was also made easier.
A repeated-assignment bug in the old sources is described at
https://stackoverflow.com/questions/54794046/solved-error-lvalue-required-as-left-operand-of-assignment-swrots

Hard-ban, for a client that reconnects through a normal ban, is in `src/comm.c`.

## November 16, 2026

- The game links on current gcc (`-fcommon`) and boots to "SWRotS ready on port 1111".
- Boot no longer hangs on `corpses/ERASE_ME.txt`. A file with no newline used to spin forever inside `bug()`.
- Skill lookup includes the first skill. Missing combat skills, spells, and languages were added to `system/skills.dat`. `spell_smaug` and `do_backstab` load again.
- Resets that pointed at missing mobiles or objects were removed. Exits into missing rooms were removed, including room 669 down and room 9034 northwest.
- Ship and prototype loaders accept `Torpedos`, `primaryType`, `primaryCount`, `Simulator`, and the other weapon fields those files already contained.
- Every planet file on `planet.lst` loads. Coruscant, Yavin IV, Nar Shaddaa, Bespin, Byss, Honoghr, and Bilbringi load their ground areas. Systems were renamed to the film names: Tatoo, Bakura, Yavin, Bright Jewel, Horuset, and Adegan.
- Film ships added to `ships/prototype.lst`: TIE Interceptor, TIE Advanced, B-wing, Firespray-31, GR-75, Nebulon-B, and MC80. Lambda was already present as the T-4a.
- `look` can draw a small room map. `map` shows it once. `automap` turns it on or off. In-game help: `help map`.
- `build.bat`, `start.bat`, and `stop.bat` in the repo root build, start, and stop the server through WSL. The game listens on port 1111. The log is `log/server.log`.
- All forty new worlds now have longer rooms, a deeper wing past the landing site, and people on the ground. Naboo, Kamino, Hoth, and Dagobah were done first. The rest, from Geonosis and Mustafar through Fondor, Florrum, and Kalee, follow the same pattern: a local, a worker, and someone who will sell you a thing from that world.
- Uncharted space is 8,000 seeded systems. From a launched ship, `survey` jumps to a new one. `explore` lands you on a small surface with wildlife and records the world. `guide` lists the worlds you have walked. `warp <planet>` returns you only to a world already in that guide. Charts are saved in `space/charts`. Each character's guide is `space/guides/<name>.guide`. In-game help: `help survey`.
- Five prestige classes were added, each with a max level of 10: Medic, Mandalorian, Inquisitor, Royal Guard, and Gunner. `level` lists them. `help medic`, `help mandalorian`, `help inquisitor`, `help royal guard`, and `help gunner` list the requirements.
- Trainable skills added to `skills`: Command, Bargain, Gunnery, and Beast Handling. Gunner levels also raise Gunnery. Joke commands anyone can use: `weed`, `cig`, `coffee`, `fart`, and `hiccup`. `smoke` still needs a lit pipe.
- Infamy tracks player theft and player killing. At 15 an equal bounty hunter travels by ship, then on foot, and warns you as it gets close. Killing it drops the contract for a while. At 35 a public trial jails you; the sentence only ticks while you are online, then you are returned to the room you left. Immortals can force it with `sendhunter <player>`. `infamy` shows your score.
- `alias` saves up to eight names for longer commands, and they are written on the character. `alias n north` makes `n` walk north. `alias greet say Hello there.` saves a whole line. `alias n` removes that one. The saved name has to match exactly, so a short alias does not steal a longer command the way `survey` used to steal `s`. In-game help: `help alias`.
- Clients that accept MSDP (telnet option 69) get health, max health, movement, max movement, the room name, and the room vnum with each prompt, so a client can draw bars and a map beside the text. The game offers it when you connect.
- A player can buy the room they are standing in with `buyhouse` for 25,000 credits. One house per character. It starts locked. `house unlock` and `house lock` open and close it. `house guest <name>` and `house unguest <name>` name who may enter while it is locked. The owner, a named guest, and immortals can always enter. Houses are saved in `system/houses.dat`. This is separate from clan storerooms. In-game help: `help house`.
- Builder quests are in `system/quests.dat`. Each quest has an id, a name, a giver mobile, a credit prize, and up to six stages. A stage is either visit a room (`R`) or kill a mobile (`M`). Standing with the giver, `qaccept` starts it, `qstat` shows the current stage, and `qfinish` pays the prize when every stage is done. Progress is saved on the character. The old `quest` command is still the quest talk channel. One sample is already loaded: an Academy errand from the receptionist on Honoghr. In-game help: `help qaccept`.
