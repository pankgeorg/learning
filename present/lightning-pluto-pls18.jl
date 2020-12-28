### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 6b1a2152-34a8-4ae5-96ab-fc16fbfd0302
using BenchmarkTools

# ╔═╡ 62d2aac2-bb90-4c62-a01c-a12f024fe374
using CSV, DataFrames

# ╔═╡ 1d3176d2-864f-417a-b068-dd876c9fa8ac
using Plots

# ╔═╡ 21e851a3-bb00-4b77-9705-99b83839e2fe
begin
	using PlutoUI
	md"This is a hidden cell that imports stuff. Julia implicitly returns the value of the last statement in each block, be it a begin, let, function, if or whatever block"
end

# ╔═╡ 53d6af8c-487d-11eb-2662-8f34383b413b
md"""
# Julia Programming Language & Pluto.jl

Panagiotis, casually contributing @ Pluto.jl

Also ECE2009, front-end developer@intelligencia.ai


"""

# ╔═╡ 9f7462dd-b97c-46de-894c-01afee404d33
md"""
## Julia Basics
"""

# ╔═╡ fb0a072d-53b5-4bbb-a6ed-6c808ee28729
md"""
Designed to be
- fast
- intuitive
- look like math
- functional-ish
- matlab/R/Python

but mainly *fast* (except for when it JITs)
"""

# ╔═╡ dcba08f8-be7d-4c8b-b77a-003b9eec92ed
md"""
### Ranges
"""

# ╔═╡ 7f2e9fd2-edc2-42e0-8423-b30fd79d0d48
1:10, 1:0.01:1

# ╔═╡ 59c1e944-0f77-4cc1-a631-2804e5668ab2
@bind opt Select(["α", "β", "γ", "άλλο"])

# ╔═╡ 5276707f-95f7-44c6-9d5e-9d4e928ed9d0
md"""
### Control statements
"""

# ╔═╡ b7e611f7-dc5d-48de-b690-a8e05c36b570
if opt == "α"
	"άλφα"
elseif opt == "β"
	"βήτα"
elseif opt == "γ"
	"γάμμα"
else
	"άλλο"
end

# ╔═╡ 4cac95ea-f31f-4109-9861-ad8b7bf00bf4
opt == "α" ? 1 : 2 # JavaScript-y!

# ╔═╡ 157d5726-6638-4abf-8360-7132b98456ac
md"""
### Array Comprehensions
"""

# ╔═╡ a3091d16-5472-409c-8921-015d63ceb58a
[i + t - 1  for i ∈ 1:10, t ∈ 1:10]

# ╔═╡ 6e187f02-0e33-4cf0-8fc7-a423bfe712c8
[i for i ∈ 1:10][0]

# ╔═╡ 8431090a-594b-45b5-98d3-66b5a35a9273
md"""
#### Yes! That's 1-indexed!!"""

# ╔═╡ 48d467d2-56fc-4957-9535-7fca98d6bc20
begin
	arr = []
	for i ∈ 1:10
		push!(arr, i)
	end
	arr
end

# ╔═╡ 953f1054-d9d3-45cb-b366-f974db8e70a0
md"""
#### Mutations are ok!

be explicit about it: `functionname!` is the naming convention
"""

# ╔═╡ 5d47dfe7-39d2-4f1c-9e3f-7a008c3ebdd9
n = 1:12

# ╔═╡ e6811d5d-c96d-48d0-a21e-45a2d2eb6ca3
n .^ 2

# ╔═╡ d5e62d4b-13a3-4372-9188-91dbce784029
md"""
where . is the the [vectorise](https://docs.julialang.org/en/v1/manual/mathematical-operations/) operator(?) !
"""

# ╔═╡ 43940c48-6fc0-4ec2-ba45-c20d861fcff7
md"""
### Broadcasting
"""

# ╔═╡ acbe0d3d-7c52-4972-a9d0-22e72ead5a9b


# ╔═╡ f9692cb2-4585-4e7e-b6cb-188c03d41d30
broadcast

# ╔═╡ 101dc1bc-2d18-44d6-958f-7d8d973e68bb
+

# ╔═╡ 8f19bd2d-441f-432b-abb9-7e5db7478356
md"""
### Macros

Inspired by lisp!
"""

