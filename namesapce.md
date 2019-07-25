# 命名空间管理&元数据管理
## 1.介绍  
每个持久对象都由一个持久对象名唯一指定，但系统实际操作的是NVM上的地址，命名空间管理模块就是负责将一个持久对象名映射到一个持久对象的元数据，系统进而通过持久对象的元数据访问到持久对象的地址。  
## 2.需要的东西和提供的接口
### 2.1需要
1.需要上一层提供字节粒度的持久内存分配与释放函数,以操作非易失内存。  
2.需要提供给我一个可以返回我记录全局信息结构的地址的函数。  
### 2.2提供
1.提供给上一层三个关于持久对象名操作的函数，上层可以通过这三个函数快速的新添、删除对象名并通过对象名快速的定位到持久对象的元数据信息。  
预计提供给上层函数的形式：
```C
struct pos_ns_record *pos_ns_search(const char *str, int str_length);
//查找一个持久对象名是否已经存在的函数，如果存在返回这个对象的record,不存在则返回null。
struct pos_ns_record *pos_ns_insert(const char *str, int str_legnth);
//创建一个新的持久对象名,如果持久对象已经存在或者申请内存失败返回null，插入成功则返回新纪录record的地址。
struct pos_ns_record *pos_ns_delete(const char *str, int str_length);
//删除一个持久对象名，删除成功返回被被删除record的地址，删除失败返回null。
```
我的上一层可以拿到一个持久的对象的描述符pos_descripter,需要操作持久对象元数据时修改pos_descropter中的对应数据即可。

```c
struct pos_descriptor
{
	struct list_head d_vm_list;//记录持久对象vma链表，vma链表与操作下一层实现，可以借助linux内核里的list嵌入式结构实现。
	unsigned long long prime_seg;//记录持久对象的首地址。
	uid_t	d_uid;//用户id
	gid_t	d_gid;//组id
};
/*暂时想到这些元数据项，如果有需要会继续添加*/
```
### 2.3使用说明
1.创建一个持久对象时，先根据持久对象名申请一个record，再申请一个descripter，把record指向descripter，最后把相应元输入填入descripter。  
2.删除一个持久对象时，先释放占用的空间，再free掉descripter，最后delete掉record。
### 3.实现的数据结构
数据结构中不能定义指针，用到指针的地方全部使用物理地址来代替，物理地址使用unsigned long long来表示。之后实现过程中可能会有频繁的物理地址与指针转换，指针和物理地址的使用习惯很不一样（例如unsigned long long无法像指针一样指向下一个相邻位置),有点不太方便。而且命名最好易于辨认一些，因为所有地址都变成了unsigned long long，命名不好辨认的话即便找到定义也难以理解指向的是什么结构。
```c
struct pos_ns_record
{
	int str_length;
	char *str;
	struct pos_task_pid *task_list;	// This points volatile struct.貌似这个可以不用
	struct pos_descriptor *desc;
	struct pos_ns_record *next;
};


struct pos_ns_container
{
	struct pos_ns_record *head;	// list data structure
	int cnt_accesses;
	int cnt_direct_hits;
	int cnt_limit;
	int cnt_capital;
};


struct pos_ns_trie_node
{
	int depth;			//这个结构体中必须放在第一个，有其他用途（判断），创建po时检查长度是否超过128 
	pfn ptrs[POS_ARRAY_LENGTH];//pos_array_length暂定128字符，'/'应该是不支持的,预想不用改变其他字符在数组中的位置，若有需要可以直接在'/'字符位置作其他用途，创建po时检查是否含有'/'
};
/*单个trie_node大小：4+8*128=1028B*/
```
## 4.架构方式
我是一个图
## 5.实现的函数
```C
void pos_ns_burst(struct pos_ns_trie_node *prev_trie_node, int prev_index);
pos_get_superblock();
```
## 5.其他
trie_root信息  
pfn  
预想初始化的时候就建立一个根结点
