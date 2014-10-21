//
//  VGJavascriptCoreImports.h
//  Vega
//
//  Created by Idriss on 12/10/2014.
//  Copyright (c) 2014 ij. All rights reserved.
//

#ifndef Vega_VGJavascriptCoreImports_h
#define Vega_VGJavascriptCoreImports_h

NSString *b64CoreJS      = @"CmlmICh0aGlzLmV4cFRhYmxlID09PSB1bmRlZmluZWQpIHsKICAgIHRoaXMuZXhwVGFibGUgPSBbXQp9CgoKaWYgKHRoaXMuZnVuY1RhYmxlID09PSB1bmRlZmluZWQpIHsKICAgIHRoaXMuZnVuY1RhYmxlID0gW10KfQoKdmFyIEdpdmVuID0gZnVuY3Rpb24gKHJlZ2V4cCwgY2FsbGJhY2spIHsKICAgIHZhciBpbmRleCA9IHRoaXMuZXhwVGFibGUucHVzaChyZWdleHApIC0gMQogICAgdGhpcy5mdW5jVGFibGVbaW5kZXhdID0gY2FsbGJhY2sKfQoKdmFyIFdoZW4gPSBmdW5jdGlvbiAocmVnZXhwLCBjYWxsYmFjaykgewogICAgdmFyIGluZGV4ID0gdGhpcy5leHBUYWJsZS5wdXNoKHJlZ2V4cCkgLSAxCiAgICB0aGlzLmZ1bmNUYWJsZVtpbmRleF0gPSBjYWxsYmFjawp9Cgp2YXIgVGhlbiA9IGZ1bmN0aW9uIChyZWdleHAsIGNhbGxiYWNrKSB7CiAgICB2YXIgaW5kZXggPSB0aGlzLmV4cFRhYmxlLnB1c2gocmVnZXhwKSAtIDEKICAgIHRoaXMuZnVuY1RhYmxlW2luZGV4XSA9IGNhbGxiYWNrCn0KCnZhciBBbmQgPSBmdW5jdGlvbiAocmVnZXhwLCBjYWxsYmFjaykgewogICAgdmFyIGluZGV4ID0gdGhpcy5leHBUYWJsZS5wdXNoKHJlZ2V4cCkgLSAxCiAgICB0aGlzLmZ1bmNUYWJsZVtpbmRleF0gPSBjYWxsYmFjawp9CgoKCnZhciBwZXJmb3JtID0gZnVuY3Rpb24gKGludm9jYXRpb24pIHsKCiAgICB2YXIgZXhwciA9IGludm9jYXRpb24uZXhwcjsKICAgIHZhciBhcmdzID0gaW52b2NhdGlvbi5hcmdzOwoKICAgIHZhciBmb3VuZCA9IGZhbHNlCiAgICBmb3IgKHZhciBrZXkgaW4gdGhpcy5leHBUYWJsZSkgewogICAgICAgIGlmICh0aGlzLmV4cFRhYmxlW2tleV0udGVzdChleHByKSkgewoJICAgIHZhciBtYXRjaGVkSXRlbXMgPSB0aGlzLmV4cFRhYmxlW2tleV0uZXhlYyhleHByKQoKCSAgICB2YXIgY2FwdHVyZWRHcm91cHMgPSBbXTsKCSAgICBpZiAobWF0Y2hlZEl0ZW1zLmxlbmd0aCA+IDEpIHsKCQljYXB0dXJlZEdyb3VwcyA9IG1hdGNoZWRJdGVtcy5zbGljZSgxLCBtYXRjaGVkSXRlbXMubGVuZ3RoKQoJICAgIH0KCgkgICAgdmFyIHRhcmdldCA9IFVJQVRhcmdldC5sb2NhbFRhcmdldCgpCgkgICAgdmFyIHdpbmRvdyA9IHRhcmdldC5mcm9udE1vc3RBcHAoKS5tYWluV2luZG93KCkKCgkgICAgdmFyIHJlZ2V4cEFyZ3MgPSBbdGFyZ2V0LCB3aW5kb3ddCgkgICAgaWYgKGNhcHR1cmVkR3JvdXBzLmxlbmd0aCA+IDApIHsKCQlyZWdleHBBcmdzID0gcmVnZXhwQXJncy5jb25jYXQoY2FwdHVyZWRHcm91cHMpCgkgICAgfQoKCgkgICAgLy9hZGQgYW55IGFyZ3VtZW50cyBwYXNzZWQgdG8gdGhlIGZ1bmN0aW9uIChpLmUuIGRhdGEgdGFibGVzKQoJICAgIHZhciBhbGxBcmdzID0gcmVnZXhwQXJnczsKCSAgICBpZihhcmdzKSB7CgkJYWxsQXJncy5wdXNoKGFyZ3MpOwoJICAgIH0KCSAgICAKCSAgICB0cnkgewoJCXZhciBwYXNzZWQgPSB0aGlzLmZ1bmNUYWJsZVtrZXldLmFwcGx5KHRoaXMsIGFsbEFyZ3MpCgkJZm91bmQgPSB0cnVlOyAJCQoJICAgIH0gY2F0Y2ggKGVycm9yKSB7CgkJcmV0dXJuIHtzdGF0dXM6ICJGQUlMRUQiLAoJCSAgICAgICAgbWVzc2FnZTogZXJyb3J9CgkgICAgfQogICAgICAgICAgICAKCSAgICByZXR1cm4ge3N0YXR1czogIlBBU1NFRCIsCgkJICAgIG1lc3NhZ2U6IGV4cHJ9CiAgICAgICAgfQogICAgfQoKICAgIGlmICghZm91bmQpIHsKICAgICAgICByZXR1cm4ge3N0YXR1czogIk5PVF9GT1VORCIsCgkgICAgICAgIG1lc3NhZ2U6ICJDYW4ndCBmaW5kIHN0ZXAgbWF0Y2hpbmc6ICIgKyBleHByfQogICAgfQp9CgoKdmFyIGh0dHBSZXF1ZXN0ID0gZnVuY3Rpb24gKG1ldGhvZCwgdXJsLCB0aW1lb3V0KSB7CiAgCiAgdmFyIHRhcmdldCA9IFVJQVRhcmdldC5sb2NhbFRhcmdldCgpOwogIHZhciBob3N0ID0gdGFyZ2V0Lmhvc3QoKTsKICB2YXIgYXJncyA9IFtdOwogIAogIGFyZ3MucHVzaCgiLVgiKQogIGlmIChtZXRob2QgIT09IHVuZGVmaW5lZCkgewogICAgYXJncy5wdXNoKG1ldGhvZCkKICB9IGVsc2UgewogICAgYXJncy5wdXNoKCJHRVQiKQogIH0KICAKICBhcmdzLnB1c2godXJsKQogIAogIHJldHVybiBob3N0LnBlcmZvcm1UYXNrV2l0aFBhdGhBcmd1bWVudHNUaW1lb3V0KCIvdXNyL2Jpbi9jdXJsIiwgYXJncywgdGltZW91dCk7CiAgCn0KCnZhciBBU1NFUlQgPSBmdW5jdGlvbiAocmVzdWx0LCBtZXNzYWdlKSB7CiAgICBpZiAoIXJlc3VsdCkgewoJdGhyb3cobWVzc2FnZSkKICAgIH0KfQoKdmFyIEFTU0VSVF9FUVVBTCA9IGZ1bmN0aW9uIChleHAxLCBleHAyLCBtZXNzYWdlKSB7CiAgICBpZiAoZXhwMSAhPT0gZXhwMikgewoJdGhyb3cobWVzc2FnZSArICIgKCIgKyBleHAxICsgIiAhPSAiICsgZXhwMiArICIpIikKICAgIH0KfQoKdmFyIEFTU0VSVF9FWElTVFMgPSBmdW5jdGlvbiAoZWxlbWVudCwgdGltZW91dCwgbWVzc2FnZSkgewogICAgCiAgICAKfQoKdmFyIExPRyA9IGZ1bmN0aW9uIChtZXNzYWdlKSB7CiAgVUlBTG9nZ2VyLmxvZ01lc3NhZ2UoIkRlYnVnPiAiICsgbWVzc2FnZSk7Cn0=";
NSString *b64InternalsJS = @"Ly8KLy8gIGludGVybmFscy5qcwovLyAgVmVnYQovLwovLyAgQ3JlYXRlZCBieSBJZHJpc3Mgb24gMTIvMTAvMjAxNC4KLy8gIENvcHlyaWdodCAoYykgMjAxNCBpai4gQWxsIHJpZ2h0cyByZXNlcnZlZC4KLy8KLy8gIFY6MC4xLjEKCnZhciBCYXNlNjQgPSB7CiAgCiAgLy8gcHJpdmF0ZSBwcm9wZXJ0eQogIF9rZXlTdHIgOiAiQUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5ejAxMjM0NTY3ODkrLz0iLAogIAogIC8vIHB1YmxpYyBtZXRob2QgZm9yIGVuY29kaW5nCiAgZW5jb2RlIDogZnVuY3Rpb24gKGlucHV0KSB7CiAgICB2YXIgb3V0cHV0ID0gIiI7CiAgICB2YXIgY2hyMSwgY2hyMiwgY2hyMywgZW5jMSwgZW5jMiwgZW5jMywgZW5jNDsKICAgIHZhciBpID0gMDsKICAgIAogICAgaW5wdXQgPSBCYXNlNjQuX3V0ZjhfZW5jb2RlKGlucHV0KTsKICAgIAogICAgd2hpbGUgKGkgPCBpbnB1dC5sZW5ndGgpIHsKICAgICAgCiAgICAgIGNocjEgPSBpbnB1dC5jaGFyQ29kZUF0KGkrKyk7CiAgICAgIGNocjIgPSBpbnB1dC5jaGFyQ29kZUF0KGkrKyk7CiAgICAgIGNocjMgPSBpbnB1dC5jaGFyQ29kZUF0KGkrKyk7CiAgICAgIAogICAgICBlbmMxID0gY2hyMSA+PiAyOwogICAgICBlbmMyID0gKChjaHIxICYgMykgPDwgNCkgfCAoY2hyMiA+PiA0KTsKICAgICAgZW5jMyA9ICgoY2hyMiAmIDE1KSA8PCAyKSB8IChjaHIzID4+IDYpOwogICAgICBlbmM0ID0gY2hyMyAmIDYzOwogICAgICAKICAgICAgaWYgKGlzTmFOKGNocjIpKSB7CiAgICAgICAgZW5jMyA9IGVuYzQgPSA2NDsKICAgICAgfSBlbHNlIGlmIChpc05hTihjaHIzKSkgewogICAgICAgIGVuYzQgPSA2NDsKICAgICAgfQogICAgICAKICAgICAgb3V0cHV0ID0gb3V0cHV0ICsKICAgICAgdGhpcy5fa2V5U3RyLmNoYXJBdChlbmMxKSArIHRoaXMuX2tleVN0ci5jaGFyQXQoZW5jMikgKwogICAgICB0aGlzLl9rZXlTdHIuY2hhckF0KGVuYzMpICsgdGhpcy5fa2V5U3RyLmNoYXJBdChlbmM0KTsKICAgICAgCiAgICB9CiAgICAKICAgIHJldHVybiBvdXRwdXQ7CiAgfSwKICAKICAvLyBwdWJsaWMgbWV0aG9kIGZvciBkZWNvZGluZwogIGRlY29kZSA6IGZ1bmN0aW9uIChpbnB1dCkgewogICAgdmFyIG91dHB1dCA9ICIiOwogICAgdmFyIGNocjEsIGNocjIsIGNocjM7CiAgICB2YXIgZW5jMSwgZW5jMiwgZW5jMywgZW5jNDsKICAgIHZhciBpID0gMDsKICAgIAogICAgaW5wdXQgPSBpbnB1dC5yZXBsYWNlKC9bXkEtWmEtejAtOVwrXC9cPV0vZywgIiIpOwogICAgCiAgICB3aGlsZSAoaSA8IGlucHV0Lmxlbmd0aCkgewogICAgICAKICAgICAgZW5jMSA9IHRoaXMuX2tleVN0ci5pbmRleE9mKGlucHV0LmNoYXJBdChpKyspKTsKICAgICAgZW5jMiA9IHRoaXMuX2tleVN0ci5pbmRleE9mKGlucHV0LmNoYXJBdChpKyspKTsKICAgICAgZW5jMyA9IHRoaXMuX2tleVN0ci5pbmRleE9mKGlucHV0LmNoYXJBdChpKyspKTsKICAgICAgZW5jNCA9IHRoaXMuX2tleVN0ci5pbmRleE9mKGlucHV0LmNoYXJBdChpKyspKTsKICAgICAgCiAgICAgIGNocjEgPSAoZW5jMSA8PCAyKSB8IChlbmMyID4+IDQpOwogICAgICBjaHIyID0gKChlbmMyICYgMTUpIDw8IDQpIHwgKGVuYzMgPj4gMik7CiAgICAgIGNocjMgPSAoKGVuYzMgJiAzKSA8PCA2KSB8IGVuYzQ7CiAgICAgIAogICAgICBvdXRwdXQgPSBvdXRwdXQgKyBTdHJpbmcuZnJvbUNoYXJDb2RlKGNocjEpOwogICAgICAKICAgICAgaWYgKGVuYzMgIT0gNjQpIHsKICAgICAgICBvdXRwdXQgPSBvdXRwdXQgKyBTdHJpbmcuZnJvbUNoYXJDb2RlKGNocjIpOwogICAgICB9CiAgICAgIGlmIChlbmM0ICE9IDY0KSB7CiAgICAgICAgb3V0cHV0ID0gb3V0cHV0ICsgU3RyaW5nLmZyb21DaGFyQ29kZShjaHIzKTsKICAgICAgfQogICAgICAKICAgIH0KICAgIAogICAgb3V0cHV0ID0gQmFzZTY0Ll91dGY4X2RlY29kZShvdXRwdXQpOwogICAgCiAgICByZXR1cm4gb3V0cHV0OwogICAgCiAgfSwKICAKICAvLyBwcml2YXRlIG1ldGhvZCBmb3IgVVRGLTggZW5jb2RpbmcKICBfdXRmOF9lbmNvZGUgOiBmdW5jdGlvbiAoc3RyaW5nKSB7CiAgICAKICAgIHN0cmluZyA9IHN0cmluZy5yZXBsYWNlKC9cclxuL2csIlxuIik7CiAgICB2YXIgdXRmdGV4dCA9ICIiOwogICAgCiAgICBmb3IgKHZhciBuID0gMDsgbiA8IHN0cmluZy5sZW5ndGg7IG4rKykgewogICAgICAKICAgICAgdmFyIGMgPSBzdHJpbmcuY2hhckNvZGVBdChuKTsKICAgICAgCiAgICAgIGlmIChjIDwgMTI4KSB7CiAgICAgICAgdXRmdGV4dCArPSBTdHJpbmcuZnJvbUNoYXJDb2RlKGMpOwogICAgICB9CiAgICAgIGVsc2UgaWYoKGMgPiAxMjcpICYmIChjIDwgMjA0OCkpIHsKICAgICAgICB1dGZ0ZXh0ICs9IFN0cmluZy5mcm9tQ2hhckNvZGUoKGMgPj4gNikgfCAxOTIpOwogICAgICAgIHV0ZnRleHQgKz0gU3RyaW5nLmZyb21DaGFyQ29kZSgoYyAmIDYzKSB8IDEyOCk7CiAgICAgIH0KICAgICAgZWxzZSB7CiAgICAgICAgdXRmdGV4dCArPSBTdHJpbmcuZnJvbUNoYXJDb2RlKChjID4+IDEyKSB8IDIyNCk7CiAgICAgICAgdXRmdGV4dCArPSBTdHJpbmcuZnJvbUNoYXJDb2RlKCgoYyA+PiA2KSAmIDYzKSB8IDEyOCk7CiAgICAgICAgdXRmdGV4dCArPSBTdHJpbmcuZnJvbUNoYXJDb2RlKChjICYgNjMpIHwgMTI4KTsKICAgICAgfQogICAgICAKICAgIH0KICAgIAogICAgcmV0dXJuIHV0ZnRleHQ7CiAgfSwKICAKICAvLyBwcml2YXRlIG1ldGhvZCBmb3IgVVRGLTggZGVjb2RpbmcKICBfdXRmOF9kZWNvZGUgOiBmdW5jdGlvbiAodXRmdGV4dCkgewogICAgdmFyIHN0cmluZyA9ICIiOwogICAgdmFyIGkgPSAwOwogICAgdmFyIGMgPSBjMSA9IGMyID0gMDsKICAgIAogICAgd2hpbGUgKCBpIDwgdXRmdGV4dC5sZW5ndGggKSB7CiAgICAgIAogICAgICBjID0gdXRmdGV4dC5jaGFyQ29kZUF0KGkpOwogICAgICAKICAgICAgaWYgKGMgPCAxMjgpIHsKICAgICAgICBzdHJpbmcgKz0gU3RyaW5nLmZyb21DaGFyQ29kZShjKTsKICAgICAgICBpKys7CiAgICAgIH0KICAgICAgZWxzZSBpZigoYyA+IDE5MSkgJiYgKGMgPCAyMjQpKSB7CiAgICAgICAgYzIgPSB1dGZ0ZXh0LmNoYXJDb2RlQXQoaSsxKTsKICAgICAgICBzdHJpbmcgKz0gU3RyaW5nLmZyb21DaGFyQ29kZSgoKGMgJiAzMSkgPDwgNikgfCAoYzIgJiA2MykpOwogICAgICAgIGkgKz0gMjsKICAgICAgfQogICAgICBlbHNlIHsKICAgICAgICBjMiA9IHV0ZnRleHQuY2hhckNvZGVBdChpKzEpOwogICAgICAgIGMzID0gdXRmdGV4dC5jaGFyQ29kZUF0KGkrMik7CiAgICAgICAgc3RyaW5nICs9IFN0cmluZy5mcm9tQ2hhckNvZGUoKChjICYgMTUpIDw8IDEyKSB8ICgoYzIgJiA2MykgPDwgNikgfCAoYzMgJiA2MykpOwogICAgICAgIGkgKz0gMzsKICAgICAgfQogICAgICAKICAgIH0KICAgIAogICAgcmV0dXJuIHN0cmluZzsKICB9CiAgCn0KCnZhciBWR0xvZ2dlciA9IHsKICAKbG9nU3RhcnRGZWF0dXJlOiBmdW5jdGlvbihmZWF0dXJlbmFtZSkgewogIFVJQUxvZ2dlci5sb2dNZXNzYWdlKCJGZWF0dXJlOiAiICsgZmVhdHVyZW5hbWUpOwp9LAogIApsb2dTdGFydFNjZW5hcmlvOiBmdW5jdGlvbihzY2VuYXJpb05hbWUpIHsKICBVSUFMb2dnZXIubG9nU3RhcnQoc2NlbmFyaW9OYW1lKTsKfSwKICAKbG9nUGFzczogZnVuY3Rpb24oc2NlbmFyaW9OYW1lLCBtZXNzYWdlKSB7CiAgVUlBTG9nZ2VyLmxvZ1Bhc3MobWVzc2FnZSk7Cn0sCiAgCmxvZ0ZhaWw6IGZ1bmN0aW9uKHNjZW5hcmlvTmFtZSwgbWVzc2FnZSkgewogIFVJQUxvZ2dlci5sb2dGYWlsKG1lc3NhZ2UpOwp9LAogIApsb2dJc3N1ZTogZnVuY3Rpb24oc2NlbmFyaW9OYW1lLCBtZXNzYWdlKSB7CiAgVUlBTG9nZ2VyLmxvZ0lzc3VlKG1lc3NhZ2UpOwp9LAogIApsb2dNZXNzYWdlOiBmdW5jdGlvbihtZXNzYWdlKSB7CiAgVUlBTG9nZ2VyLmxvZ01lc3NhZ2UobWVzc2FnZSk7Cn0sCiAgCmxvZ0RlYnVnOiBmdW5jdGlvbihtZXNzYWdlKSB7CiAgVUlBTG9nZ2VyLmxvZ01lc3NhZ2UoIlZHREVCVUc6ICIgKyBtZXNzYWdlKTsKfQogIAp9Cgp2YXIgVkdSZXBvcnQgPSB7CmN1cnJlbnRGZWF0dXJlOnVuZGVmaW5lZCwKY3VycmVudFNjZW5hcmlvOnVuZGVmaW5lZCwKcmVwb3J0RGF0YTp7CmZlYXR1cmVzOltdCn0sCnN0YXJ0VGltZTowLAp0ZXN0czowLApwYXNzZWQ6MCwKZmFpbGVkOjAsCmlzc3VlczowLApvdmVycmFsOiB7CnRlc3RzOjAsCnBhc3NlZDowLApmYWlsZWQ6MCwKaXNzdWVzOjAsCn0sCiAgCnJlcG9ydFN0YXJ0RmVhdHVyZTogZnVuY3Rpb24gKGZlYXR1cmVuYW1lKSB7CiAgVkdSZXBvcnQuY3VycmVudEZlYXR1cmUgPSB7CiAgdGl0bGU6ZmVhdHVyZW5hbWUsCiAgc2NlbmFyaW9zOltdCiAgfTsKICBzdGFydFRpbWUgPSB0aW1lc3RhbXAoKQp9LAogIApyZXBvcnRFbmRGZWF0dXJlOiBmdW5jdGlvbiAoZmVhdHVyZW5hbWUpIHsKICAKICBWR1JlcG9ydC5vdmVycmFsLnRlc3RzICArPSBWR1JlcG9ydC50ZXN0cwogIFZHUmVwb3J0Lm92ZXJyYWwucGFzc2VkICs9IFZHUmVwb3J0LnBhc3NlZAogIFZHUmVwb3J0Lm92ZXJyYWwuaXNzdWVzICs9IFZHUmVwb3J0Lmlzc3VlcwogIFZHUmVwb3J0Lm92ZXJyYWwuZmFpbGVkICs9IFZHUmVwb3J0LmZhaWxlZAogIAogIFZHUmVwb3J0LmN1cnJlbnRGZWF0dXJlLl9fc3VtbWFyeV9fID0geyJ0b3RhbCI6VkdSZXBvcnQudGVzdHMsCiAgICAicGFzc2VkIjogVkdSZXBvcnQucGFzc2VkLAogICAgImZhaWxlZCI6IFZHUmVwb3J0LmZhaWxlZCwKICAgICJpc3N1ZXMiOiBWR1JlcG9ydC5pc3N1ZXMsCiAgICAidGltZSIgIDogc3RhcnRUaW1lfQogIAogIFZHUmVwb3J0LnJlcG9ydERhdGEuZmVhdHVyZXMucHVzaChWR1JlcG9ydC5jdXJyZW50RmVhdHVyZSk7CiAgCiAgVkdSZXBvcnQudGVzdHMgID0gMAogIFZHUmVwb3J0LnBhc3NlZCA9IDAKICBWR1JlcG9ydC5pc3N1ZXMgPSAwCiAgVkdSZXBvcnQuZmFpbGVkID0gMAogIAogIFZHUmVwb3J0LnJlcG9ydERhdGEuX19zdW1tYXJ5X18gPSB7InRvdGFsIjpWR1JlcG9ydC5vdmVycmFsLnRlc3RzLAogICAgInBhc3NlZCI6IFZHUmVwb3J0Lm92ZXJyYWwucGFzc2VkLAogICAgImZhaWxlZCI6IFZHUmVwb3J0Lm92ZXJyYWwuZmFpbGVkLAogICAgImlzc3VlcyI6IFZHUmVwb3J0Lm92ZXJyYWwuaXNzdWVzLAogICAgInRpbWUiICA6IHN0YXJ0VGltZX0KICBWR1JlcG9ydC5jdXJyZW50RmVhdHVyZSA9IHVuZGVmaW5lZAogIAp9LAogIAogIApyZXBvcnRTdGFydFNjZW5hcmlvOiBmdW5jdGlvbiAoc2NlbmFyaW9OYW1lKSB7CiAgVkdSZXBvcnQudGVzdHMgKz0gMTsKfSwKICAKcmVwb3J0RW5kU2NlbmFyaW86IGZ1bmN0aW9uIChzY2VuYXJpb05hbWUpIHsKICBWR1JlcG9ydC5jdXJyZW50RmVhdHVyZS5zY2VuYXJpb3MucHVzaChWR1JlcG9ydC5jdXJyZW50U2NlbmFyaW8pOwogIFZHUmVwb3J0LmN1cnJlbnRTY2VuYXJpbyA9IHVuZGVmaW5lZDsKfSwKICAKcmVwb3J0UGFzczogZnVuY3Rpb24gKHNjZW5hcmlvTmFtZSwgbWVzc2FnZSkgewogIFZHUmVwb3J0LmN1cnJlbnRTY2VuYXJpbyA9IHsidGl0bGUiOnNjZW5hcmlvTmFtZSwgInJlc3VsdCI6ICJQQVNTIiwgInJlYXNvbiI6IG1lc3NhZ2UsICJ0aW1lIjogdGltZXN0YW1wKCl9OwogIFZHUmVwb3J0LnBhc3NlZCArPSAxOwp9LAogIApyZXBvcnRGYWlsOiBmdW5jdGlvbiAoc2NlbmFyaW9OYW1lLCBtZXNzYWdlKSB7CiAgdmFyIHNjcmVlbnNob3ROYW1lID0gc2NlbmFyaW9OYW1lOwogIHZhciB0YXJnZXQgID0gVUlBVGFyZ2V0LmxvY2FsVGFyZ2V0KCk7CiAgdGFyZ2V0LmNhcHR1cmVTY3JlZW5XaXRoTmFtZShzY3JlZW5zaG90TmFtZSk7CiAgVkdSZXBvcnQuY3VycmVudFNjZW5hcmlvID0geyJ0aXRsZSI6c2NlbmFyaW9OYW1lLCAicmVzdWx0IjogIkZBSUwiLCAicmVhc29uIjogbWVzc2FnZSwgInNjcmVlbnNob3QiOnNjcmVlbnNob3ROYW1lICsgIi5wbmciLCAidGltZSI6IHRpbWVzdGFtcCgpfTsKICBWR1JlcG9ydC5mYWlsZWQgKz0gMTsKfSwKICAKcmVwb3J0SXNzdWU6IGZ1bmN0aW9uIChzY2VuYXJpb05hbWUsIG1lc3NhZ2UpIHsKICBWR1JlcG9ydC5jdXJyZW50U2NlbmFyaW8gPSB7InRpdGxlIjpzY2VuYXJpb05hbWUsICJyZXN1bHQiOiAiSVNTVUUiLCAicmVhc29uIjogbWVzc2FnZSwgInRpbWUiOiB0aW1lc3RhbXAoKX07CiAgVkdSZXBvcnQuaXNzdWVzICs9IDE7Cn0sCiAgCnJlcG9ydDpmdW5jdGlvbiAobG9jYXRpb24sIHJlcG9ydG5hbWUpewogIFZHTG9nZ2VyLmxvZ01lc3NhZ2UoIlRlc3RzIHJ1bjogIiArIFZHUmVwb3J0Lm92ZXJyYWwudGVzdHMgKyAiLCAiICsgVkdSZXBvcnQub3ZlcnJhbC5wYXNzZWQgKyAiIHBhc3NlZCwgIiArIFZHUmVwb3J0Lm92ZXJyYWwuZmFpbGVkICsgIiBmYWlsZWQsICIgKyBWR1JlcG9ydC5vdmVycmFsLmlzc3VlcyArICIgaXNzdWVzIik7CiAgdmFyIHRhcmdldCA9IFVJQVRhcmdldC5sb2NhbFRhcmdldCgpOwogIAogIHZhciBob3N0ID0gdGFyZ2V0Lmhvc3QoKTsKICAKICB2YXIgZGF0YSA9IEpTT04uc3RyaW5naWZ5KFZHUmVwb3J0LnJlcG9ydERhdGEpOwogIHZhciBiNjREYXRhID0gQmFzZTY0LmVuY29kZShkYXRhKTsKICAKICB2YXIgcmVwb3J0ZXIgPSBsb2NhdGlvbiArICIvY29yZS9zYXZlUmVwb3J0IgogIHZhciByZXBvcnRmaWxlID0gbG9jYXRpb24gKyAiLyIgKyByZXBvcnRuYW1lCiAgdmFyIHJlc3VsdCA9IGhvc3QucGVyZm9ybVRhc2tXaXRoUGF0aEFyZ3VtZW50c1RpbWVvdXQoIi9iaW4vYmFzaCIsIFtyZXBvcnRlciwgcmVwb3J0ZmlsZSwgYjY0RGF0YV0sIDUpOwogIAp9CiAgCn0KCgoKCgp2YXIgcGVyZm9ybVNjZW5hcmlvID0gZnVuY3Rpb24gKHNjZW5hcmlvTmFtZSwgc3RlcHMpIHsKICAKICBWR1JlcG9ydC5yZXBvcnRTdGFydFNjZW5hcmlvKHNjZW5hcmlvTmFtZSk7CiAgVkdMb2dnZXIubG9nU3RhcnRTY2VuYXJpbyhzY2VuYXJpb05hbWUpCiAgCiAgZm9yICh2YXIgc3RlcEtleSBpbiBzdGVwcykgewogICAgCiAgICB2YXIgc3RlcCA9IHN0ZXBzW3N0ZXBLZXldCiAgICBWR0xvZ2dlci5sb2dNZXNzYWdlKCJTdGVwOiAiICsgc3RlcC5leHByKQogICAgdmFyIHJlc3VsdCA9IHBlcmZvcm0oc3RlcCkKICAgIGlmIChyZXN1bHQuc3RhdHVzID09PSAiTk9UX0ZPVU5EIikgewogICAgICBWR0xvZ2dlci5sb2dJc3N1ZShzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKQogICAgICBWR1JlcG9ydC5yZXBvcnRJc3N1ZShzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKTsKICAgICAgVkdSZXBvcnQucmVwb3J0RW5kU2NlbmFyaW8oc2NlbmFyaW9OYW1lKTsKICAgICAgcmV0dXJuCiAgICB9IGVsc2UgaWYgKHJlc3VsdC5zdGF0dXMgPT09ICJGQUlMRUQiKSB7CiAgICAgIFZHTG9nZ2VyLmxvZ0ZhaWwoc2NlbmFyaW9OYW1lLCByZXN1bHQubWVzc2FnZSkKICAgICAgVkdSZXBvcnQucmVwb3J0RmFpbChzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKTsKICAgICAgVkdSZXBvcnQucmVwb3J0RW5kU2NlbmFyaW8oc2NlbmFyaW9OYW1lKTsKICAgICAgcmV0dXJuCiAgICB9CiAgICAKICB9CiAgCiAgVkdMb2dnZXIubG9nUGFzcyhzY2VuYXJpb05hbWUsIHNjZW5hcmlvTmFtZSkKICBWR1JlcG9ydC5yZXBvcnRQYXNzKHNjZW5hcmlvTmFtZSk7CiAgVkdSZXBvcnQucmVwb3J0RW5kU2NlbmFyaW8oc2NlbmFyaW9OYW1lKTsKfQoKdmFyIHBlcmZvcm1CYWNrZ3JvdW5kID0gZnVuY3Rpb24oc3RlcHMpIHsKICAKICB2YXIgYmFja2dyb3VuZE5hbWUgPSAiQmFja2dyb3VuZCIKICBWR1JlcG9ydC5yZXBvcnRTdGFydFNjZW5hcmlvKGJhY2tncm91bmROYW1lKTsKICBWR0xvZ2dlci5sb2dTdGFydFNjZW5hcmlvKGJhY2tncm91bmROYW1lKQogIAogIGZvciAodmFyIHN0ZXBLZXkgaW4gc3RlcHMpIHsKICAgIAogICAgdmFyIHN0ZXAgPSBzdGVwc1tzdGVwS2V5XQogICAgVkdMb2dnZXIubG9nTWVzc2FnZSgiQmFja2dyb3VuZCBTdGVwOiAiICsgc3RlcC5leHByKQogICAgdmFyIHJlc3VsdCA9IHBlcmZvcm0oc3RlcCkKICAgIGlmIChyZXN1bHQuc3RhdHVzID09PSAiTk9UX0ZPVU5EIikgewogICAgICBWR0xvZ2dlci5sb2dJc3N1ZShzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKQogICAgICBWR1JlcG9ydC5yZXBvcnRJc3N1ZShzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKTsKICAgICAgVkdSZXBvcnQucmVwb3J0RW5kU2NlbmFyaW8oYmFja2dyb3VuZE5hbWUpOwogICAgICByZXR1cm4KICAgIH0gZWxzZSBpZiAocmVzdWx0LnN0YXR1cyA9PT0gIkZBSUxFRCIpIHsKICAgICAgVkdMb2dnZXIubG9nRmFpbChzY2VuYXJpb05hbWUsIHJlc3VsdC5tZXNzYWdlKQogICAgICBWR1JlcG9ydC5yZXBvcnRGYWlsKHNjZW5hcmlvTmFtZSwgcmVzdWx0Lm1lc3NhZ2UpOwogICAgICBWR1JlcG9ydC5yZXBvcnRFbmRTY2VuYXJpbyhiYWNrZ3JvdW5kTmFtZSk7CiAgICAgIHJldHVybgogICAgfQogICAgCiAgfQogIAogIFZHTG9nZ2VyLmxvZ1Bhc3MoYmFja2dyb3VuZE5hbWUsIGJhY2tncm91bmROYW1lKQogIFZHUmVwb3J0LnJlcG9ydFBhc3MoYmFja2dyb3VuZE5hbWUpOwogIFZHUmVwb3J0LnJlcG9ydEVuZFNjZW5hcmlvKGJhY2tncm91bmROYW1lKTsKfQoKZnVuY3Rpb24gdGltZXN0YW1wICgpIHsKICByZXR1cm4gTWF0aC5yb3VuZChuZXcgRGF0ZSgpLmdldFRpbWUoKSAvIDEwMDApCn0K";