# ╔═╡ c995e340-e830-4e7e-a37f-08a65352fca1
md"""
### Compile Something
"""

# ╔═╡ 0c4807db-102e-4683-b630-24c43390c415
π, pi 

# ╔═╡ 52d61ca8-54e5-46bd-9683-203f3c8e3744
6 *  sum([1/i^2 for i in 1:100000]) - π ^ 2

# ╔═╡ ad8116b5-c8a8-4c60-b7f4-35f6dbc21cdf
function calculatepi(📏)
	# Add dots to constants to see what happens!
	Σ = 0
	🐑 = 0
	while abs(6. * Σ - π ^ 2) > 📏
		🐑= 🐑 + 1
		Σ = Σ + 1 / 🐑 ^ 2
	end
	√(6 * Σ)
end

# ╔═╡ de7d263b-c0fc-4255-8edd-41877acef893
calculatepi

# ╔═╡ a2f20d88-8338-4a20-be0d-228ec56edd4c
calculatepi(0.000001)

# ╔═╡ 9545f500-bb4c-40d3-a1ea-574bb377277a
code_typed(calculatepi, Tuple{Float64})

# ╔═╡ 62b3e448-bdd9-4a0b-9e22-a179f54aeec6
with_terminal() do 
	code_native(calculatepi, Tuple{Float64})
end

# ╔═╡ da28e85a-19a4-4b84-9e62-f95f56910618
md"""
# Types in Julia

are opt in
"""

# ╔═╡ 7c68475d-a5e9-48ef-b74e-d1cad43ffb3b
md"""
here `a` is a float (probably Float64) while the range is a range of `integers`
"""

# ╔═╡ c826c4c3-7118-496a-94e5-f9c190fa00d6
with_terminal() do
	@info @btime let
		a = 0.0
		for i ∈ 1:10_000_000
			a = a + i
		end
		a
	end
end

# ╔═╡ e56f9f56-275d-42d9-90c9-973ed23e15d0
md"""here `a` is explicitly `Int64` and the range is also `Int64`,

caring for types gives you **_speed_**
"""

# ╔═╡ cd40c360-e6e5-41c9-9683-2d0c5f0ac38f
with_terminal() do
	@info @btime let
		a = 0::Int64
		for i ∈ 1:10_000_000
			a = a::Int64 + i::Int64
		end
		a
	end
end

# ╔═╡ d3152411-3848-4f1b-aac3-13acc79d4a88
md"""
And not caring for types just __*works*__ 
"""

# ╔═╡ 4c367f62-0a1c-4dc9-83f0-bde497d0cdd8
md"""
# More Types in Julia

or "Why Julia is not part of PL2!"

"""

# ╔═╡ d6151f91-0311-4a89-b315-eee9e5d41eb0
struct Point{T<:AbstractFloat}
	a::T
	b::T
end

# ╔═╡ cf05995f-6954-490c-b1af-fe25d1e668c2
begin
	# Point{Float64}(2,2)
	# Point{Float64}(2,missing)
	# Point{Float64}(2,nothing)
end

# ╔═╡ 7504b732-0532-41ff-a051-e087502b2565
struct PointMaybeMissing2{T<:Union{AbstractFloat, Missing}}
	a::T
	b::T
end

# ╔═╡ bd0db4ee-adc9-4809-b6ba-86aa75c8b49c
Type{>:Missing} == Type{Union{T, Missing}} where T

# ╔═╡ d132585d-98c8-4905-9fbc-846480d9fce0
Type{<:AbstractFloat} == Type{Union{T, Missing}} where T<:AbstractFloat

# ╔═╡ 671d5eaf-0c7e-4885-b1f2-e19c1160fec4
md"""

bonus,

### Multiple dispatch!
"""

# ╔═╡ 98474311-ee54-4e17-815f-a1d67618c351
begin
	import Base.show
	function show(number::Number)
		"$(number)"
	end
	function show(number::Float64)
		"$(number) from show for Float64"
	end
	function show(number::Int64)
		"$(number) from show for Int64"
	end
	function show(number::AbstractFloat)
		"$(number) is an AbstractFloat"
	end
	# function show(number::BigFloat)
	# 	"$(number) can be abritrarily large!"
	# end
