#include <mach-o/dyld.h>
#include <substrate.h>
#import <Foundation/Foundation.h>

static int MOVE_TYPE_INTERNAL = -1; 
static int IS_AIMED_DOWN_SIGHTS_INTERNAL = 0;
static int IS_PRESSING_FIRE_BUTTON_INTERNAL = 0;
static bool HOOKER_INTERNAL = false;

bool ph_is_hooker(void) {
    return HOOKER_INTERNAL;
}

int ph_get_move_type(void){
    return MOVE_TYPE_INTERNAL;
}

int ph_get_is_aimed_down_sights(void){
    return IS_AIMED_DOWN_SIGHTS_INTERNAL;
}

int ph_get_is_pressing_fire_button(void){
    return IS_PRESSING_FIRE_BUTTON_INTERNAL;
}

static inline int is_local_player(void *obj){
    return (*(char *)((uint64_t)obj + 0x128) == 2);
}

static void *(*sub_101c306c0)(void *, float);

static void *_sub_101c306c0(void *_this, float arg1){
    if(is_local_player(_this)){
        void *x8 = *(void **)((uint64_t)_this + 0x1190);

        if(x8)
            MOVE_TYPE_INTERNAL = *(char *)((uint64_t)x8 + 0x1c4);
    }

    return sub_101c306c0(_this, arg1);
}

static void (*sub_101be39f0)(void *, char);

static void _sub_101be39f0(void *_this, char arg1){
    IS_AIMED_DOWN_SIGHTS_INTERNAL = *(char *)((uint64_t)_this + 0x114);

    sub_101be39f0(_this, arg1);
}

static void (*sub_101c33950)(void *);

static void _sub_101c33950(void *_this){
    sub_101c33950(_this);

    if(!is_local_player(_this))
        return;

    void *x8 = *(void **)((uint64_t)_this);

    if(!x8)
        return;

    x8 = *(void **)((uint64_t)x8 + 0x9a0);

    if(!x8)
        return;

    void *(*x8_fxnptr)(void *) = (void *(*)(void *))x8;
    void *x0 = x8_fxnptr(_this);

    if(!x0)
        return;

    int w8 = 0x2808;

    IS_PRESSING_FIRE_BUTTON_INTERNAL = *(char *)((uint64_t)x0 + w8);
}

#define HOOK(offset, ptr, orig) \
MSHookFunction((void *)(offset + slide), (void *)ptr, (void **)&orig)

void ph_initialize(void){

    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSComparisonResult result
    = [@"0.13.0" compare:version
                    options:NSNumericSearch | NSCaseInsensitiveSearch];
    if (result == NSOrderedSame){
        
        HOOKER_INTERNAL = true;
        NSLog(@"PUBC: WHAT ARE THOSE, HOOKS? GET OUT OF HERE YA BUNCH OF HOOKERS!");
        uint64_t slide = _dyld_get_image_vmaddr_slide(0);
        HOOK(0x101c306c0, _sub_101c306c0, sub_101c306c0);
        HOOK(0x101be39f0, _sub_101be39f0, sub_101be39f0);
        HOOK(0x101c33950, _sub_101c33950, sub_101c33950);
    }
    
}
