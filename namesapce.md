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
### 3.实现的数据结构
```c
struct pos_ns_record
{
	int str_length;
	char *str;
	struct pos_task_pid *task_list;	// This points volatile struct.
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
	int depth;			// depth field must be first one in this structure.
	unsigned long ptrs[POS_ARRAY_LENGTH];
};
```
## 4.架构方式
我是一个图
## 5.实现的函数
```C
void pos_ns_burst(struct pos_ns_trie_node *prev_trie_node, int prev_index);
```
## 5.其他
trie_root信息  
pfn  

