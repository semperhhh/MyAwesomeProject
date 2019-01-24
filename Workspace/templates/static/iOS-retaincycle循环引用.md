
date: 2018-03-17 15:22:10
pid: 19012407;

---

# iOS-retaincycle循环引用

## retain cycle循环引用

循环引用最常出现在block中,一个对象中强引用了block,在block中又强引用了该对象,就会发生循环引用. <!--more-->

解决方法一般是两种:

	1.事前避免:将该对象使用_weak或者_block修饰符修饰之后再在block中使用;
	2.时候补救:将其中一方强制置空 xx == nil;

只有当block直接或间接的被self持有时,才需要weakself.如果在block内需要多次访问self,则需要使用strongself.

当 block 本身不被 self 持有，而被别的对象持有，同时不产生循环引用的时候，就不需要使用 weak self 了。最常见的代码就是 UIView 的动画代码，我们在使用 UIView 的 animateWithDuration:animations 方法 做动画的时候，并不需要使用 weak self，因为引用持有关系是：

* UIView 的某个负责动画的对象持有了 block 
* block 持有了 self 
* 因为 self 并不持有 block，所以就没有循环引用产生，因为就不需要使用 weak self 了。

~~~~objective-c
[UIView animateWithDuration:0.2 animations:^{
    self.alpha = 1;
}];
~~~~

当动画结束时，UIView 会结束持有这个 block，如果没有别的对象持有 block 的话，block 对象就会释放掉，从而 block 会释放掉对于 self 的持有。整个内存引用关系被解除。

strong self
	在 block 中先写一个 strong self，其实是为了避免在 block 的执行过程中，突然出现 self 被释放的尴尬情况。通常情况下，如果不这么做的话，还是很容易出现一些奇怪的逻辑，甚至闪退。

~~~~objective-c
	int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        shop *s = [[shop alloc]init];
        NSLog(@"%ld\n",CFGetRetainCount((__bridge CFTypeRef)(s)));
        __weak shop *weakS = s;
        s.shopBlock = ^{
            
            NSLog(@"block weakS -- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(weakS)));

            __strong shop *strongS = weakS;
            NSLog(@"block weakS -- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(weakS)));
            NSLog(@"block strongS -- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(strongS)));
        };
        NSLog(@"---- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(s)));
        NSLog(@"weakS ---- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(weakS)));
        s.shopBlock();
        NSLog(@"weakS over ---- %ld\n",CFGetRetainCount((__bridge CFTypeRef)(weakS)));
    }
    return 0;
}
~~~~

~~~~objective-c
blockRetainTest[3218:212987] Hello, World!
blockRetainTest[3218:212987] 1
blockRetainTest[3218:212987] weakS ---- 2
blockRetainTest[3218:212987] ---- 1
blockRetainTest[3218:212987] weakS ---- 2
blockRetainTest[3218:212987] block weakS -- 2
blockRetainTest[3218:212987] block weakS -- 3
blockRetainTest[3218:212987] block strongS -- 2
blockRetainTest[3218:212987] weakS over ---- 2

//shop类的引用计数一直为1,
~~~~

在block内如何修改block外部变量
block中访问的外部变量是复制过去的,即:写操作不对原变量生效,可以加上_block来让其写操作生效.
block不允许修改外部变量的值,这里所说的外部变量的值,值得是栈中指针的内存地址._block所起到的作用就是只要观察到该变量被block锁持有,就将”外部变量”在栈中的内存地址放到了堆中,进而在block内部也可以修改外部变量的值.
a 在定义前是栈区，但只要进入了 block 区域，就变成了堆区。这才是 *_block关键字的真正作用* .

~~~~objective-c

~~~~

#### 更新
看到一篇文章,retainCount方法不是准确的,链接放上来[bbum的weblog-o-mat](http://www.friday.com/bbum/2011/12/18/retaincount-is-useless/) 
需要翻墙
