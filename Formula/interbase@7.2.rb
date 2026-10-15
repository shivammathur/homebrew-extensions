# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "26d4c4d6e7f06bc2bbe0fb13a53d8427d61d94641fbfba9cfefab826a46019f9"
    sha256 cellar: :any, arm64_tahoe:       "33ce8b67eb09a58746c484c2c7ce8c24b295c86fb74f229dde715016e5fad58a"
    sha256 cellar: :any, arm64_sequoia:     "9e0190c766afa05990401a4f1f03795114e9b3d2db4b3ec9754f65e4119335f2"
    sha256 cellar: :any, arm64_linux:       "1512d4a62e3b54ab40053ced8c6f467d8c55637a353037517a620fc455206697"
    sha256 cellar: :any, x86_64_linux:      "9d57678e218a8a051c3e7e2bc27457cb06af0f988c95fdaea64f9400742d2d35"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b39d5b8abd8dcd20feb0f734ef061a54f8bbd134.tar.gz"
  version "7.2.34"
  sha256 "5f20df8c8514e84951eebad321abee448b00c5eaff6de7f304f3e760140bc578"
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
