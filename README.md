. patch_system.sh

1) generate delta.zip

Requires a git repository, containing at least two versions of the ROM, and tool bsdiff isntalled. Generates diffs 
between changed files using bsdiff. 

usage: gen_delta [OPTION] *BASE* *COMMIT*, e.g. get_delta HEAD~1 HEAD .

2) apply delta.zip

Applies diffs that contains in delta.zip to the ROM. The file delta.zip should be placed into the same directory as a ROM.

usage: apply_delta [OPTION] *ROM*, e.g. apply_delta vanir_codina_4.4.4.091715.zip .

3) generate update.zip

Generates file update.zip with patched ROM files using an existing delta.zip file with diffs.

Usage: gen_update [OPTION] *ROM*, e.g. gen_update vanir_codina_4.4.4.091715.zip

Options:
      -d (--disable-md5-check): disable checking md5sum of files that are being patched.
