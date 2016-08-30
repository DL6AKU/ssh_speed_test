# ssh_speed_test
Speed test for some SSH ciphers

Sample output:
```
% ./ssh_speed_test.sh                                                                                                                                :(
Linux messung 3.19.0-66-generic #74~14.04.1-Ubuntu SMP Tue Jul 19 19:56:11 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux
OpenSSH_6.6.1p1 Ubuntu-2ubuntu2.8, OpenSSL 1.0.1f 6 Jan 2014
CPU:       Intel(R) Core(TM) i5 CPU       M 540  @ 2.53GHz (Number of cores: 4)
CPU flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 sse4_2 popcnt aes lahf_lm ida arat dtherm tpr_shadow vnmi flexpriority ept vpid

Starting Benchmark:

+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
|             CIPHER             |   TIME (s)   |     CPU      | SPEED (MB/s) |                       SPEED (bar graph)                      |
+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
|  chacha20-poly1305@openssh.com |     3.84     |     104%     |    100.00    | +++++++++++                                                  |
|                     aes128-ctr |     1.41     |     120%     |    272.34    | ++++++++++++++++++++++++++++                                 |
|                     aes256-ctr |     1.68     |     112%     |    228.57    | +++++++++++++++++++++++                                      |
|         aes128-gcm@openssh.com |     1.62     |     113%     |    237.04    | ++++++++++++++++++++++++                                     |
|         aes256-gcm@openssh.com |     1.82     |     109%     |    210.99    | ++++++++++++++++++++++                                       |
|                        arcfour |     2.73     |      98%     |    140.66    | +++++++++++++++                                              |
|                     arcfour128 |     2.42     |     106%     |    158.68    | ++++++++++++++++                                             |
|                     arcfour256 |     2.48     |     106%     |    154.84    | ++++++++++++++++                                             |
|                   blowfish-cbc |     6.36     |      99%     |     60.38    | +++++++                                                      |
|                    cast128-cbc |     6.18     |      98%     |     62.14    | +++++++                                                      |
|                       3des-cbc |    24.09     |      97%     |     15.94    | ++                                                           |
+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
```

```
# ./ssh_speed_test.sh 
Linux semirhage 4.1.10-1-ck #1 SMP PREEMPT Tue Oct 6 20:16:42 CEST 2015 x86_64 GNU/Linux
OpenSSH_7.3p1, OpenSSL 1.0.2h  3 May 2016
CPU:       Intel(R) Core(TM)2 Quad CPU    Q9400  @ 2.66GHz (Number of cores: 4)
CPU flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1 xsave lahf_lm dtherm tpr_shadow vnmi flexpriority

Starting Benchmark:

+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
|             CIPHER             |   TIME (s)   |     CPU      | SPEED (MB/s) |                       SPEED (bar graph)                      |
+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
|  chacha20-poly1305@openssh.com |     2.95     |     104%     |    130.17    | ++++++++++++++                                               |
|                     aes128-ctr |     4.16     |     102%     |     92.31    | ++++++++++                                                   |
|                     aes256-ctr |     4.60     |     102%     |     83.48    | +++++++++                                                    |
|         aes128-gcm@openssh.com |     3.39     |     103%     |    113.27    | ++++++++++++                                                 |
|         aes256-gcm@openssh.com |     3.85     |     103%     |     99.74    | ++++++++++                                                   |
|                        arcfour |     3.79     |     103%     |    101.32    | +++++++++++                                                  |
|                     arcfour128 |     3.78     |     103%     |    101.59    | +++++++++++                                                  |
|                     arcfour256 |     3.78     |     102%     |    101.59    | +++++++++++                                                  |
|                   blowfish-cbc |     6.85     |     101%     |     56.06    | ++++++                                                       |
|                    cast128-cbc |     7.10     |     101%     |     54.08    | ++++++                                                       |
|                       3des-cbc |    22.98     |     100%     |     16.71    | ++                                                           |
+--------------------------------+--------------+--------------+--------------+--------------------------------------------------------------+
```
