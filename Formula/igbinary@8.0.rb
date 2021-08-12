# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "338b040a7633f966faf83484c48a23bd3e42efbd4b2331ebca98c885d8342608"
    sha256 cellar: :any_skip_relocation, big_sur:       "4cc50393ff650e4b88e97dcb0c25baea11adb1d3402705c091b2410861d271e6"
    sha256 cellar: :any_skip_relocation, catalina:      "b6bb90c6a91c8320c423b69f8ad705d9881f011a33a18dd808f98810d4239237"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "173ee0f94dbe1c8b23fae7d2e73c76fe77e21e209d8459e89ed4471b954147c5"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
