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
    sha256                               arm64_tahoe:   "80efd567be677d7a82f879f3b6e1cbe13bbd5c5a0800c1b4dcbb2d64b5c2bc4e"
    sha256                               arm64_sequoia: "af426c95a8aa765f4baa61e10b6bfa4fbd093e8bdf5cee0320a32951194c4df2"
    sha256                               arm64_sonoma:  "e9d4e21e7bcca1f71fb34f7a198ff110c6c6bef0ea323869a54efa477345ecae"
    sha256 cellar: :any_skip_relocation, sonoma:        "5bd825c4b33a3585c9be242fbc6f4ef1c2a52e2e99e14c592bb30be7969c1ab3"
    sha256                               arm64_linux:   "f804df2f893efd446055b75f95148e5566356610d60ac4df4535697d47c9f806"
    sha256                               x86_64_linux:  "642be6ce2afe884f3bd3c0c8cce3a0f02beb2c65c31f6d99b93eb074dc5a2945"
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
