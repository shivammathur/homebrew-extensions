# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/066522cf9c489c59d41bfca7cbfb08eb36fe4cd4.tar.gz"
  version "7.4.33"
  sha256 "da5bc8dd8f95b172b9be7a355f5e0b783a409c01100d305ff234af207bd39552"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "cc0401cdc95ab9b21047c966bba392ea71265198b2cefb923afe35014c40b978"
    sha256 cellar: :any, arm64_tahoe:       "0ba6710f498306594e01f3a77abef05b97d74a312314f8847eb9c72f08c16194"
    sha256 cellar: :any, arm64_sequoia:     "90273a58a41da84d3711a4942e19335b610668dcc40bf9b71a5756db63935517"
    sha256 cellar: :any, arm64_linux:       "4d5b8ab0fab3d863803bf51c8facbde1851bfb29eb41ddef2fc176049013d1c3"
    sha256 cellar: :any, x86_64_linux:      "3d1218ba99bdf1c37735928a9bec0bf7d36aa0b03524b8d693286331015559f4"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
