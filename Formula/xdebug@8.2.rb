# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT82 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/3.5.1.tar.gz"
  sha256 "8fd5908d881a588688bd224c7e603212405fa700dc50513d0d366141c27cc78a"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256                               arm64_tahoe:   "7249d06d0e98eab862e5f0716f9ef68fc30a287d323d7a2d59fa19b7be527c53"
    sha256                               arm64_sequoia: "6f802783ca9bdee03f0f94415613411074e064cc880fbe78ab1c13f0810d874e"
    sha256                               arm64_sonoma:  "110c5423a7808d545f315dacac26975928b99e60b7c8e9f1f67d9216a35122d1"
    sha256 cellar: :any_skip_relocation, sonoma:        "463dd6835b349f25883fe2866bdda442856f9e77b404b95ca7b962782a2e6737"
    sha256                               arm64_linux:   "f4d1b2515ea32cc6b78488e92a393b138a452fabb1a592c888010b00caffa0e0"
    sha256                               x86_64_linux:  "d72596e297253c30edaa579b715d57913684806d65a79bae5181adc222bd1327"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