end

# ╔═╡ f75aac94-465d-423b-9746-a3357bf82031
show(4)

# ╔═╡ c608693a-657d-447b-85b8-24a05125cb61
show(4.1)

# ╔═╡ ba41cede-7dde-47a8-bfa1-5370634390dc
begin 
	import Base.MPFR
	four = Base.MPFR.BigFloat(4)
	show(four)
end

# ╔═╡ 80d45ef8-ff90-4781-92db-439569526e0b
md"""

### Method Specificity

"Call the most specific matching method" [(@JeffBezanson)](https://www.youtube.com/watch?v=TPuJsgyu87U&ab_channel=TheJuliaProgrammingLanguage)

1. Strict subtype (<:, not ==) → more specific
- ???
""" 

# ╔═╡ 8ffd70a3-8e5b-4100-91a0-ddc7698a5fd6
md"""
No ambiguity:

	1. (AbstractArray)
	2. (Any, Integer)


1 is *not* more specific than 2, because one argument is different than two arguments

Let's add this to the mix
 	
	3. (AbstractArray, Int...)

`Int...` is *any number* of Ints, so these work: ([1,2,3], 4, 5,) or ([1,2,3])

Then

	 AbstractArray, Int... (3) <: Any, Integer (2)

and but also, for 0 Ints:
	
	AbstractArray (1) <: AbstractArray, Int... (3)

*but* we said that 1 <::> 2 --> `Subset` relation is not transitive? 💥💥
??????

#### Patched:

1 argument methods are more specific 🎉🎉🎈🎊🥳

"""

# ╔═╡ d6b800dc-a386-4de2-acc0-6c32c0dd5261
md"""
#### But!
clopied pasted from Jeff Bezanson

| Number Hierarchy | Union Hierarchy |
| :---- | :--- |
|$(Resource("https://i.imgur.com/JmBPf8y.png")) | $(Resource("https://i.imgur.com/H08jTat.png")) |

##### Note: 3 → 4


    Union{`Float64`, `AbstractComplex`} ∩ `AbstractFloat` ≡ `Float64` ∩ `AbstractFloat`

Rest left as an exercise to the reader 🤗✨🐱‍🏍

"""





# ╔═╡ 99b645ec-d3ca-4303-a51e-134f11e659d0
md"""
### Are these really anyones' problems?? 🤷‍♂️🤷‍♀️🤷‍♂️🤷‍♀️
"""

# ╔═╡ c2a31489-3315-4cd7-83da-b4b834eb0d1d
md"""
# Pluto.jl: a fresh notebook for Julia

written by [fonsi](https://github.com/fonsp) and [malyvsen](https://github.com/malyvsen) and [dral](https://github.com/dralletje), casually patched by [me](#82862e32-ab19-4766-86be-4f77bdb7fcfb)



### Keys:

- reactive - as in Excel!
- files are valid Julia files (can run with `julia ./fun-program.jl`) 
- no hidden state
- can reorder cells to tell _your_ story (and backend runs the *DAG*, thanks [observable](http://observablehq.com/))
- literate programming fundamentals
- leverages `show` methods with `text/html` to show julia structs in HTML/CSS/**JavaScript**

### Why:

- reproducible research
- version control notebooks
- interactive articles/publications for the masses
- lower the entry barrier to programming (beginner tool - no vim mode - no emacs mode - ever)
- solve the [9 problems with notebooks](https://web.eecs.utk.edu/~azh/pubs/Chattopadhyay2020CHI_NotebookPainpoints.pdf)


and, of course
- quarantine fun


"""

# ╔═╡ 9dfabf04-6301-4376-ab51-bee89bce6672
md"""
### In Action | Human Machine learning
heavily inspired from [malyvsen](https://github.com/malyvsen)
"""

# ╔═╡ 63511ed2-fc8c-46ea-8186-505d52f4ad6b
weather_df = begin
	file = download("https://gist.githubusercontent.com/pankgeorg/57d38097b56c99a8e4da9b62fd87a3d0/raw/693429a56ea0707381ad94b6b0943d8fcf17ec8d/20201020to20201228_neopsychiko_weather.csv")
