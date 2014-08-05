#iLibrarians
##搜索图书模块说明文档

###  一.模块设计


####1. 类<br/>
-  ```SLSearchBookView```<br/>
搜索图书页面的视图  
-  ```SLSearchResultViewController```<br/>
图书搜索结果列表页
-  ```SLBookItemCell```<br/>
图书搜索结果列表页单个图书cell
-  ```SLBookDetailViewController```<br/>
图书详情页面


####2. 页面逻辑

首先，用户在 ```SLMainViewController```中通过滑动屏幕，进入```SLSearchBookView```，用户在搜索框中输入关键词并确认之后，通过以下代码

	[self.vc.navigationController pushViewController:resultViewController animated:YES];
	
进入```SLSearchResultViewController```，在这个```SLSearchResultViewController```中，搜索结果通过```resultTableView```来实现搜索结果列表的显示<br/>同时，用户再在该视图中点击相关图书的cell，程序会通过
	
	[self.navigationController pushViewController:detailViewController animated:YES];
进入对应图书的详情页面



-------------------

###  二.接口类型
-  ```GET  /search_result_entry```<br/>搜索关键词返回对应的```set_number```
-  ```GET  /search_result ```<br/>参数：关键字对应的```set_number```,搜索结果的页数```set_entry```，返回对应的图书结果数组
-  ```GET /status```<br/>参数：图书的```doc_number```，返回图书的在馆状态

--------------------


###  三.数据结构

-  服务器返回的图书信息采用```json```格式传输<br/>```/search_result```返回的json如下:

		{
			"books" = {
				book0 = {
					"author" = xxx;
					"cover"  = xxx;
					"doc_number" = xxx;
					"index"  = xxx;
					"intro"  = xxx;
					"isbn"   = xxx;
					"press"  = xxx;
					"title"  = xxx;
				};
				
				book1 = {...};
				book2 = {...};
				...
			};
			"message" = OK;
		}
		
-------------