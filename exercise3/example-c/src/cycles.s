.section .text
.global get_time

get_time:
    csrr a0, time
    ret