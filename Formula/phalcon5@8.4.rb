# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.16.0.tgz"
  sha256 "33db2df75a81224f710a2435f7f81c5fe1486ea1fb11579f66c4875a28b4d607"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "da24e68e66f46304302785eda6c94e8d5b5f3c773210f44ef9de10133f80af41"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e9b42cddea9b56c2186bd26f3904685fa73580c7a2457f5bcaecf6ee6c11263"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ad76c63465d195254263d4f649764c5639bbc98ca9d74c71f1f0c3f9fb20f103"
    sha256 cellar: :any_skip_relocation, sonoma:        "a490c4b3d3b518831112d322d306cbfa572e7edc088082d98d5f15f10f1421f2"
    sha256 cellar: :any,                 arm64_linux:   "79042b0d7dd295fb85a634e515dd0dace493caff72d54367fb00ebaa7e96088f"
    sha256 cellar: :any,                 x86_64_linux:  "018efe40857cffeb74b65ed7fe2e3fa4d2fdc77f9734bbfc19c910dc425764a6"
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
