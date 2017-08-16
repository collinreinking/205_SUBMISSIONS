##### 1. What is the shortest path between 'DR. STRANGE/STEPHEN' and 'DR. DOOM/VICTOR VON'?
###### Please provide: the query, the Text side tab results of running the query, and the answer.
###### Query
    MATCH p=(strange:Hero {name: 'DR. STRANGE/STEPHEN'})-[:APPEARED*0..2]-(doom:Hero {name: 'DR. DOOM/VICTOR VON'})
    RETURN p, length(p)
    ORDER BY length(p)
    LIMIT 1
###### Text
    ╒══════════════════════════════════════════════════════════════════════╤═══════════╕
    │"p"                                                                   │"length(p)"│
    ╞══════════════════════════════════════════════════════════════════════╪═══════════╡
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":8},{"name":"DR. DOOM│1          │
    │/VICTOR VON","degree":441}]                                           │           │
    └──────────────────────────────────────────────────────────────────────┴───────────┘
#### Answer
    The shortest path between Dr. Strange and Dr. Doom is 1.
#### 2. List the 5 shortest paths between 'DR. STRANGE/STEPHEN' and 'DR. DOOM/VICTOR VON'.
##### Please provide: the query and the Text side tab results of running the query.
##### Only provide 5 even if there are ties (hint: use the LIMIT 5 clause in the query).
###### Query
    MATCH p=(strange:Hero {name: 'DR. STRANGE/STEPHEN'})-[:APPEARED*0..2]-(doom:Hero {name: 'DR. DOOM/VICTOR VON'})
    RETURN p, length(p)
    ORDER BY length(p)
    LIMIT 5
#### Text
    ╒══════════════════════════════════════════════════════════════════════╤═══════════╕
    │"p"                                                                   │"length(p)"│
    ╞══════════════════════════════════════════════════════════════════════╪═══════════╡
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":8},{"name":"DR. DOOM│1          │
    │/VICTOR VON","degree":441}]                                           │           │
    ├──────────────────────────────────────────────────────────────────────┼───────────┤
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":12},{"name":"DR. DOO│1          │
    │M/VICTOR VON","degree":441}]                                          │           │
    ├──────────────────────────────────────────────────────────────────────┼───────────┤
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":2},{"name":"THUNDERB│2          │
    │ALL/DR. ELIO","degree":138},{"name":"THUNDERBALL/DR. ELIO","degree":13│           │
    │8},{"w":6},{"name":"DR. DOOM/VICTOR VON","degree":441}]               │           │
    ├──────────────────────────────────────────────────────────────────────┼───────────┤
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":2},{"name":"THUNDERB│2          │
    │ALL/DR. ELIO","degree":138},{"name":"THUNDERBALL/DR. ELIO","degree":13│           │
    │8},{"w":6},{"name":"DR. DOOM/VICTOR VON","degree":441}]               │           │
    ├──────────────────────────────────────────────────────────────────────┼───────────┤
    │[{"name":"DR. STRANGE/STEPHEN","degree":777},{"w":3},{"name":"CAPTAIN │2          │
    │BRITAIN/BRIA","degree":327},{"name":"CAPTAIN BRITAIN/BRIA","degree":32│           │
    │7},{"w":2},{"name":"DR. DOOM/VICTOR VON","degree":441}]               │           │
    └──────────────────────────────────────────────────────────────────────┴───────────┘
#### 3. List 5 Friends of Friends of 'COLOSSUS II/PETER RA' with the most connections.
##### Please provide: the query and the Text side tab results of running the query.
##### Only provide 5 even if there are ties (hint: use the LIMIT 5 clause in the query)
###### Query
    MATCH (peter:Hero { name: 'COLOSSUS II/PETER RA' })-[:APPEARED*2..2]-(friend_of_friend)
    WHERE NOT (peter)-[:APPEARED]-(friend_of_friend)
    AND friend_of_friend.name <> 'COLOSSUS II/PETER RA'
    RETURN friend_of_friend.name, COUNT(*)
    ORDER BY COUNT(*) DESC , friend_of_friend.name
    LIMIT 5
