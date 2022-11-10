# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3ff56e1b68bd025fc002257b9ebb7973094ccd965e1b02a0bfa2aed774ad0d3c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "673ea819af5ec01b98ac59ad260abae8e32fa0cfc6827e727e43ffc48e520497"
    sha256 cellar: :any_skip_relocation, monterey:       "4526eb07d7c6fbf975dfdf92f1f3d57e4fa9eca1f959ba3a22b5c6ed1817066d"
    sha256 cellar: :any_skip_relocation, big_sur:        "22a9017e03af362d5fd34233c316626e51f0db99c9a8f0c7d3e7d177ecaa4e92"
    sha256 cellar: :any_skip_relocation, catalina:       "f0d8ad95e9c88ae66012af4c207153ad69fed81a309e3f2189b23711afbfeeae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0c3119989ebb1f9f71da6bf0705a98d03e1020b6bc7fbfbf6137f23d001f3b00"
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
