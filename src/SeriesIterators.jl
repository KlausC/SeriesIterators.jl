module SeriesIterators

export TermIterator

using IterTools
using Base.Iterators

import Base: iterate, IteratorSize, length, size

struct TermIterator{F,I}
    generate::F
    indices::I
end
function iterate(t::TermIterator)
    vs = iterate(t.indices)
    k, s = @IterTools.ifsomething vs
    v = t.generate(k)
    v[1], (s, v)
end
function iterate(t::TermIterator, s)
    sx, p = s
    vs = iterate(t.indices, sx)
    k, s = @IterTools.ifsomething vs
    v = t.generate(k, p)
    v[1], (s, v)
end
IteratorSize(::Type{<:TermIterator{<:Any,I}}) where I = IteratorSize(I)
length(t::TermIterator) = length(t.indices)
size(t::TermIterator) = size(t.indices)


end
