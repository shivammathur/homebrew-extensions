# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/7e52305eee940485bd71e8e6d76f8408f52c11be.tar.gz"
  sha256 "9cf3f1dbb69b8567a0877251ebfc9c86017cb73285aee13353786612e41517fd"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_tahoe:   "02e70402ba4ac6a6c882bd7e2bcb50ce62967735b2b6e825d511a258a49c29c0"
    sha256                               arm64_sequoia: "deccc7c3e0219b6f22a385361a4bbb53e3a7c9bd13333b867da912e12582afb6"
    sha256                               arm64_sonoma:  "025eb467d438f2b226bceafd12ec815d7a04557cdb800003bb1d0461ed451fa5"
    sha256 cellar: :any_skip_relocation, sonoma:        "acb137ca1830a35c1e5ffa32b36229418bec506e10b3647026dd5e1d5e946253"
    sha256                               arm64_linux:   "46ffa2e6f6dcdc7f7c2d9b6010f7301ba61f0a90f3d3da199b929135a09cfcb5"
    sha256                               x86_64_linux:  "4770c76935bdbf516f7053e68d7ab4c9819cbb7444489d9825520cbd892e98f7"
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
