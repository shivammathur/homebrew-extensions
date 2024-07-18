# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT84 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/81a312d956ce29258b8c26d1fdc9d666b942c8d9.tar.gz"
  sha256 "db183091907e4bc9988c0b9d9319074cb5e077e4d55e77903b0f97c85d29b025"
  version "3.3.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 arm64_sonoma:   "1c17e851cce5a1503e985de532b686ee40a0595fd318e0a96ccda9db6899fbaf"
    sha256 arm64_ventura:  "54cad0d0f8bee5ce66681aac7051a7dd6b564f24b83d8a4fe66d1e1e510677b2"
    sha256 arm64_monterey: "598ca05c5b689d87baf02ded4051f30fa08b9ea841befd1aef47c599a6e06731"
    sha256 ventura:        "d259d92bceb6cb5d42db6ba164fa1a9511376a6049b14430604aaded44785aa0"
    sha256 monterey:       "bc59181c710276cd8672f171bb3a5194be336ef8742f0a8d4b017457e6bb4b51"
    sha256 x86_64_linux:   "74a299962135d32be8e3b031d70aa99fbf0612dcb545e48fe740aaba2f3edabc"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/usefulstuff.c", "ext/standard/php_lcg.h", "ext/random/php_random.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
