#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

void *save_top_logs(void *arg)
{
    while (1) {
        system("top -n 1 > /run/log1");
        sleep(1);
    }
}

void *save_meminfo_logs(void *arg)
{
    while (1) {
        system("cat /proc/meminfo > /run/log2");
        sleep(1.5);
    }
}

void *save_cpuinfo_logs(void *arg)
{
    while (1) {
        system("cat /proc/cpuinfo > /run/log3");
        sleep(2);
    }
}

void *save_interrupts_logs(void *arg)
{
    while (1) {
        system("cat /proc/interrupts > /run/log4");
        sleep(3);
    }
}

void *save_uptime_logs(void *arg)
{
    while (1) {
        system("cat /proc/uptime > /run/log5");
        sleep(3.5);
    }
}

int main()
{
    pthread_t tid1, tid2, tid3, tid4, tid5;
    pthread_create(&tid1, NULL, save_top_logs, NULL);
    pthread_create(&tid2, NULL, save_meminfo_logs, NULL);
    pthread_create(&tid3, NULL, save_cpuinfo_logs, NULL);
    pthread_create(&tid4, NULL, save_interrupts_logs, NULL);
    pthread_create(&tid5, NULL, save_uptime_logs, NULL);

    pthread_join(tid1, NULL);
    pthread_join(tid2, NULL);
    pthread_join(tid3, NULL);
    pthread_join(tid4, NULL);
    pthread_join(tid5, NULL);

    return 0;
}
