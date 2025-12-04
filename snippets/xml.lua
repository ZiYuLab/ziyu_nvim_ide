local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

ls.add_snippets("xml", {
  -- 基础 SDF 结构
  s(
    "sdf",
    fmt(
      [[
    <?xml version="1.0" encoding="UTF-8"?>
    <sdf version="{}">
      {}
    </sdf>
  ]],
      {
        c(1, { t("1.9"), t("1.8"), t("1.7"), t("1.6") }),
        i(2),
      }
    )
  ),

  -- World 世界
  s(
    "world",
    fmt(
      [[
    <world name="{}">
      <gravity>0 0 -9.8</gravity>
      <physics name="default_physics" default="true" type="ode">
        <max_step_size>{}</max_step_size>
        <real_time_factor>{}</real_time_factor>
        <real_time_update_rate>{}</real_time_update_rate>
      </physics>
      {}
    </world>
  ]],
      {
        i(1, "default_world"),
        i(2, "0.001"),
        i(3, "1.0"),
        i(4, "1000"),
        i(5),
      }
    )
  ),

  -- Model 模型
  s(
    "model",
    fmt(
      [[
    <model name="{}">
      <pose>{}</pose>
      <static>{}</static>
      {}
    </model>
  ]],
      {
        i(1, "my_model"),
        i(2, "0 0 0 0 0 0"),
        c(3, { t("false"), t("true") }),
        i(4),
      }
    )
  ),

  -- Link 链接
  s(
    "link",
    fmt(
      [[
    <link name="{}">
      <pose>{}</pose>
      {}
      {}
      {}
    </link>
  ]],
      {
        i(1, "link"),
        i(2, "0 0 0 0 0 0"),
        c(3, {
          fmt(
            [[
      <inertial>
        <mass>{}</mass>
        <inertia>
          <ixx>{}</ixx>
          <ixy>{}</ixy>
          <ixz>{}</ixz>
          <iyy>{}</iyy>
          <iyz>{}</iyz>
          <izz>{}</izz>
        </inertia>
      </inertial>
      ]],
            { i(1, "1.0"), i(2, "1.0"), i(3, "0.0"), i(4, "0.0"), i(5, "1.0"), i(6, "0.0"), i(7, "1.0") }
          ),
          t(""),
        }),
        c(4, {
          fmt(
            [[
      <collision name="{}">
        <geometry>
          {}
        </geometry>
      </collision>
      ]],
            {
              i(1, "collision"),
              c(2, {
                fmt([[<box><size>{}</size></box>]], { i(1, "1 1 1") }),
                fmt([[<sphere><radius>{}</radius></sphere>]], { i(1, "0.5") }),
                fmt([[<cylinder><radius>{}</radius><length>{}</length></cylinder>]], { i(1, "0.5"), i(2, "1.0") }),
                fmt(
                  [[<mesh><uri>{}</uri><scale>{}</scale></mesh>]],
                  { i(1, "model://meshes/my_mesh.dae"), i(2, "1 1 1") }
                ),
              }),
            }
          ),
          t(""),
        }),
        c(5, {
          fmt(
            [[
      <visual name="{}">
        <geometry>
          {}
        </geometry>
        <material>
          <ambient>{}</ambient>
          <diffuse>{}</diffuse>
          <specular>{}</specular>
        </material>
      </visual>
      ]],
            {
              i(1, "visual"),
              c(2, {
                fmt([[<box><size>{}</size></box>]], { i(1, "1 1 1") }),
                fmt([[<sphere><radius>{}</radius></sphere>]], { i(1, "0.5") }),
                fmt([[<cylinder><radius>{}</radius><length>{}</length></cylinder>]], { i(1, "0.5"), i(2, "1.0") }),
                fmt(
                  [[<mesh><uri>{}</uri><scale>{}</scale></mesh>]],
                  { i(1, "model://meshes/my_mesh.dae"), i(2, "1 1 1") }
                ),
              }),
              i(3, "0.1 0.1 0.1 1"),
              i(4, "0.5 0.5 0.5 1"),
              i(5, "0.1 0.1 0.1 1"),
            }
          ),
          t(""),
        }),
      }
    )
  ),

  -- Joint 关节
  s(
    "joint",
    fmt(
      [[
    <joint name="{}" type="{}">
      <parent>{}</parent>
      <child>{}</child>
      <axis>
        <xyz>{}</xyz>
        <limit>
          <lower>{}</lower>
          <upper>{}</upper>
          <effort>{}</effort>
          <velocity>{}</velocity>
        </limit>
      </axis>
    </joint>
  ]],
      {
        i(1, "joint"),
        c(2, { t("revolute"), t("prismatic"), t("fixed"), t("ball") }),
        i(3, "parent_link"),
        i(4, "child_link"),
        i(5, "0 0 1"),
        i(6, "-3.14159"),
        i(7, "3.14159"),
        i(8, "1000"),
        i(9, "100"),
      }
    )
  ),

  -- 基本几何体快速片段
  s("box", fmt([[<box><size>{}</size></box>]], { i(1, "1 1 1") })),
  s("sphere", fmt([[<sphere><radius>{}</radius></sphere>]], { i(1, "0.5") })),
  s("cylinder", fmt([[<cylinder><radius>{}</radius><length>{}</length></cylinder>]], { i(1, "0.5"), i(2, "1.0") })),
  s("plane", fmt([[<plane><normal>{}</normal><size>{}</size></plane>]], { i(1, "0 0 1"), i(2, "10 10") })),

  -- 光源
  s(
    "light",
    fmt(
      [[
    <light name="{}" type="{}">
      <pose>{}</pose>
      <diffuse>{}</diffuse>
      <specular>{}</specular>
      <attenuation>
        <range>{}</range>
        <constant>{}</constant>
        <linear>{}</linear>
        <quadratic>{}</quadratic>
      </attenuation>
      <direction>{}</direction>
    </light>
  ]],
      {
        i(1, "light"),
        c(2, { t("point"), t("directional"), t("spot") }),
        i(3, "0 0 2 0 0 0"),
        i(4, "1 1 1 1"),
        i(5, "1 1 1 1"),
        i(6, "10"),
        i(7, "1.0"),
        i(8, "0.0"),
        i(9, "0.0"),
        i(10, "0 0 -1"),
      }
    )
  ),

  -- 插件
  s(
    "plugin",
    fmt(
      [[
    <plugin name="{}" filename="{}">
      {}
    </plugin>
  ]],
      {
        i(1, "my_plugin"),
        i(2, "libmy_plugin.so"),
        i(3),
      }
    )
  ),
}, {
  key = "sdf_snippets",
})
