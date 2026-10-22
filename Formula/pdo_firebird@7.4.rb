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
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "eff0c6cebd40bc3239ded3541eae0573cecffa5cc458fe32ca812354708e6f7e"
    sha256 cellar: :any, arm64_tahoe:       "feeb476ce4558a9a283f9b2abc995c2b478d3a5aa5dddd70cacc954f76f39f1a"
    sha256 cellar: :any, arm64_sequoia:     "7c695eb1131fd1fd44c21cf58a02277d7673bb7b2207c569d79fbb6f606be7b0"
    sha256 cellar: :any, arm64_linux:       "f2633cffa456e0155524b23f031ffd14a7f76582ca98c36586694d5635dd841d"
    sha256 cellar: :any, x86_64_linux:      "cb60e9312d8ad9b61b9d6428363105e7e58eb1c64533ffe456f428b45a64414e"
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
