### Submission 1
##### How many rows are missing a value in the "State" column? Explain how you came up with the number.
    5377

    Menu selection:
    State > Facet > Customized Facets > Facet by blank
    There are 5377 that show "true" in this facet.
    I also saw this same number when looking at the "text facet" for this attribute.

### SUBMISSION 2:
##### How many rows with missing ZIP codes do you have?
    4362

    There are 4362 rows with blank entries for the zip code.

### SUBMISSION 3:
##### If you consider all ZIP codes less than 99999 to be valid, how many valid and invalid ZIP codes do you have, respectively?
    Number of Valid: 345175
    Number of Invalid: 34961

    There are 346175 valid ZIP codes and 34961 invalid ZIP codes (and 4362 blank Zip codes).

### SUBMISSION 4:
##### Change the radius to 3.0. What happens? Do you want to merge any of the resulting matches?
    (note: I had casted all of my locations to lowercase)
    The clusters then include "indonesia" and "micronesia" as well as "tajikistan" and "pakistan".  I do not want to merge these results.  However, I do have a cluster that pairs "california" with "cailfornia," these are results I would merge.

### SUBMISSION 5:
##### Change the block size to 2. Give two examples of new clusters that may be worth merging.

    With block size two I see the following clusters that may be worth merging:
    ====
    california(84 rows)
    caliofrnia(1 rows)
    calfiornia(1 rows)
    cailfornia(1 rows)
    ====
    alaska(795 rows)
    alska(1 rows)
    ====

    I can also see that there are some misspellings of "canada" as well as some other misspellings of "alaska" but they are always clustered with other locations with the current settings.


### SUBMISSION 6:
##### Explain in words what happens when you cluster the "place" column, and why you think that happened. What additional functionality could OpenRefine provide to possibly deal with the situation?

    When I run different methods of clustering on the "place" I frequently get results that are just in different directions of the same location (e.g. "... SSE of Berkeley" and "...SE of Berkeley").  Trying to run a reasonable "nearest neighbor" cluster takes a long long time (I've been waiting long enough to simply hit close now.)

    Open refine could allow clustering to compare words against predefined lists (i.e. a list of location names).  Alternatively they could provide a function for automatically converting latitude and longitude data to location names.


### SUBMISSION 7:
##### Submit a representation of the resulting matrix from the Levenshtein edit distance calculation. The resulting value should be correct.

         1 2 3 4 5 6 7 8 9 10
           G U M B A R R E L
    1    0 1 2 3 4 5 6 7 8 9
    2  G 1 0 1 2 3 4 5 6 7 8
    3  U 2 1 0 1 2 3 4 5 6 7
    4  N 3 2 1 1 2 3 4 5 6 7
    5  B 4 3 2 2 1 2 3 4 5 6
    6  A 5 4 3 3 2 1 2 3 4 5
    7  R 6 5 4 4 3 2 1 2 3 4
    8  E 7 6 5 5 4 3 2 2 2 3
    9  L 8 7 6 6 5 4 3 3 3 2
    10 L 9 8 7 7 6 5 4 4 4 3

    >>> distance("gumbarrel","gunbarell")
    3
