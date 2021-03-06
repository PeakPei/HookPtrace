//一般来说都是调用ptrace(31,0,0,0)，并没有处理返回值

#import <substrate.h>

#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif

static int (*_ptraceHook)(int request, pid_t pid, caddr_t addr, int data); 

static int $ptraceHook(int request, pid_t pid, caddr_t addr, int data) {

       //return 0; //直接返回0
        if (request == PT_DENY_ATTACH) { 
        request = -1; 
        }
        return _ptraceHook(request,pid,addr,data);  
}

%ctor {
        MSHookFunction((void *)MSFindSymbol(NULL,"_ptrace"), (void *)$ptraceHook, (void **)&_ptraceHook);
}

