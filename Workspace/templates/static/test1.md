# markdown

## test

pid: 190111;
tag: iOS;

---

pid: 190115;

---

# iOS-认识锁

> 认识开发中常见的锁及作用

首先一些概念定义:  
临界区:指的是一块对公共资源进行访问的代码.  

互斥锁:是一种用于多线程编程中,防止两条线程同时对同一公共资源进行读写的机制.该目的通过将代码切片成一个一个的临界区而达成. <!--more-->  
自旋锁:是用于多线程同步的一种锁,线程反复检查锁变量是否可用.  
条件锁:就是条
