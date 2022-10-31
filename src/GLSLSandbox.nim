import nagu/types/texture
import nagu/texture
import nagu/position
import nagu/glfw
import nagu/color
import nagu/program
import pnm
import std/strformat

type
  ShaderKind = enum
    ID = "id"
    Feathering = "feathering"
    BoundaryFeathering = "boundary_feathering"
    ChromaKey = "chroma_key"
    ColorKey = "color_key"
    Grow = "grow"
    Mosaic = "mosaic"

func shaderPath (kind: ShaderKind): (string, string) =
  result[0] = &"shaders/vertex/{$kind}.glsl"
  result[1] = &"shaders/fragment/{$kind}.glsl"

when isMainModule:
  var ctx = setup(1080, 720, "GLSLSandbox")
  let (vertexShader, fragmentShader) = shaderPath(Mosaic)
  var tex1 = Texture.make(Position.init(0, 0, 0), vertexShader, fragmentShader, @[], @[])
  let p = block:
    let f = open("assets/sea.ppm")
    defer:
      f.close()
    readPPM(f)

  tex1.use do (tex: var BindedTexture):
    `pixels=`(tex, (p.data, p.col, p.row))

  ctx.update:
    ctx.clear(Color.init(0.0, 0.0, 0.0))
    tex1.use do (tex: var BindedTexture):
      tex.draw()
