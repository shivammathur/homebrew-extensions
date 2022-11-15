# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT73 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "886203d6b8a6f456cbe9c93d1c6b9017b8990223acee53a4193fa66b4ecd89ea"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "973049f05b349b5fe114148bd3f0578bd424071fa0192c0c6a027719d5a3666d"
    sha256 cellar: :any_skip_relocation, monterey:       "8d74c8e676a03d4389632e356142cc56f8f871772aa39a0d3568bab2073ff498"
    sha256 cellar: :any_skip_relocation, big_sur:        "d8858563e2901435da7eee44260d6f09e0607432cf168ed2545bb05174b89cc4"
    sha256 cellar: :any_skip_relocation, catalina:       "79551b306ae390f909b68fd6ef352b35fbe6c8ff007fbbda52b8c88ec05d6dcc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe3730046b1748a8b59f699abff8130bc12e9bb5ce28f7e667e1ee484f30bdf3"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
