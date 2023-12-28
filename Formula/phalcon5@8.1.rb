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
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b3f892e0e63be3e07846273bc6c30d0de0a3660bab1ba5d46d0da7c598c34618"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "86144d5fb1ae0d4b1d3b806ec8ba78bad44bb41c3f347c5345d07e9ac522555d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cbd4cc14f60360e74b6f70c02aa0e979bf7d9e5bb38e1b3af0651f4f1290e8ad"
    sha256 cellar: :any_skip_relocation, ventura:        "b3f47d4b2112f84d0cb82679dbefae30d1c547698ec48405315335edf9744105"
    sha256 cellar: :any_skip_relocation, monterey:       "1a7f4d6e002af34e7f3e730cebb3bf08077a326da42946f9b34acc2608796a02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "11abef82d6985264ebb54825ab4e433e43dfac10f777d66fba0f7b6937a8985e"
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
