// hello.cc
#include <node.h>
#include "exec.h"

namespace start {

using v8::FunctionCallbackInfo;
using v8::Isolate;
using v8::Local;
using v8::Object;
using v8::String;
using v8::Value;

void Method(const FunctionCallbackInfo<Value>& args) {
  Isolate* isolate = args.GetIsolate();
  args.GetReturnValue().Set(String::NewFromUtf8(isolate, "Container Started."+exec()));
}

void init(Local<Object> exports) {
  NODE_SET_METHOD(exports, "start", Method);
}

NODE_MODULE(start, init)

}  // namespace demo
