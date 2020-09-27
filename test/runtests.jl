using SeriesIterators
using Test

# Test: Ramanujan's famous series to calculate 1/π
# https://en.wikipedia.org/wiki/Srinivasa_Ramanujan#Mathematical_achievements
ramagen(k) = big(1103.0) * 2 * sqrt(big(2)) / 9801, big(1.0)
function ramagen(k, (p,p1))
    k = oftype(p1, k)
    p1 *= (1-3/4k)*(1-2/4k)*(1-1/4k)/99^4
    p = p1 * (1103 + 26390*k) * 2 * sqrt(oftype(p1, 2)) / 9801
    p, p1
end

@testset "SeriesIterators.jl" begin

    setprecision(BigFloat, 256)
    t = TermIterator(ramagen, 0:5)
    @test sum(abs, (cumsum(t) .- big(1)/pi ) .* exp10.(8:8:48)) < 10
    @test inv(cumsum(t)[end]) ≈ pi

end
