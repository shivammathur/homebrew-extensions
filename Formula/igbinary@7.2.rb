# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c05c7d5db37738c01c0aad9ce306a32396d880e2f84d3ae8d3a625fa017d6309"
    sha256 cellar: :any_skip_relocation, big_sur:       "32ff859bff2ce5c64e6104777642bd7c95c9778549360aeab30c730c1121cbde"
    sha256 cellar: :any_skip_relocation, catalina:      "28d814fec594347ae9183010ac4967427df98612e9f053e944cf62374dcfb2ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6678f3b3d791c9a6eac043cf0dd24b72792a2f32e078561e7040895cc3295851"
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