NSString *b64FeatureFile = @"QHRhZzEKRmVhdHVyZTogQWRkIGFuIEl0ZW0KICBBcyBhIFVzZXIgCiAgSSBzaG91bGQgYmUgYWJsZSB0byB3cml0ZSBnaGVya2luIHN0eWxlIGZlYXR1cmVzCiAgU28gdGhhdCBpIGNhbiB0ZXN0IG15IGFwcAoKICBCYWNrZ3JvdW5kOiBzZXR1cAogICAgR2l2ZW4gSSBhbSBvbiB0aGUgbWFpbiBwYWdlCgogIFNjZW5hcmlvOiBvcGVuIHRoZSBhZGQgaXRlbSBwYWdlCiAgICBHaXZlbiBJIGFtIG9uIHRoZSBtYWluIHBhZ2UKICAgIFdoZW4gSSB0YXAgdGhlICJBZGQgSXRlbSIgYnV0dG9uCiAgICBUaGVuIEkgc2hvdWxkIHNlZSB0aGUgIkFkZCBJdGVtIiBwYWdlCg==";
NSString *b64StepFile    = @"I2ltcG9ydCAiLi4vY29yZS9jb3JlLmpzIgoKR2l2ZW4oL15JIGFtIG9uIHRoZSBtYWluIHBhZ2UkLywgZnVuY3Rpb24odGFyZ2V0LCB3aW5kb3cpewogICAgICAKICAgICAgQVNTRVJUKGlzTWFpblBhZ2Uod2luZG93KSwgIml0J3Mgbm90IHRoZSBtYWluIHdpbmRvdyIpOwogICAgICAKfSkKCldoZW4oL15JIHRhcCB0aGUgIkFkZCBJdGVtIiBidXQkLywgZnVuY3Rpb24odGFyZ2V0LCB3aW5kb3cpewogICAgIAogICAgIHZhciBuYXZCYXIgPSB3aW5kb3cubmF2aWdhdGlvbkJhcigpCiAgICAgdmFyIGFkZEJ1dHRvbiA9IG5hdkJhci5idXR0b25zKClbIkFkZCJdOwogICAgIGFkZEJ1dHRvbi50YXAoKTsKICAgICAKfSkKClRoZW4oL15JIHNob3VsZCBzZWUgdGhlICJBZGQgSXRlbSIgcGFnZSQvLCBmdW5jdGlvbih0YXJnZXQsIHdpbmRvdyl7CiAgICAgCiAgICAgQVNTRVJUKGZhbHNlLCAiSSBmYWlsIGJlY2F1c2UgaSBjYXJlIik7CiAgICAgCn0pOwo=";

#endif