CSV.read(file, DataFrame)
end

# ╔═╡ 54b2b95e-ef97-495c-9937-50663dcb084b
filter_df = weather_df;

# ╔═╡ 94e79d8b-3a59-4e47-82a1-7093e9e696a9
md"""

| 🎨 🎮 | Control Panel:
| :--- | :--- |
| Avg Temperature | $(@bind temp Slider(0:0.1:30; default=15.8, show_value=true)) |
| Period | $(@bind period Slider(22:0.1:26; default=24, show_value=true)) |
| Phase | $(@bind phase Slider(0:0.1:24; default=5.2, show_value=true)) |
| A | $(@bind A Slider(0:0.1:30; default=5.2, show_value=true)) |
| Slow Offset | $(@bind stemp Slider(-10:0.1:10; default=0.3, show_value=true)) |
| Slow Period | $(@bind speriod Slider(0:365; default=85, show_value=true)) |
| Slow Phase | $(@bind sphase Slider(0:365; default=62, show_value=true)) |
| Slow A | $(@bind sA Slider(0:0.1:30; default=5.3, show_value=true)) |

"""

# ╔═╡ 9330f564-a26b-4cff-ab89-4bfd87ba5351
temp, period, phase, A

# ╔═╡ 11df8461-9a1b-4a8d-a13f-641f9c9e223d
describe(filter_df);  # small statistics

# ╔═╡ c6dc73f6-85d0-411f-a521-2df29d5b35e6
begin
	l = length(filter_df[!, "Created At"])
	p = plot(
		filter_df[!, "Created At"],
		filter_df[!, "Average of Temperature"],
		labels="Temperature"
	)
	model_indices = [2 * pi * i / period - phase for i in 1:l]
	model_day = temp .+ A / 2 * sin.(2 * pi * (i - phase) / (period) for i in 1:l)
	model_year = stemp .+ sA / 2 * sin.([2 * pi * (i - 24 * sphase) / (24 * speriod) for i in 1:l])
	model = model_day .+ model_year
	plot!(filter_df[!, "Created At"], model, labels="Model")
end

# ╔═╡ 245ebac6-d4fd-476e-8e8b-38cbc89cc2a0
abs(sum(model.^2 .-  filter_df[!, "Average of Temperature"].^2))

# ╔═╡ 32977a26-02ac-44c0-b984-0a3c9d92b41f
md"""
## Pluto Vision / Roadmap

- Simpler than excel
- Accessible
- Schools
- Work in Chromebooks
- gUIs for everything
- Cloud Native ™®™®
"""

# ╔═╡ fb7fbafb-d107-438c-be9d-048b20dc3564
md"""
## Links

- Pluto.jl → [https://github.com/fonsp/Pluto.jl](https://github.com/fonsp/Pluto.jl)
- Julia → [https://julialang.org/](https://julialang.org/)
- [Computational Thinking @ MIT](https://computationalthinking.mit.edu/Fall20/), taught with Julia & Pluto!
- [What’s Wrong with Computational Notebooks? Pain Points, Needs, and Design Opportunities](https://web.eecs.utk.edu/~azh/pubs/Chattopadhyay2020CHI_NotebookPainpoints.pdf)
- Other cool notebooks [deepnote.ai](https://deepnote.com/), [nextjournal](http://nextjournal.com/) and of course [jupyter](https://jupyter.org/)
- [What is bad about Julia](https://www.youtube.com/watch?v=TPuJsgyu87U&ab_channel=TheJuliaProgrammingLanguage) by Jeff Bezanson, Julia Computing
- [The Future of Spreadsheets](https://www.youtube.com/watch?v=WTnwl_skD-Q&t=50s&ab_channel=MicrosoftResearch), Microsoft Research
- Pluto fonts are `Alegreya Sans`, `Vollkorn` and [`Julia Mono`](https://github.com/cormullion/juliamono) (for all these UTF-8 math characters and ligatures) 
- pankgeorg ~ you can find me `~`@`{gmail.com}`, `github.com/~`, `~.com`

# Thank you!

---
"""

