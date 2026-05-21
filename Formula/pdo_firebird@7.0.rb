# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/29e84585e66b01b94f8dc0059dedcc8c55820018.tar.gz"
  version "7.0.33"
  sha256 "87e056213c805ea6c4e6f5527dfa526bbdc74e93d4e64d2d972eb3dd33aa6ba0"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "fab7493891d065ee3a1ffccbab956b9974568dea9f5b73e50b698bba4996ec6f"
    sha256 cellar: :any,                 arm64_sequoia: "eaa742d17df45294eaa14c26ab80591381466caa4eb569a18cda7d3e0da77cb0"
    sha256 cellar: :any,                 arm64_sonoma:  "c3606fa359612b2a2f7575f8fe371fd951b5b2be2ff254328b51d8c2694264e0"
    sha256 cellar: :any,                 sonoma:        "bda944ac60ea60db15a787fa40c2327fc5d4b9eea9f1018450e634ed22268160"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4bb2ceb93d0582b9766c94665c94792813ffaa5f2723638cbafb961fe78bde02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "55d89d93d2f325b2f1e01590d54ac0078104e3da1e36ebbf71628ee7a51633bb"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Formula["shivammathur/extensions/firebird-client@3"].opt_prefix
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
