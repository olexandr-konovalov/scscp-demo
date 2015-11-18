#############################################################################
#
# This is the SCSCP server configuration file.
# The service provider can start the server just by the command 
# $ gap myserver.g
#
#############################################################################

#############################################################################
#
# Load necessary packages and read external files. 
# Put here and other commands if needed.
#
#############################################################################

LogTo(); # to close log file if it was opened from .gaprc
LoadPackage("scscp");
Read("avgord.g");

#############################################################################
#
# Procedures and functions available for the SCSCP server
# (you can also install procedures contained in other files,
# including standard GAP procedures and functions) by adding
# appropriate calls to InstallSCSCPprocedure below.
#
#############################################################################


#############################################################################

# Simple procedures for tests and demos
InstallSCSCPprocedure( "Identity", x -> x, "Identity procedure for tests", 1, 1 );
InstallSCSCPprocedure( "Factorial", Factorial, "See ?Factorial in GAP", 1, 1 );
InstallSCSCPprocedure( "Phi", Phi, "Euler's totient function, see ?Phi in GAP", 1, 1 );

IsExampleGroup:= G -> IsInt( AvgOrdOfCollection(G) );

SearchForGroupExamples:=function( a )
local res;
res := TestOneOrderVariadic( IsExampleGroup, a[1], a[2], a[3] ); 
if res = fail then
  res := [];
fi;
return res;
end;

InstallSCSCPprocedure("SearchForGroupExamples", SearchForGroupExamples);

#############################################################################
#
# Finally, we start the SCSCP server. 
#
#############################################################################

RunSCSCPserver( SCSCPserverAddress, SCSCPserverPort );
