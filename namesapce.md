# 命名空间管理模块
## 1.介绍  
每个持久对象都由一个持久对象名唯一指定，但系统实际操作的是NVM上的地址，命名空间管理模块就是负责将一个持久对象名映射到一个持久对象的元数据，系统进而通过持久对象的元数据访问到持久对象的地址。  
## 2.提供的接口
```C
struct pos_ns_record *pos_ns_search(struct pos_ns_trie_node *root, 
			const char *str, int str_length);
struct pos_ns_record *pos_ns_insert(struct pos_ns_trie_node *root,
			const char *str, int str_legnth);
struct pos_ns_record *pos_ns_delete(struct pos_ns_trie_node *root,
			const char *str, int str_length);
```
我的上一层可以拿到一个持久的对象的描述符pos_descripter,需要操作持久对象元数据时修改pos_descropter中的对应数据即可。

```c
struct pos_descriptor
{
	struct list_head d_vm_list;
	unsigned long prime_seg;
	uid_t	d_uid;
	gid_t	d_gid;
	fmode_t d_mode;
};
```
### 3.实现的数据结构
```c
#define pfn unsigned long long 
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

