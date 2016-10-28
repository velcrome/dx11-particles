#include "../fxh/Defines.fxh"

/*
The flagbuffer holds all flags that are needed for the particle ecosystem.
Flags currently used:
0 -> SelectionFlag ( false = modifiers iterate over all particles / true => modifiers iterate over SelectionPointerBuffer)

*/

RWStructuredBuffer<bool> FlagBuffer : FLAGBUFFER;
bool HasSelection = false;

struct csin
{
	uint3 DTID : SV_DispatchThreadID;
	uint3 GTID : SV_GroupThreadID;
	uint3 GID : SV_GroupID;
};

[numthreads(XTHREADS, YTHREADS, ZTHREADS)]
void CS_SetSelectionFlag(csin input)
{
	if(input.DTID.x > 0) return;
	FlagBuffer[0] = HasSelection;
	
}

technique11 SelectionFlag { pass P0{SetComputeShader( CompileShader( cs_5_0, CS_SetSelectionFlag() ) );} }
