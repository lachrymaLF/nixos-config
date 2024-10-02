{ config, pkgs, lib, spicetify-nix, nixpkgs-2405, ... }:

{
  imports = [
    ./spicetify
  ];
  
  home.username = "lach";
  home.homeDirectory = "/home/lach";
  
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: _: {
      nixpkgs2405 = import nixpkgs-2405 {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })

    (import ../im-overlays.nix)
  ];

  home.packages = (with pkgs; [
    xmousepasteblock
    fastfetch
    ffmpeg-full
    firefox
    fish
    fsearch
    gimp
    inkscape-with-extensions
#    jdk
    krita
    mpv
    nomacs
    vlc
    obs-studio
    nixpkgs2405.onedrive
    nixpkgs2405.onedrivegui
    p7zip
    pandoc
    piper
#    prismlauncher
    qq
    smplayer
    typst
#    ungoogled-chromium
    yt-dlp
#    davinci-resolve
    reaper

    texlive.combined.scheme-medium

#    osu-lazer

    hydrapaper
    gnome-tweaks
    mission-center
  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator
    xwayland-indicator
    weather-or-not
#    wiggle
    media-controls
    blur-my-shell
    clipboard-history
    open-bar
    kimpanel
    legacy-gtk3-theme-scheme-auto-switcher
#    tray-icons-reloaded
#    burn-my-windows
#    compiz-windows-effect
    quick-settings-tweaker
  ]);

  dconf.settings = {
    "org/gnome/wm/keybindings" = {
      switch-input-source = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      switch-input-source-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Ctrl><Alt>t";
      command = "alacritty";
      name = "Console";
    };
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };
 
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
      nvarner.typst-lsp
      tomoki1207.pdf
      ms-vscode.cpptools
      ms-vscode.cpptools-extension-pack
      ms-python.python
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
    ];
    userSettings = {
      "telemetry.enableTelemetry" = false;
      "telemetry.telemetryLevel"= "off";
      "editor.fontFamily"= "'Victor Mono', Consolas, 'Courier New', monospace";
      "editor.fontSize"= 14;
      "editor.fontLigatures"= true;
      "workbench.colorCustomizations"= {
        "tab.activeBackground"= "#444444";
        "tab.activeBorder"= "#ffffff";
        "tab.activeBorderTop"="#ffffff";
        "tab.border"= "#ffffff";
        "titleBar.border"= "#ffffff";
        "titleBar.activeBackground"= "#000000";
        "activityBar.border"= "#ffffff";
        "activityBar.background"= "#000000";
        "editor.background"= "#000000";
        "statusBar.border"= "#ffffff";
        "statusBar.background"= "#333333";
        "statusBarItem.remoteBackground"= "#000000";
        "statusBar.noFolderBackground"= "#000000";
        "sideBar.background"= "#000000";
        "sideBar.border"= "#ffffff";
        "menu.background"= "#000000";
        "menu.border"= "#ffffff";   
        "editorGroupHeader.border"= "#ffffff";
        "editorGroupHeader.tabsBackground"= "#000000";
        "editorGroupHeader.tabsBorder"= "#ffffff";
        "tab.inactiveBackground"= "#000000";
        "notifications.background"= "#000000";
        "notifications.border"= "#ffffff";
        "notificationCenter.border"= "#ffffff";
        "notificationToast.border"= "#ffffff";
      };
      "terminal.integrated.fontSize"= 14;
      "security.workspace.trust.untrustedFiles"= "open";
      "editor.tokenColorCustomizations"= {
        "textMateRules"= [
          {
            "name"= "Comment";
            "scope"= [
              "comment"
              "punctuation.definition.comment"
            ];
            "settings"= {
              "foreground"= "#A7ADBA";
            };
          }
          {
            "name"= "String";
            "scope"= "string";
            "settings"= {
              "foreground"= "#99c794";
            };
          }
          {
            "name"= "Punctuation";
            "scope"= "punctuation.definition";
            "settings"= {
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "Number";
            "scope"= "constant.numeric";
            "settings"= {
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "Built-in constant";
            "scope"= "constant.language";
            "settings"= {
              "fontStyle"= "italic";
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "User-defined constant";
            "scope"= [
              "constant.character"
              "constant.other"
            ];
            "settings"= {
              "foreground"= "#c594c5";
            };
          }
          {
            "name"= "Member Variable";
            "scope"= "variable.member";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "Keyword";
            "scope"= [
              "keyword - keyword.operator"
              "keyword.operator.word"
              "keyword.control"
            ];
            "settings"= {
              "foreground"= "#c594c5";
              # "fontStyle"= "italic"
            };
          }
          {
            "name"= "Embedded Line Template Line JS";
            "scope"= "string.template.js meta.template.expression.js meta.embedded.line.js";
            "settings"= {
              "foreground"= "#d8dee9";
            };
          }
          {
            "name"= "Operators";
            "scope"= "keyword.operator";
            "settings"= {
              "foreground"= "#f97b58";
            };
          }
          {
            "scope"= [
              "keyword.operator.new"
              "keyword.operator.expression"
              "keyword.operator.cast"
              "keyword.operator.sizeof"
              "keyword.operator.logical.python"
            ];
            "settings"= {
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "Punctuation";
            "scope"= [
              "punctuation.separator"
              "punctuation.terminator"
            ];
            "settings"= {
              "foreground"= "#A7ADBA";
            };
          }
          {
            "name"= "Punctuation";
            "scope"= "punctuation.section";
            "settings"= {
              "foreground"= "#ffffff";
            };
          }
          {
            "name"= "String interpolation";
            "scope"= [
              "punctuation.definition.template-expression.begin"
              "punctuation.definition.template-expression.end"
              "punctuation.section.embedded"
            ];
            "settings"= {
              # "fontStyle"= "italic"
            };
          }
          {
            "name"= "Accessor";
            "scope"= "punctuation.accessor";
            "settings"= {
              "foreground"= "#A7ADBA";
            };
          }
          {
            "name"= "Annotation Punctuation";
            "scope"= "punctuation.definition.annotation";
            "settings"= {
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "JavaScript Dollar";
            "scope"= [
              "variable.other.dollar.only.js"
              "variable.other.object.dollar.only.js"
              "variable.type.dollar.only.js"
              "support.class.dollar.only.js"
            ];
            "settings"= {
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "this.self";
            "scope"= "variable.language";
            "settings"= {
              "fontStyle"= "italic";
              "foreground"= "#ff5874";
            };
          }
          {
            "name"= "Storage";
            "scope"= "storage";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "Storage type";
            "scope"= "storage.type";
            "settings"= {
              "foreground"= "#c594c5";
              # "fontStyle"= "italic";
            };
          }
          {
            "name"= "Storage type";
            "scope"= "storage.type.function.arrow";
            "settings"= {
              "fontStyle"= "";
            };
          }
          {
            "scope"= "storage.modifier";
            "settings"= {
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "Entity name";
            "scope"= "entity.name.function";
            "settings"= {
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "Object Property JS";
            "scope"= "meta.object-literal.key.js";
            "settings"= {
              "foreground"= "#6699cc";
            };
          }
          {
            "name"= "Entity name";
            "scope"= "entity.name - (entity.name.section | entity.name.tag | entity.name.label)";
            "settings"= {
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "Inherited class";
            "scope"= "entity.other.inherited-class";
            "settings"= {
              "fontStyle"= "italic underline";
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "Function argument";
            "scope"= "variable.parameter";
            "settings"= {
              "fontStyle"= "";
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "Language variable";
            "scope"= "variable.language";
            "settings"= {
              "foreground"= "#ec5f67";
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "Tag name";
            "scope"= "entity.name.tag";
            "settings"= {
              "fontStyle"= "";
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "Tag attribute";
            "scope"= "entity.other.attribute-name";
            "settings"= {
              "foreground"= "#c594c5";
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "Tag attribute";
            "scope"= "entity.other.attribute-name.id.css";
            "settings"= {
              "fontStyle"= "";
            };
          }
          {
            "name"= "Tag attribute";
            "scope"= "entity.other.attribute-name.class.css";
            "settings"= {
              "fontStyle"= "";
            };
          }
          {
            "name"= "Function call";
            "scope"= [
              "variable.function"
              "variable.annotation"
            ];
            "settings"= {
              "fontStyle"= "";
              "foreground"= "#6699cc";
            };
          }
          {
            "name"= "Library function";
            "scope"= [
              "support.function"
              "support.macro"
            ];
            "settings"= {
              "foreground"= "#6699cc";
            };
          }
          {
            "name"= "Library constant";
            "scope"= "support.constant";
            "settings"= {
              "foreground"= "#c594c5";
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "Library class/type";
            "scope"= [
              "support.class"
            ];
            "settings"= {
              "foreground"= "#6699cc";
              # "fontStyle"= "italic"
            };
          }
          {
            "name"= "Invalid";
            "scope"= "invalid";
            "settings"= {
              "foreground"= "#f8f8f8";
            };
          }
          {
            "name"= "Invalid deprecated";
            "scope"= "invalid.deprecated";
            "settings"= {
              "foreground"= "#f8f8f8";
            };
          }
          {
            "name"= "YAML Key";
            "scope"= "entity.name.tag.yaml";
            "settings"= {
              "foreground"= "#5fb3b3";
            };
          }
          {
            "name"= "YAML String";
            "scope"= "source.yaml string.unquoted";
            "settings"= {
              "foreground"= "#D8DEE9";
            };
          }
          {
            "name"= "markup headings";
            "scope"= "markup.heading";
              "settings"= {
                "fontStyle"= "bold";
              };
          }
          {
            "name"= "markup headings";
            "scope"= "markup.heading punctuation.definition.heading";
            "settings"= {
              "foreground"= "#f97b58";
            };
          }
          {
            "name"= "markup h1";
            "scope"= "markup.heading.1 punctuation.definition.heading";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "markup links";
            "scope"= [
              "string.other.link"
              "markup.underline.link"
            ];
            "settings"= {
              "foreground"= "#6699cc";
            };
          }
          {
            "scope"= "markup.underline";
            "settings"= {
              "fontStyle"= "underline";
            };
          }
          {
            "name"= "markup bold";
            "scope"= "markup.bold";
            "settings"= {
              "fontStyle"= "bold";
            };
          }
          {
            "name"= "markup italic";
            "scope"= "markup.italic";
            "settings"= {
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "markup bold/italic";
            "scope"= "markup.italic markup.bold | markup.bold markup.italic";
            "settings"= {
              "fontStyle"= "bold italic";
            };
          }
          {
            "name"= "markup hr";
            "scope"= "punctuation.definition.thematic-break";
            "settings"= {
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "markup numbered list bullet";
            "scope"= "markup.list.numbered.bullet";
            "settings"= {
              "foreground"= "#99c794";
            };
          }
          {
            "name"= "markup blockquote";
            "scope"= [
              "markup.quote punctuation.definition.blockquote"
              "markup.list punctuation.definition.list_item"
            ];
            "settings"= {
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "markup punctuation";
            "scope"= "(text punctuation.definition.italic | text punctuation.definition.bold)";
            "settings"= {
              "foreground"= "#c594c5";
            };
          }
          {
            "name"= "@Decorator";
            "scope"= [
              "meta.decorator punctuation.decorator"
            ];
            "settings"= {
              "fontStyle"= "italic";
            };
          }
          {
            "scope"= [
              "punctuation.definition.comment"
              "comment"
            ];
            "settings"= {
              "foreground"= "#8f97a8";
              "fontStyle"= "italic";
            };
          }
          {
            "name"= "diff.header";
            "scope"= [
              "meta.diff"
              "meta.diff.header"
            ];
            "settings"= {
              "foreground"= "#c594c5";
            };
          }
          {
            "name"= "diff.deleted";
            "scope"= "markup.deleted";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "name"= "diff.inserted";
            "scope"= "markup.inserted";
            "settings"= {
              "foreground"= "#99c794";
            };
          }
          {
            "name"= "diff.changed";
            "scope"= "markup.changed";
            "settings"= {
              "foreground"= "#f9ae58";
            };
          }
          {
            "name"= "CSS Properties";
            "scope"= "support.type.property-name";
            "settings"= {
              "foreground"= "#D8DEE9";
            };
          }
          {
            "scope"= "constant.numeric.line-number.match";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "scope"= "message.error";
            "settings"= {
              "foreground"= "#ec5f67";
            };
          }
          {
            "scope"= "token.info-token";
            "settings"= {
              "foreground"= "#6796e6";
            };
          }
          {
            "scope"= "token.warn-token";
            "settings"= {
              "foreground"= "#cd9731";
            };
          }
          {
            "scope"= "token.error-token";
            "settings"= {
              "foreground"= "#f44747";
            };
          }
          {
            "scope"= "token.debug-token";
            "settings"= {
              "foreground"= "#b267e6";
            };
          }
          {
            "scope"= "emphasis";
            "settings"= {
              "fontStyle"= "italic";
            };
          }
          {
            "scope"= "strong";
            "settings"= {
              "fontStyle"= "bold";
            };
          }
        ];
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.92;
        decorations = "Full";
      };
      font = {
        size = 12.0;

        bold = {
            family = "Victor Mono";
            style = "Bold";
        };
        
        bold_italic = {
          family = "Victor Mono";
          style = "Bold Italic";
        };
        
        italic = {
          family = "Victor Mono";
          style = "Italic";
        };

        normal = {
          family = "Victor Mono";
          style = "Regular";
        };  
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      kdePackages.fcitx5-configtool
      fcitx5-mozc
      fcitx5-gtk
      kdePackages.fcitx5-qt
      fcitx5-lua
      fcitx5-rime
    ];
  };

  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
