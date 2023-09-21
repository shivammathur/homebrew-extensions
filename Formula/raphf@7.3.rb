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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd888a130242807385f10a1ce4d30753fd7375d46c5eed541bc4e517b5f3fc32"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "886203d6b8a6f456cbe9c93d1c6b9017b8990223acee53a4193fa66b4ecd89ea"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "973049f05b349b5fe114148bd3f0578bd424071fa0192c0c6a027719d5a3666d"
    sha256 cellar: :any_skip_relocation, ventura:        "3e1ea9130a2a743f5c5371cb9f851d6c376f6f41f4bb41bf35500554690c89b2"
    sha256 cellar: :any_skip_relocation, monterey:       "62c07c598e6dfa55ba458f468f9ed41e6677bb1ce4f6647fe6ff9f97e7c368e8"
    sha256 cellar: :any_skip_relocation, big_sur:        "d8858563e2901435da7eee44260d6f09e0607432cf168ed2545bb05174b89cc4"
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