###### Text
    ╒═══════════════════════╤══════════╕
    │"friend_of_friend.name"│"COUNT(*)"│
    ╞═══════════════════════╪══════════╡
    │"WONG"                 │453       │
    ├───────────────────────┼──────────┤
    │"MOONSTONE II/KARLA S" │370       │
    ├───────────────────────┼──────────┤
    │"CARTER, PEGGY"        │367       │
    ├───────────────────────┼──────────┤
    │"POWER MAN/ERIK JOSTE" │350       │
    ├───────────────────────┼──────────┤
    │"KINGPIN/WILSON FISK"  │342       │
    └───────────────────────┴──────────┘
#### 4. Visualize 10 Friends of friends for 'IRON MAN/TONY STARK'.
##### Please provide: the query and an image of the graph visualization.
##### Only provide 10 even if there are ties
##### (hint: use the LIMIT 10 clause in the query)
###### Query
    MATCH (tony:Hero { name: 'IRON MAN/TONY STARK' })-[:APPEARED*2..2]-(friend_of_friend)
    WHERE NOT (tony)-[:APPEARED]-(friend_of_friend)
    AND friend_of_friend.name <> 'IRON MAN/TONY STARK'
    RETURN friend_of_friend
    LIMIT 10
###### Image
![q4.png](./q4.png?raw=true)
#### 5. Visually discover how the Avengers grew over time from 5 to 10 members, who was added to the team, and verify connectivity.
##### Please provide for each run of the query (6 total runs):
##### The query, a list of member for this run, a statement as to whether or not the graph is fully connected, and the an image of the graph visualization
##### (hint: use the LIMIT 10 clause in the query)
###### Query 5 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 3
###### List 5 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
###### Connected? 5 Members
    The graph is fully connected
###### Image 5 Members
![q5_5.png](./q5_5.png?raw=true)
###### Query 6 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 4
###### List 6 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
    "WASP/JANET VAN DYNE"
###### Connected? 6 Members
    The graph is fully connected
###### Image 6 Members
![q5_6.png](./q5_6.png?raw=true)
###### Query 7 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 5
###### List 7 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
    "WASP/JANET VAN DYNE"
    "ANT-MAN/DR. HENRY J."
###### Connected? 7 Members
    The graph is fully connected
###### Image 7 Members
![q5_7.png](./q5_7.png?raw=true)
###### Query 8 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 6
###### List 8 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
    "WASP/JANET VAN DYNE"
    "ANT-MAN/DR. HENRY J."
    "WONDER MAN/SIMON WIL"
###### Connected? 8 Members
    The graph is fully connected
###### Image 8 Members
![q5_8.png](./q5_8.png?raw=true)
###### Query 9 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 7
###### List 9 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
    "WASP/JANET VAN DYNE"
    "ANT-MAN/DR. HENRY J."
    "WONDER MAN/SIMON WIL"
    "HAWK"
###### Connected? 9 Members
    The graph is fully connected
###### Image 9 Members
![q5_9.png](./q5_9.png?raw=true)
###### Query 10 Members
    MATCH (tony:Hero {name:'IRON MAN/TONY STARK'}) -[e:APPEARED]-> (other) <-[f:APPEARED]- (donald:Hero {name:'THOR/DR. DONALD BLAK'})
    RETURN tony, donald, other
    ORDER BY e.w DESC, f.w DESC
    LIMIT 8
###### List 10 Members
    "IRON MAN/TONY STARK"
    "THOR/DR. DONALD BLAK"
    "CAPTAIN AMERICA"
    "SCARLET WITCH/WANDA"
    "VISION"
    "WASP/JANET VAN DYNE"
    "ANT-MAN/DR. HENRY J."
    "WONDER MAN/SIMON WIL"
    "HAWK"
    "IRON MAN IV/JAMES R."
###### Connected? 10 Members
    The graph is fully connected
###### Image 10 Members
![q5_10.png](./q5_10.png?raw=true)
