---
layout: docs
title: Performance Tips 
description: How to build a high performance Custom Visual
group: concepts
toc: true
redirect_from:
  - /docs/latest/how-to-guide/performance-tips/
github_issue_id: 435
---

This article covers several techniques how developers can keep high rendering performance for their visuals.   No one wants a visual to take seconds to render single visual. This is why squeezing every drop of extra performance you can out of code can sometimes be critical. 

### Tips and Tricks 
Here are some suggestions how to keep high performance for your visual. 

### Tips and Tricks Use the latest API 
We constantly working on improving of loading speed of PowerBI service. Each new API update brings not only new features to your visual, but also provides  better performance for visuals infrastructure. 

### Use User Timing API
The User Timing API enables you to measure your app's JavaScript performance. The basic idea is that you decide which parts of your scripts you want to optimize, and then you instrument those parts of your scripts with the User Timing API. 

### Use User Timing API
Read the official documentation about User Timing API on [MSDN](https://msdn.microsoft.com/en-us/library/hh772738(v=vs.85).aspx).

### Does your animation loop redraw elements that haven’t changed? 
When the time comes to animate a static visualization, it’s tempting to lump all of the draw code into an update function and call it with new data on each iteration of the animation loop. It’s a waste of draw time if some of these elements don’t change frame-to-frame. Common examples of this would be axes and legends. 

### Solution: Update selectively 
Everything static can be drawn in visual constructor method, then the update function only needs to draw elements that change. The best way to update a visualization with new data is by using the update pattern. 

### Cache DOM Nodes 
Whenever you retrieve a node or a list of nodes from the DOM, try to think about whether you might be able to reuse them in a later computation (or even just the next loop iteration). As long as you don't actually add or delete nodes in the relevant area, this is often the case. To make sure that your code is fast and doesn’t slow down the browser to a halt try to keep DOM access to a bare minimum. 


##### Before: 

{% highlight js %}
public update(options: VisualUpdateOptions) { 
    let axis = $(".axis"); 
}
{% endhighlight %}


##### After: 

{% highlight js %}
public constructor(options: VisualConstructorOptions) { 
    this.$root = $(options.element); 
    this.xAxis = this.$root.find(".xAxis"); 
} 
 
public update(options: VisualUpdateOptions) { 
    let axis = this.axis; 
}
{% endhighlight %}

 

### Avoid DOM Manipulation 
DOM manipulation should be as limited as possible, since insert operations like prepend(), append(), after() are rather time-consuming. 
The above example could be quickened using html() and building the list beforehand: 

{% highlight js %}
let list = ''; 
for (let i=0; i<1000; i++) { 
    list += '<li>'+i+'</li>'; 
} 

$('#list').html(list); 
{% endhighlight %}
 

### You might not need Jquery 

If you're worried about performance, you should try to use native js whenever possible. Js frameworks not only add bandwidth overhead but also processing overhead. And jQuery comes with browser compatibility for pretty old browsers, too. 

Check [youmightnotneedjquery.com](http://youmightnotneedjquery.com/) website, it provides a lot of examples for common cases of using JQuery functions like show, hide, Add class, and etc.  


### Use canvas or WebGL 
If you have a lot of animations you might consider using a canvas or Webgl instead of SVG. Unlike SVG, canvas performance is determined by the canvas size rather than its contents. 

Read more about the difference between SVG and Canvas in [this article](https://msdn.microsoft.com/en-us/library/gg193983(v=vs.85).aspx). 

### Use requestAnimationFrame instead of setTimeout 
You should call this method  https://www.w3.org/TR/animation-timing/ whenever you're ready to update your animation onscreen. This will request that your animation function be called before the browser performs the next repaint.  
[Here is a sample](https://testdrive-archive.azurewebsites.net/Graphics/RequestAnimationFrame/Default.html) of smooth animation using requestAnimationFrame 



 

 

 