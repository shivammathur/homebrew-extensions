# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.5.0.tgz"
  sha256 "cb68e8c4d082b0e3c4d0ee3d108d68dbc93880a7a581c4c492070a345f2226c3"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "eadf819f56cfda71e7d5e97180308fa8d700167ba07381101d69915ca2a5810c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "601e233ab5add9a5390935b72c080df0a4feeb10f276e9225ba7f95318b23b53"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a082a053a8fc8b0ebeb8fc7c34b570558ef3b862772f54e924f7cfee0197ac1d"
    sha256 cellar: :any_skip_relocation, ventura:        "8284e81bdaa41c9e05e431fc7180572cef488dca0a8ba1513e409319d1574532"
    sha256 cellar: :any_skip_relocation, monterey:       "53cca43b50a7781a821aea06683aea4102e8bd313c6be439ba4fc2c855e67bdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6e846e9abf4b7aa204519e73ec49e88ef5729deb1a206cc09fb93575e3a6e38e"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
