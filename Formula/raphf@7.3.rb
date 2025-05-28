# typed: true
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

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b53bd1621d783459783d9e134ee480642efb8a290758585e3921770b02e05919"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b6e87c81cbabc1126951f0884c3fe3357df200fb1803e6c9a00392ac294a0caa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a9eb1ba593185b314593c8bc6ce2b24dd5e09269882257c131a05c930697024b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "506ed20205862ee4cd2bf449234584625b4346d2010570a0e4894078f4689242"
    sha256 cellar: :any_skip_relocation, ventura:        "6af32b6e3f6d2da8b757c6ab4836e383038cd2ffa0d2b859f49004a61e4be6d1"
    sha256 cellar: :any_skip_relocation, monterey:       "637a24d29a033865d2d4f82dc819d0ae8f152b6fc849a78517518a8681d2d82e"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "948465d40cb044518bad2c39cefd85b9fe5ab3f867dd5a31301539a86756ca15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4f43996957fcc99f848c56d297e4614b7f66bb5b6023a82df7cc454c6841a659"
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
