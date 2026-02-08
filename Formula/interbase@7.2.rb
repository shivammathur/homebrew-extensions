# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a6206708ab539e56c26dd780231107fbc7406f25ede0fad83bc3417ac532643c"
    sha256 cellar: :any,                 arm64_sequoia: "8eddbb73ede6ec061740a7fe07212060e56f1927ac7aaab74f9e2b22801f6677"
    sha256 cellar: :any,                 arm64_sonoma:  "bf9dc52c40faba62dd7d2b18dcb8195637ff44e7bad5b50facbdb8f07313bc16"
    sha256 cellar: :any,                 sonoma:        "9c1cc3c51004a66f2a4b1e63d707964778138fd2c155f9bba3119539feb7ebad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d2a823522cc5f8c71290b74129a8791edf8a3f796161d60988831c3d0104ee0a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca33f559ea2c5a0ffb7bf3457e16a871893575ec2a39881ddf464b5fdf0ebe37"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/383aaa666ea5d825183dde9e676690f62f21ad88.tar.gz"
  version "7.2.34"
  sha256 "3b48ab3d2f57cc29e793846446024f7e1219641647bf1d678a5effe460358d4d"
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
