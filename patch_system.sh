############## get delta.zip ############
# Requires a git repository, containing at least two versions of the ROM, and tool bsdiff isntalled. Generates diffs 
# between changed files using bsdiff. usage: get_delta *BASE* *COMMIT*,
#	e.g. get_delta HEAD~1 HEAD
get_delta() {
    git reset --hard $1
    git clean -fd
    git cherry-pick -n $2
    
    for i in $(git status -uno | grep modified)
    do
        echo $i | cut -d':' -f 2 >> files.txt
    done
    files=$(tr '\n' ' ' < files.txt)
    mkdir out
    cp --parents $files out
    
    git reset --hard
    for i in $files
    do
        bsdiff $i out/$i out/$i.bsdiff
        rm out/$i
    done
    cd out
    cp ../files.txt $PWD
    zip -0r ../delta.zip *
}

########## apply delta.zip ##################
# Applies diffs that contains in delta.zip to the ROM. usage: apply_delta *ROM*,
# 	e.g. apply_delta vanir_codina_4.4.4.091715.zip
apply_delta() {
    rm -fr out system
    unzip delta.zip
    files=$(cat files.txt)
    
    for i in $(find system)
    do
        if test -d $i ; then
            mkdir -p out/$i
        fi
    done
    unzip $1 $files
    
    for i in $files
    do
        bspatch $i out/$i $i.bsdiff
        rm $i.bsdiff
    done
    
    cp out/* $PWD -r
    rm -fr out
    cp $1 $1.bak
    zip -9r $1 $files
}
