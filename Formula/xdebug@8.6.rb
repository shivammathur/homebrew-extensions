# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/b6003ea5a22c07ad4dcac9c9ca578caf2251c31c.tar.gz"
  sha256 "02403df10b7d04d4806f31133c8acec973224487be4ac78d52e2642cfe912a71"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256                               arm64_tahoe:   "a2e39726b826c0649f1cde352bab8a52937a1197b92eec4203a629539ac77523"
    sha256                               arm64_sequoia: "d87ca153816f6d46d31137200387076c34ccd4f01c7d61a58a53a4d622353029"
    sha256                               arm64_sonoma:  "5433fc03725aada0c3caefb3f1da460d808e94767d2ee3ce9d6ec375ba59645a"
    sha256 cellar: :any_skip_relocation, sonoma:        "d03113a3baa91ae29adee111364b37db32d487e3177478793aa2f46d312815b4"
    sha256                               arm64_linux:   "97f98de357b669bca5fb9cac6e9708701e5d1f26d45fb2fa4c611ef2c6d663db"
    sha256                               x86_64_linux:  "62438d7e12f6e112588bd51e9bcc1700f222a497f207859f615d56d8e9b4bb59"
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
