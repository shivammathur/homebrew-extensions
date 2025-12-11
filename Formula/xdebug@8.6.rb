# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/4a470b324eda3288c2fb3b9f5a08ceef599dc12b.tar.gz"
  sha256 "a3373ff5943746c20692e105afc98c962d87de3b711560dcf411db67de5591e0"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_tahoe:   "7e5933125db607b3befaa448f4df2f854ea631fee41385b2bb6470b2b1182c2d"
    sha256                               arm64_sequoia: "280975c9c59a85e37c0632bd04a23207065d14fd90ccb0c90688c7a6e51c1f2e"
    sha256                               arm64_sonoma:  "1dfded9f143e73395de3fa42eb439ae2229132444b99f70f46e8b397b42de50b"
    sha256 cellar: :any_skip_relocation, sonoma:        "03c252d83d24770cafcc1384f3dd3974c1b83334742deea9efc3e1eb80d7e91d"
    sha256                               arm64_linux:   "cd17a7388d2a82264029564783dc53cb42658a46169b467186f3c4c297aa7518"
    sha256                               x86_64_linux:  "44ed9fc7bbc8ca858bda0d0e337014a4efd91005041000164126ce4aa681cee5"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
