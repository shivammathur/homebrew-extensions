# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/db5e99bf8109ebf6307268fe1ff844001ed47998.tar.gz"
  sha256 "f765b9d557a2d32ff59074e67cde51e0ef7f11f4ba5460e412d951f31cff9a8e"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256                               arm64_tahoe:   "9ec0d8649d702ea4ef7e98ed4fa52ffdaa76d2e179656f48905e114f872942fc"
    sha256                               arm64_sequoia: "e099b1060e5e085586fe52021d571d3ad8fe0c828359ee498162d5e7c83667fe"
    sha256                               arm64_sonoma:  "5dc983d33bbf1b3b53545ba3ae3046cfc6b71e8cab143c2b882f641f019c2ff0"
    sha256 cellar: :any_skip_relocation, sonoma:        "98564209eebd0d3195219888e1cf0df84b3af27f5fcd56af19027c9f6a2fe2ff"
    sha256                               arm64_linux:   "cd40c895efe83d12b84a184edb775b6fe0597916a412c51c6308eaddc8b720d5"
    sha256                               x86_64_linux:  "541e45f1e41b8f7f675c0aae4dccc68d442a7080a9769537ad7662e43acfe7b0"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
