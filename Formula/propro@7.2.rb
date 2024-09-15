# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT72 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "3e2d0840e0132fbbe8fbd848e1b744209716da9d2b1b20aaf6736df1c187a013"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "929f65da27bc42d84848f37eec87229a67ef5b2018588ff91d5f653e85834437"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b1af2bdc66511f29944a761b0cad9666778b90bee1e22933d5b3a541e012e7e8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "54d7775290a67c39ddb20df1b4a001be2bd5df376a131c36749b96341e45c8c1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ef878175013d73dd82be74196ad3bbbfce583d1095cc7c01671033efc7bd0027"
    sha256 cellar: :any_skip_relocation, ventura:        "da13ba10f72b1718ae4a729c1b7a04e2e07225d32751fcca847b28293e5793cd"
    sha256 cellar: :any_skip_relocation, monterey:       "61d3dc02b6afdca79d31b9de15d3f39aad04e5d569cbb64c35085c55ac90e1cb"
    sha256 cellar: :any_skip_relocation, big_sur:        "cc30c98b22d661c670cf55cfcdf051800aa1290936e9bc8c1f22fb99dc367c1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "37a590b5840c40f3b9c6806018b439a7794c47c7dd42c0e3c41e2ee2bbf024c0"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
