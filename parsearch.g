LoadPackage("scscp");

# Specify the range of ports to use
SCSCPservers:=List([26101..26102], i-> ["localhost",i]);

# InfoLevel to see the progress of computation
SetInfoLevel(InfoMasterWorker,5);

####################################################################
#
# ParSearchForGroupExamples
#
# Performs parallel search among small groups of order `order` with
# numbers in the range [min..max] in chunks of `chunksize` elements
#
ParSearchForGroupExamples := function( order, min, max, chunksize )
local tasks, r1, r2, t1, t2, result;

if not ForAll( [ order, min, max, chunksize ], IsPosInt ) then
  Error("All arguments must be positive integers\n" );
fi;
if not min in [1..NrSmallGroups(order)] then
  Error("The 2nd argument must belong to ", [1..NrSmallGroups(order)], "\n" );
fi;
if not max in [1..NrSmallGroups(order)] then
  Error("The 3rd argument must belong to ", [1..NrSmallGroups(order)], "\n" );
elif max < min then
  Error("The 3rd argument must be greater or equal than the 2nd \n" );
fi;

tasks := [];
r1 := min;
r2 := Minimum(r1+chunksize-1,max);
repeat
  Add( tasks, [ order, r1, r2 ] );
  r1 := r1 + chunksize;
  r2 := Minimum(r2+chunksize,max);
until r1>max;
result := ParListWithSCSCP( tasks, "SearchForGroupExamples" );
return result;
end;
