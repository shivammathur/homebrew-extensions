# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/5a8fda322b0bd0835b0fd0021358fa2309f6cea8.tar.gz?commit=5a8fda322b0bd0835b0fd0021358fa2309f6cea8"
  version "8.7.0"
  sha256 "f422cca206e773b8e1733d842e8e1a8676cb412f77b276ebb4613b6472be6f47"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "6864c961dc99f6b4b7a41da26086aeb1cab6936ef22e8ba020536990934affd0"
    sha256 cellar: :any, arm64_tahoe:       "bb61cadbdb51d13fcefc23a2a918a0d42a58c68feaf10335df772ee48604e9cc"
    sha256 cellar: :any, arm64_sequoia:     "bb51e94e3758a62aad0bcbfbdea631c8f4e3c36fc0a3bdc383463c3d45f7227c"
    sha256 cellar: :any, arm64_linux:       "7ef2fe0d2d7ca242c1b7fdaee95119f3151b7a5b7575ae1264df25dcfe042961"
    sha256 cellar: :any, x86_64_linux:      "5caaab2eaefe8e774ca43654ef1f779ea357e556c7fcc3ffd75c75be9a4a2e78"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