# ╔═╡ 04c54def-40a1-4423-8c47-1f554bacffbd
html"""
<span>Custom styles(!)</span>
<span style="visibility: hidden">CSS is awesome</span>
<style>
a {
	font-weight: 400;	
}
.markdown pre {
	background-color: #2b3e50;
	color: whitesmoke;
}
.markdown :not(pre) code {
	background-color: #2b3e50;
	color: whitesmoke;
	padding: .1rem .25em;
	margin: -.1em .25em;
	border-radius: .25em;
}
pluto-input > button.delete_cell > span::after {
	filter: brightness(0) invert(1);
}
.markdown img {
 	width: 300px;
}
.markdown td bond {
	width: 240px;
	display: block
}

.markdown table {
	margin-left: 2rem;
}
</style>
"""


# ╔═╡ a9ea2fe3-04db-41c4-8982-43e4e65de952
excelImg = Resource("https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Microsoft_Office_Excel_%282018%E2%80%93present%29.svg/103px-Microsoft_Office_Excel_%282018%E2%80%93present%29.svg.png")

# ╔═╡ dc94c160-b3af-428f-aa16-e0e0d4e75179
dataScience = html"""<span style="color: red; font-size: 1.1em">dAtA SciEnCe!1!11</span>"""

# ╔═╡ 82862e32-ab19-4766-86be-4f77bdb7fcfb
md"""
# Me

I'm a software developer for the masses (front-end in React, Angular, backend in Python)

Contributing to [Pluto.jl](https://github.com/fonsp/Pluto.jl/graphs/contributors), one feature at a time!

#### Past

I've done some serious development in

$(excelImg)

which is probably the [most widely used](https://www.youtube.com/watch?v=WTnwl_skD-Q&t=50s&ab_channel=MicrosoftResearch) programming language out there

#### Currently

- Writing React applications for intelligencia.ai (we're hiring!)
- Face software engineering challenges deploying, explaining and presenting $(dataScience) stuff

#### Also

- Gardening
- Maintaining a [weather station](https://metabase.pankgeorg.com/public/dashboard/680eb6ec-ebdf-4691-ab73-994f14d4540e??created_at=past0days~)
- Cooking (but no pastry yet)
"""

# ╔═╡ 8b03809a-1c36-472f-b53c-f227e3844a42
let
    import Pkg
    Pkg.add(url="https://github.com/Pocket-titan/DarkMode")
	Pkg.add("BenchmarkTools")
	Pkg.add("CSV")
	Pkg.add("Plots")
	Pkg.add("DataFrames")
    import DarkMode
    DarkMode.Toolbox(theme="lucario", ligatures=true)
end

