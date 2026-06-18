# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/7c0f1a7f0e25be8f4e298c9a6d06bf38335c13be.tar.gz"
  sha256 "2fd1a80984c9713f76e83820fb345bbdf707a5c6df8d039273897a750dff15bf"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256                               arm64_tahoe:   "aa12063e65240a6bc85a2c30cf37b82e7dde0acb22dc93a4478b0739d65fb89e"
    sha256                               arm64_sequoia: "e57ecac60b0966d447dc6e35be63fca1ce9ac9ef5aa308daf52466ba283f41c1"
    sha256                               arm64_sonoma:  "90e3633e3a5762db3b6231787b7974d9234e06dfb64a8562f7e5514a46744aaf"
    sha256 cellar: :any_skip_relocation, sonoma:        "d37b7990ae39e671d655e01f119627b690479d8c4fbd23d6cab0047b338c1717"
    sha256                               arm64_linux:   "51f28e18396e8c03c93f331ab5cfec46c3b516bc9e3204987c3a9000737c7e1e"
    sha256                               x86_64_linux:  "b25f94850e931012bfc6f629f363c2f565fad0e188e84e2f388ff53a6acc9861"
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
