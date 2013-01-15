IBWebToPNG

exactly as it, you load a web page, locally or remotly and want to share or save it.

this class do it,

Install it, import the IBWebToPNG.h & IBWebToPNG.m to your project,import the header file , IBWebToPNG.h

#import "IBWebToPNG.h"


call it like this

    [IBWebToPNG creatPNGSFromWebView:self.myWebView width:self.myWebView.bounds.size.width resultFileName:@"iphoneislam.png"];
the file will be saved in NSDocumentDirectory folder 


