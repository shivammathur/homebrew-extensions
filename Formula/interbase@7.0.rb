# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "80b26b92261d4d3cb02ec1ac6a353191e0f71a2a9203242cb4346b5da9133e42"
    sha256 cellar: :any, arm64_tahoe:       "bd94f5005921704f6fee0c62d4ce4ee83ac503d91c52fc930bc0d4c6cf410a21"
    sha256 cellar: :any, arm64_sequoia:     "c08c1f613a69c803ec8b23291c5c78c595582d28e5c7d4f77723d3c4545b9dc4"
    sha256 cellar: :any, arm64_linux:       "d79dd9e86962ef7cef37e3a633c12d3468452c8e4fc47a1e3a59076b274c72f9"
    sha256 cellar: :any, x86_64_linux:      "26fdbbaf8b70b87c2b1b30fc2eaa7443775949fdfad67e7bfb74567f8e986a0b"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/76d932fdc0b984a1a8d9bd42bd04fb386e36135f.tar.gz"
  version "7.0.33"
  sha256 "c7363edcfbae285748026db1e4dc70d119fead29f49c13fc42a0067d1b093241"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
