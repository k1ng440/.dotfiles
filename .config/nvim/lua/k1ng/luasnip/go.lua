local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local util = require("k1ng.luasnip.util")
local ai = require("luasnip.nodes.absolute_indexer")
local partial = require("luasnip.extras").partial


local function not_in_function()
  return not util.is_in_function()
end

local in_test_func = {
  show_condition = util.is_in_test_function,
  condition = util.is_in_test_function,
}

local in_test_file = {
  show_condition = util.is_in_test_file,
  condition = util.is_in_test_file,
}

local in_func = {
  show_condition = util.is_in_function,
  condition = util.is_in_function,
}

local not_in_func = {
  show_condition = not_in_function,
  condition = not_in_function,
}


return {
  -- main
  ls.s(
    { trig = "main", name = "Main", dscr = "Create a main function" },
    fmta("func main() {\n\t<>\n}", ls.i(0)),
    not_in_func
  ),

  -- if call er
    ls.s(
    { trig = "ifcall", name = "IF CALL", dscr = "Call a function and check the error" },
    fmt(
      [[
      {}, {} := {}({})
      if {} != nil {{
      	return {}
      }}
      {}
    ]],
      {
        ls.i(1, { "val" }),
        ls.i(2, { "err" }),
        ls.i(3, { "Func" }),
        ls.i(4),
        rep(2),
        ls.d(5, util.make_return_nodes, { 2 }),
        ls.i(0),
      }
    ),
    in_func
  ),

  -- func
  ls.s(
    { trig = "fn", name = "Function", dscr = "Create a function or a method" },
    fmt(
      [[
        // {} {}
        func {}{}({}) {} {{
          {}
        }}
      ]],
      {
        rep(2),
        ls.i(5, "description"),
        ls.c(1, {
          ls.t(""),
          ls.sn(
            nil,
            fmt("({} {}) ", {
              ls.i(1, "r"),
              ls.i(2, "receiver"),
            })
          ),
        }),
        ls.i(2, "Name"),
        ls.i(3),
        ls.c(4, {
          ls.i(1, "error"),
          ls.sn(
            nil,
            fmt("({}, {}) ", {
              ls.i(1, "ret"),
              ls.i(2, "error"),
            })
          ),
        }),
        ls.i(0),
      }
    ),
    not_in_func
  ),

  -- if err
    ls.s(
    { trig = "ife", name = "If error", dscr = "If error, return wrapped" },
    fmt("if {} != nil {{\n\treturn {}\n}}\n{}", {
      ls.i(1, "err"),
      ls.d(2, util.make_return_nodes, { 1 }),
      ls.i(0),
    }),
    in_func
  ),

  -- if not err
    ls.s(
    { trig = "ifne", name = "If not error", dscr = "If not error, return wrapped" },
    fmt("if {} == nil {{\n\treturn {}\n}}\n{}", {
      ls.i(1, "err"),
      ls.d(2, util.make_return_nodes, { 1 }),
      ls.i(0),
    }),
    in_func
  ),

  -- nolint
  ls.s(
    { trig = "nolint", dscr = "ignore linter" },
    fmt([[// nolint:{} // {}]], {
      ls.i(1, "names"),
      ls.i(2, "explaination"),
    })
  ),

  -- make
  ls.s(
    { trig = "make", name = "Make", dscr = "Allocate map or slice" },
    fmt("{} {}= make({})\n{}", {
      ls.i(1, "name"),
      ls.i(2),
      ls.c(3, {
        fmt("[]{}, {}", { ls.i(1, "type"), ls.i(2, "len") }),
        fmt("[]{}, 0, {}", { ls.i(1, "type"), ls.i(2, "len") }),
        fmt("map[{}]{}, {}", { ls.i(1, "keys"), ls.i(2, "values"), ls.i(3, "len") }),
      }),
      ls.i(0),
    }),
    in_func
  ),

  -- table driven test
    ls.s(
    { trig = "tcs", dscr = "create test cases for testing" },
    fmta(
      [[
        tcs := map[string]struct {
        	<>
        } {
        	// Test cases here
        }
        for name, tc := range tcs {
        	tc := tc
        	t.Run(name, func(t *testing.T) {
        		<>
        	})
        }
      ]],
      { ls.i(1), ls.i(2) }
    ),
    in_test_func
  ),

  -- test
    ls.s(
    { trig = "test", dscr = "create a test function" },
    fmta(
      [[
        func Test{}(t *testing.T) {
        	<>
        }
      ]],
      { ls.i(1) }
    ),
    in_test_file
  ),

  -- cmp
    ls.s(
    { trig = "gocmp", dscr = "cmp.Diff" },
    fmt(
      [[
        if diff := cmp.Diff({}, {}); diff != "" {{
        	t.Errorf("(-want +got):\\n%s", diff)
        }}
      ]],
      {
        ls.i(1, "want"),
        ls.i(2, "got"),
      }
    ),
    in_test_func
  ),

  -- strigner
  ls.s(
    { trig = "strigner", name = "Stringer", dscr = "Create a stringer go:generate" },
    fmt("//go:generate stringer -type={} -output={}_string.go", {
      ls.i(1, "Type"),
      partial(vim.fn.expand, "%:t:r"),
    })
  ),

  -- query database
    ls.s(
    { trig = "queryrows", name = "Query Rows", dscr = "Query rows from database" },
    fmta(
      [[
      const <> = `<>`
      <> := make([]<>, 0, <>)

      <> := <>.Do(func() error {
      	<>, <> := <>.Query(<>, <>, <>)
      	if errors.Is(<>, pgx.ErrNoRows) {
      		return &retry.StopError{Err: <>}
      	}
      	if <> != nil {
      		return errors.Wrap(<>, "making query")
      	}
      	defer <>.Close()

      	<> = <>[:0]
      	for <>.Next() {
      		var <> <>
      		<> := <>.Scan(<>)
      		if <> != nil {
      			return errors.Wrap(<>, "scanning row")
      		}

      		<>
      		<> = append(<>, <>)
      	}

      	return errors.Wrap(<>.Err(), "iterating rows")
      })
      return <>, <>
      ]],
      {
        ls.i(1, "query"),
        ls.i(2, "SELECT 1"),
        ls.i(3, "ret"),
        ls.i(4, "Type"),
        ls.i(5, "cap"),
        ls.i(6, "err"),
        ls.i(7, "retrier"),
        ls.i(8, "rows"),
        ls.i(9, "err"),
        ls.i(10, "db"),
        ls.i(11, "ctx"),
        rep(1), --query
        ls.i(12, "args"),
        rep(9), -- pgx.ErrNoRows
        rep(9), -- pgx.ErrNoRows
        rep(9), -- other errors
        rep(9), -- other errors
        rep(8), -- rows close
        rep(3), -- ret
        rep(3), -- ret
        rep(8), -- rows next
        ls.i(13, "doc"),
        rep(4), -- type
        ls.i(14, "err"),
        rep(8), -- rows
        ls.i(15, "&val"),
        rep(14), -- err
        rep(14), -- err
        ls.i(0),
        rep(3), -- ret
        rep(3), -- ret
        rep(13), -- doc
        rep(8), -- rows error
        rep(3), -- ret
        rep(6), -- error
      }
    )
  ),
}
