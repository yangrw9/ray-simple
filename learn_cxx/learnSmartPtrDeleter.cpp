
/// null_delete.
template<typename _Tp>
struct DoNothingDeleter
{
    constexpr DoNothingDeleter() noexcept = default;

    template<typename _Up, typename = typename std::enable_if<std::is_convertible<_Up*, _Tp*>::value>::type>
    DoNothingDeleter(const DoNothingDeleter<_Up>&) noexcept { }

    void
    operator()(_Tp* __ptr) const
    {
        static_assert(sizeof(_Tp)>0,
                      "can't delete pointer to incomplete type");
        //delete __ptr;
    }
};

 
