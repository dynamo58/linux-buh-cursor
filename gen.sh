#!/bin/bash

# preflight
if [ ! -d cursors ];then
    mkdir cursors
fi

# create the .config file for xcursorgen

gen_cursor_cfg_file() {
    for size in 16 32 64; do
        for ((i = 0; i < 119; i++)); do
            printf "%d 2 4 %s_frame_%03d_delay-0.05s.png 50\n" $size $size $i
        done
    done
}

gen_cursor_cfg_file > buh.cursor

# all the different cursor faces to be generated
cursor_faces_other_than_default() {
    echo alias
    echo all-scroll
    echo arrow
    echo bd_double_arrow
    echo bottom_left_corner
    echo bottom_right_corner
    echo bottom_side
    echo cell
    echo col-resize
    echo context-menu
    echo copy
    echo cross
    echo cross_reverse
    echo crosshair
    echo diamond_cross
    echo e-resize
    echo ew-resize
    echo fd_double_arrow
    echo fleur
    echo grab
    echo grabbing
    echo hand1
    echo hand2
    echo help
    echo left_ptr
    echo left_side
    echo move
    echo n-resize
    echo ne-resize
    echo nesw-resize
    echo no-drop
    echo not-allowed
    echo ns-resize
    echo nw-resize
    echo nwse-resize
    echo pointer
    echo progress
    echo question_arrow
    echo right_side
    echo row-resize
    echo s-resize
    echo sb_h_double_arrow
    echo sb_v_double_arrow
    echo se-resize
    echo sw-resize
    echo tcross
    echo text
    echo top_left_arrow
    echo top_left_corner
    echo top_right_corner
    echo top_side
    echo vertical-text
    echo w-resize
    echo wait
    echo watch
    echo xterm
    echo zoom-in
    echo zoom-out
}

# prepare the frames
cd cursors/
find . -delete

unzip -j ../buh_frames.zip -d .
xcursorgen ../buh.cursor default

# let xcursorgen do its magic
cursor_faces_other_than_default | while read -r word; do
    ln -s default $word
done

# clean up
find . -name "*.png" -type f -delete
rm ../buh.cursor
