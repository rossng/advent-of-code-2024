{ stdenv, lib }:
let
  input = builtins.readFile ./day1.txt;
  lines = lib.splitString "\n" input;
  # Split each line into a pair of numbers separated by any number of spaces
  splitLine = line:
    let
      groups = lib.split "([[:digit:]]+)" line;
      matches = lib.filter (x: lib.isList x) groups;
      firstMatches = lib.map (x: lib.head x) matches;
    in firstMatches;
  splitLines = lib.map splitLine lines;

  # Filter out any lines that don't have exactly a pair of numbers
  filteredLines = lib.filter (x: lib.length x == 2) splitLines;

  # Parse each pair of strings to a pair of numbers using lib.strings.toInt
  parsePair = pair: [ (lib.toInt (lib.head pair)) (lib.toInt (lib.last pair)) ];
  parsedLines = (lib.map parsePair filteredLines);

  # Transpose the list of pairs into a pair of lists
  transpose = list:
    lib.foldl (acc: x: {
      left = acc.left ++ [ (lib.head x) ];
      right = acc.right ++ [ (lib.last x) ];
    }) {
      left = [ ];
      right = [ ];
    } list;
  transposed = (transpose parsedLines);

  # Sort both of the lists
  sortedLeft = lib.sort (a: b: a < b) transposed.left;
  sortedRight = lib.sort (a: b: a < b) transposed.right;

  # Zip the two lists together, finding the absolute difference of each pair
  abs = num: if num < 0 then -num else num;
  zipped = (lib.zipLists sortedLeft sortedRight);
  absoluteDifferences = lib.map (pair: abs (pair.fst - pair.snd)) zipped;

  # Sum the absolute differences
  sum = toString (lib.foldl (acc: x: acc + x) 0 absoluteDifferences);
in stdenv.mkDerivation {
  name = "day1";
  src = ./day1.txt;
  buildCommand = ''
    cp $src day1.txt
    echo '#!/usr/bin/env bash' > day1
    echo "echo ${sum}" >> day1
    chmod +x day1
    mkdir -p $out/bin
    mv day1 $out/bin/
  '';
}
