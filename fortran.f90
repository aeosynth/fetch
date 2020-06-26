PROGRAM fetch
        IMPLICIT NONE
        CHARACTER(LEN=255) :: user, hostname, kernel, term, shell, a, b
        REAL :: uptime
        INTEGER :: d, h, m, t, f
        CHARACTER(LEN=255) :: fmt
        fmt = '(A,A,A,/,A,A,/,A,A,/,A,A,/,A,I2,A,I2,A,I2,A)'
        CALL GET_ENVIRONMENT_VARIABLE("USER", user)
        CALL GET_ENVIRONMENT_VARIABLE("TERM", term)
        CALL GET_ENVIRONMENT_VARIABLE("SHELL", shell)
        OPEN(10, FILE='/etc/hostname')
        READ(10, *) hostname
        CLOSE(10)
        OPEN(11, FILE='/proc/version')
        READ(11, '(A)') kernel
        CLOSE(11)
        OPEN(12, FILE='/proc/uptime')
        READ(12, *) uptime
        d = ((uptime / 60) / 60) / 24
        h = MOD(INT((uptime / 60) / 60), 24)
        m = MOD(INT(uptime / 60), 60)
        CLOSE(12)
        OPEN(13, FILE='/proc/meminfo')
        READ(13, '(A,/,A)') a, b
        read(a,*) t
        read(b,*) f
        CLOSE(13)
        WRITE(*,'(I6,/,I6)') t, f
        WRITE (*,TRIM(fmt)) TRIM(user), "@", TRIM(hostname), &
                "kernel  ", TRIM(kernel(15:28)), &
                "term    ", TRIM(term), &
                "shell   ", TRIM(shell), &
                "uptime  ", d, "d ", h, "h ", m, "m"
END PROGRAM fetch
