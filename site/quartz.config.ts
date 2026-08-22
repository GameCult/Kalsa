import { QuartzConfig } from "./quartz/cfg";
import * as Plugin from "./quartz/plugins";

const config: QuartzConfig = {
  configuration: {
    pageTitle: "Kalsa",
    pageTitleSuffix: "",
    enableSPA: true,
    enablePopovers: true,
    analytics: null,
    locale: "en-GB",
    // Provisional until the kalsa.gamecult.org DNS and GitHub Pages binding exist.
    baseUrl: "kalsa.gamecult.org",
    ignorePatterns: [
      "private",
      "templates",
      ".obsidian",
      "Brainstorming",
      "Brainstorming/**",
      "Inspiration",
      "Inspiration/**",
    ],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: {
          name: "Cormorant Garamond",
          weights: [400, 500, 600, 700],
          includeItalic: true,
        },
        title: {
          name: "Cormorant Garamond",
          weights: [500, 600, 700],
          includeItalic: true,
        },
        body: {
          name: "Source Sans 3",
          weights: [300, 400, 500, 600, 700],
          includeItalic: true,
        },
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#f4efe2",
          lightgray: "#ded5c2",
          gray: "#8d826f",
          darkgray: "#4a4034",
          dark: "#1f1a16",
          secondary: "#7c3f2b",
          tertiary: "#47614b",
          highlight: "rgba(71, 97, 75, 0.13)",
          textHighlight: "#d1a85a66",
        },
        darkMode: {
          light: "#111713",
          lightgray: "#1c261f",
          gray: "#667567",
          darkgray: "#c3c7b7",
          dark: "#f1ecdd",
          secondary: "#d1a85a",
          tertiary: "#8eb69b",
          highlight: "rgba(142, 182, 155, 0.14)",
          textHighlight: "#d1a85a55",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      Plugin.CustomOgImages(),
    ],
  },
};

export default config;
