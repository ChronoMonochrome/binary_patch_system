. patch_system.sh

1) get delta.zip

Requires a git repository, containing at least two versions of the ROM, and tool bsdiff isntalled. Generates diffs 
between changed files using bsdiff. 

usage: get_delta *BASE* *COMMIT*, e.g. get_delta HEAD~1 HEAD .

2) apply delta.zip

Applies diffs that contains in delta.zip to the ROM. The file delta.zip should be placed into the same directory as a ROM.

usage: apply_delta *ROM*, e.g. apply_delta vanir_codina_4.4.4.091715.zip .
