# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9f8cd76b9023ae3c632f28e7c6fa53f6b2c12852986bf629ac53f51a5ad5a307"
    sha256 cellar: :any,                 arm64_sequoia: "b0af987e6db29524bf61da4ebd4a293a9a5304053ad34226020df9cb1a86ce97"
    sha256 cellar: :any,                 arm64_sonoma:  "051974231f425722ae48af6e2b36ce60d8192eaa2298b52575d521225d4b226e"
    sha256 cellar: :any,                 sonoma:        "2b41dde60cafded3f231e131f9c98e753ca3a51cb1de58eae5ed11623c5bea2d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4f288f5275f32ca71247c1b822952acb278562d6c98794c5defc1e4df7f480b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "df3e3363e92ed23293de0478acdb646aaab79f57ab4409cc4b25d2688cb2bbd2"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/4de530c8e7f4d5fa3df1d0e15d79a7bd44cc597c.tar.gz"
  version "7.0.33"
  sha256 "3371c5712eae64aa28eda7733a02d93ec298894d57eb0ce3fdac0904bbee4a16"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