# ╔═╡ Cell order:
# ╟─53d6af8c-487d-11eb-2662-8f34383b413b
# ╟─9f7462dd-b97c-46de-894c-01afee404d33
# ╟─fb0a072d-53b5-4bbb-a6ed-6c808ee28729
# ╟─dcba08f8-be7d-4c8b-b77a-003b9eec92ed
# ╠═7f2e9fd2-edc2-42e0-8423-b30fd79d0d48
# ╟─59c1e944-0f77-4cc1-a631-2804e5668ab2
# ╟─5276707f-95f7-44c6-9d5e-9d4e928ed9d0
# ╠═b7e611f7-dc5d-48de-b690-a8e05c36b570
# ╠═4cac95ea-f31f-4109-9861-ad8b7bf00bf4
# ╟─157d5726-6638-4abf-8360-7132b98456ac
# ╠═a3091d16-5472-409c-8921-015d63ceb58a
# ╠═6e187f02-0e33-4cf0-8fc7-a423bfe712c8
# ╟─8431090a-594b-45b5-98d3-66b5a35a9273
# ╠═48d467d2-56fc-4957-9535-7fca98d6bc20
# ╟─953f1054-d9d3-45cb-b366-f974db8e70a0
# ╠═e6811d5d-c96d-48d0-a21e-45a2d2eb6ca3
# ╠═5d47dfe7-39d2-4f1c-9e3f-7a008c3ebdd9
# ╟─d5e62d4b-13a3-4372-9188-91dbce784029
# ╟─43940c48-6fc0-4ec2-ba45-c20d861fcff7
# ╠═acbe0d3d-7c52-4972-a9d0-22e72ead5a9b
# ╠═f9692cb2-4585-4e7e-b6cb-188c03d41d30
# ╠═101dc1bc-2d18-44d6-958f-7d8d973e68bb
# ╟─8f19bd2d-441f-432b-abb9-7e5db7478356
# ╟─c995e340-e830-4e7e-a37f-08a65352fca1
# ╠═0c4807db-102e-4683-b630-24c43390c415
# ╠═de7d263b-c0fc-4255-8edd-41877acef893
# ╠═52d61ca8-54e5-46bd-9683-203f3c8e3744
# ╠═a2f20d88-8338-4a20-be0d-228ec56edd4c
# ╠═ad8116b5-c8a8-4c60-b7f4-35f6dbc21cdf
# ╠═9545f500-bb4c-40d3-a1ea-574bb377277a
# ╠═62b3e448-bdd9-4a0b-9e22-a179f54aeec6
# ╟─da28e85a-19a4-4b84-9e62-f95f56910618
# ╠═6b1a2152-34a8-4ae5-96ab-fc16fbfd0302
# ╟─7c68475d-a5e9-48ef-b74e-d1cad43ffb3b
# ╠═c826c4c3-7118-496a-94e5-f9c190fa00d6
# ╟─e56f9f56-275d-42d9-90c9-973ed23e15d0
# ╠═cd40c360-e6e5-41c9-9683-2d0c5f0ac38f
# ╟─d3152411-3848-4f1b-aac3-13acc79d4a88
# ╟─4c367f62-0a1c-4dc9-83f0-bde497d0cdd8
# ╠═d6151f91-0311-4a89-b315-eee9e5d41eb0
# ╠═cf05995f-6954-490c-b1af-fe25d1e668c2
# ╠═7504b732-0532-41ff-a051-e087502b2565
# ╠═bd0db4ee-adc9-4809-b6ba-86aa75c8b49c
# ╠═d132585d-98c8-4905-9fbc-846480d9fce0
# ╟─671d5eaf-0c7e-4885-b1f2-e19c1160fec4
# ╠═98474311-ee54-4e17-815f-a1d67618c351
# ╠═f75aac94-465d-423b-9746-a3357bf82031
# ╠═c608693a-657d-447b-85b8-24a05125cb61
# ╠═ba41cede-7dde-47a8-bfa1-5370634390dc
# ╟─80d45ef8-ff90-4781-92db-439569526e0b
# ╟─8ffd70a3-8e5b-4100-91a0-ddc7698a5fd6
# ╠═d6b800dc-a386-4de2-acc0-6c32c0dd5261
# ╠═99b645ec-d3ca-4303-a51e-134f11e659d0
# ╟─c2a31489-3315-4cd7-83da-b4b834eb0d1d
# ╟─9dfabf04-6301-4376-ab51-bee89bce6672
# ╠═62d2aac2-bb90-4c62-a01c-a12f024fe374
# ╠═63511ed2-fc8c-46ea-8186-505d52f4ad6b
# ╠═1d3176d2-864f-417a-b068-dd876c9fa8ac
# ╠═54b2b95e-ef97-495c-9937-50663dcb084b
# ╟─94e79d8b-3a59-4e47-82a1-7093e9e696a9
# ╠═9330f564-a26b-4cff-ab89-4bfd87ba5351
# ╠═11df8461-9a1b-4a8d-a13f-641f9c9e223d
# ╠═245ebac6-d4fd-476e-8e8b-38cbc89cc2a0
# ╠═c6dc73f6-85d0-411f-a521-2df29d5b35e6
# ╟─32977a26-02ac-44c0-b984-0a3c9d92b41f
# ╟─fb7fbafb-d107-438c-be9d-048b20dc3564
# ╟─04c54def-40a1-4423-8c47-1f554bacffbd
# ╟─a9ea2fe3-04db-41c4-8982-43e4e65de952
# ╟─dc94c160-b3af-428f-aa16-e0e0d4e75179
# ╟─21e851a3-bb00-4b77-9705-99b83839e2fe
# ╟─82862e32-ab19-4766-86be-4f77bdb7fcfb
# ╠═8b03809a-1c36-472f-b53c-f227e3844a42
