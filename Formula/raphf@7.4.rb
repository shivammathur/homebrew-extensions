# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a282dac970a1477b3323bca1f311a480f1ecbdf5cdbdd47953a676e8b3f0607b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d913e420dceac83a05a845a79f47086a6d9a844dce26a4c4c61c3d1c4d662766"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b6a9b417407b30f4ca9c535995453189ae0012fbf646e13f99369f255a5c0f9e"
    sha256 cellar: :any_skip_relocation, ventura:        "aa3b721261fdba422dd81e1e8a3d881f354ef0b98a262b20561c6d15764d1824"
    sha256 cellar: :any_skip_relocation, monterey:       "122542bcefb29aca8bcfad4594447f374418ca0543763fc1ff97fe3af476f362"
    sha256 cellar: :any_skip_relocation, big_sur:        "50587ecef59b7fd988cce6d37cd2ebcd23d75bcbb3fb2093017bbcb12a1c15ab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3c036ca5617c38455aa60d9e18c8d342bd573faf38adeb3ecc2e84f892f3c08c"
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
