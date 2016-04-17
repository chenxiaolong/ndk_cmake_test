#include <string>

#include <cstdio>
#include <cstdlib>

#include <atomic>

class AtomicPointer {
 private:
  std::atomic<void*> rep_;
 public:
  AtomicPointer() { }
  explicit AtomicPointer(void* v) : rep_(v) { }
  inline void* Acquire_Load() const {
    return rep_.load(std::memory_order_acquire);
  }
  inline void Release_Store(void* v) {
    rep_.store(v, std::memory_order_release);
  }
  inline void* NoBarrier_Load() const {
    return rep_.load(std::memory_order_relaxed);
  }
  inline void NoBarrier_Store(void* v) {
    rep_.store(v, std::memory_order_relaxed);
  }
};

int main(int argc, char *argv[])
{
    AtomicPointer allowed_;
    allowed_.Acquire_Load();
    std::string blah("Hello world!");
    std::printf("%s\n", blah.c_str());
    return EXIT_SUCCESS;
}
