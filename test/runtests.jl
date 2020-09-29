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

@testset "term iterator" begin
    setprecision(BigFloat, 256)
    t = iterm(ramagen, 0:5)
    @test sum(abs, (cumsum(t) .- big(1)/pi ) .* exp10.(8:8:48)) < 10
    @test inv(cumsum(t)[end]) ≈ pi
end

@testset "bernoulli" begin
    @test bernoulli(0) == 1
    @test bernoulli(1) == -1//2
    @test bernoulli(2) == 1//6
    @test bernoulli(3) == 0
    @test bernoulli.(4:2:20) == [
      -1//30
       1//42
      -1//30
       5//66
    -691//2730
       7//6
   -3617//510
   43867//798
   -174611//330]
    @test bernoulli(200) == -498384049428333414764928632140399662108495887457206674968055822617263669621523687568865802302210999132601412697613279391058654527145340515840099290478026350382802884371712359337984274122861159800280019110197888555893671151//1366530

end

end
