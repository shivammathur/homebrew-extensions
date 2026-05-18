# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.13.0.tgz"
  sha256 "5dc5dbaa50a397930557cbd0570e9c7769000f5e1675535e58cc7f451cf490e3"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5f98d33a3115518fd9750ff51c9eae8669dc1cc0cb603b16531f0bebbf2d975c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "026ba8df6ced865c77e0533c20e3c2b55ed6904e8a857e9e2a7f4ffd02fed27e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b274c36bcabf4cac2a06cb3be6e602360b12ff97c8fe3c559ec85171790b85d9"
    sha256 cellar: :any_skip_relocation, sonoma:        "567db633fd7c462611816132f9e086ce4412fb67109ecaba4467b9769e2390bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4a29ebdb9b9fe84eab3148dc0869277d42e5fc5899b3f84f44aabf76a1b4e1ed"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e39795cfdc43449a1cea49131d446351b8fbe761f74a4cd7bef085ef5d817cf2"
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
