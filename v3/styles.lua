local styles = {}

-- Surface colours
styles.surfaces = {}
styles.surfaces.zero = Color3.fromHex("#1c1b1f")
styles.surfaces.one = Color3.fromHex("#25232a")
styles.surfaces.two = Color3.fromHex("#2a2831")
styles.surfaces.three = Color3.fromHex("#302d38")
styles.surfaces.four = Color3.fromHex("#322e3a")
styles.surfaces.five = Color3.fromHex("#35323e")

-- Variant colours
styles.variants = {}
styles.variants.onSurface = Color3.fromHex("#e6e1e5")
styles.variants.surfaceVariant = Color3.fromHex("#49454f")
styles.variants.onSurfaceVariant = Color3.fromHex("#cac4d0")
styles.variants.outline = Color3.fromHex("#938f99")
styles.variants.outlineVariant = Color3.fromHex("#49454f")

-- Themed colours
styles.colours = {}
styles.colours.primary = Color3.fromHex("#d0bcff")
styles.colours.onPrimary = Color3.fromHex("#381e72")
styles.colours.primaryContainer = Color3.fromHex("#4f378b")
styles.colours.onPrimaryContainer = Color3.fromHex("#eaddff")
styles.colours.secondary = Color3.fromHex("#ccc2dc")
styles.colours.onSecondary = Color3.fromHex("#332d41")
styles.colours.secondaryContainer = Color3.fromHex("#4a4458")
styles.colours.onSecondaryContainer = Color3.fromHex("#e8def8")
styles.colours.tertiary = Color3.fromHex("#efb8c8")
styles.colours.onTertiary = Color3.fromHex("#492532")
styles.colours.tertiaryContainer = Color3.fromHex("#633b48")
styles.colours.onTertiaryContainer = Color3.fromHex("#ffd8e4")
styles.colours.error = Color3.fromHex("#f2b8b5")
styles.colours.onError = Color3.fromHex("#601410")
styles.colours.errorContainer = Color3.fromHex("#8c1d18")
styles.colours.onErrorContainer = Color3.fromHex("#f9dedc")

-- State layer opacities
styles.states = {}
styles.states.disabledForeground = .12
styles.states.disabledBackground = .38
styles.states.hovered = .08
styles.states.focused = .12
styles.states.pressed = .12
styles.states.dragged = .16

-- Font sizes & weights
styles.fonts = {}
styles.fonts.display = {}
styles.fonts.display.large = 57
styles.fonts.display.medium = 45
styles.fonts.display.small = 36
styles.fonts.display.weight = Enum.FontWeight.SemiBold
styles.fonts.headline = {}
styles.fonts.headline.large = 32
styles.fonts.headline.medium = 28
styles.fonts.headline.small = 24
styles.fonts.headline.weight = Enum.FontWeight.Regular
styles.fonts.title = {}
styles.fonts.title.large = 22
styles.fonts.title.medium = 16
styles.fonts.title.small = 14
styles.fonts.title.weight = Enum.FontWeight.Bold
styles.fonts.label = {}
styles.fonts.label.large = 14
styles.fonts.label.medium = 12
styles.fonts.label.small = 11
styles.fonts.label.weight = Enum.FontWeight.Bold
styles.fonts.body = {}
styles.fonts.body.large = 16
styles.fonts.body.medium = 14
styles.fonts.body.small = 12
styles.fonts.body.weight = Enum.FontWeight.Regular
styles.fonts.icon = 24

-- Shadow colours & sizes
--TODO

return styles