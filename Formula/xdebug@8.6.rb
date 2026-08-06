# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/9df1c18256940d273e537eae3d6115d6abf253d3.tar.gz"
  sha256 "99b7965bc1b9d1a0731476270acf11b894bdd751df53cb300b8c1cd133b9e92b"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256                               arm64_tahoe:   "9d79e26439cb0ac8b6e157e00bd917ce8ede3bf0287788f80f017cfd8bdcb431"
    sha256                               arm64_sequoia: "1c1211e0f4e88c89205543139b5debfae84065f0a0ea8302f16bf351350c7191"
    sha256                               arm64_sonoma:  "90afa42d093f64469edc43ae10d2b82f2b9ccbbd09a9e1a3371cae94e9d9b04b"
    sha256 cellar: :any_skip_relocation, sonoma:        "f36f75b332ed65c2634d7bdf6036543673f563f1c4bfd4f0ac50a518caa92c38"
    sha256                               arm64_linux:   "be58241f14a8093e0a424902d095e5fe22c094823cc42dcb8e948aa22c3ab66c"
    sha256                               x86_64_linux:  "5a30730f4fbb24b149e5a57e2580558b60336102bdc57c86be2a1ca2ad84b746"
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
