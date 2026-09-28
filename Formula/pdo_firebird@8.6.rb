# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f5d89c83944b949935fff888b0e3159fc65e4cf1.tar.gz?commit=f5d89c83944b949935fff888b0e3159fc65e4cf1"
  version "8.6.0"
  sha256 "1282a69d63f7fdfd88a9fa6ce2d1546d54cfa825f205346b080a8f87ad295534"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "5934e6d0771071bc26ba912c6c5af8130ecf313045803a5d9d23a2e50d900d15"
    sha256 cellar: :any, arm64_tahoe:       "06b552ab0d10d35eea573da6e51f2610de8915df8c5343dba301bb63c44aa7d7"
    sha256 cellar: :any, arm64_sequoia:     "84182d715572a0eb7b576271a0d6563449c96edc0d9a9a93946d7696229aa84f"
    sha256 cellar: :any, arm64_linux:       "c6cc460f0d2e2a6d599a33cc6ae14e6203a9946a2dc16af3ca359fb62ca0fd9d"
    sha256 cellar: :any, x86_64_linux:      "da6fb47580366f05d477037f50a281aeae385b0faa38f94f2313fb3a04c13d3d"
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
