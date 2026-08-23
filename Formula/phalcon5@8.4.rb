# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.0.tgz"
  sha256 "927caeda88334a33934d17b7d3b70ff46e0649e577f1339dc711bdb853290345"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4eb32c0b3f89df9ac0c4205aace687aa4bb26b99694656d4d3e0588eb3ad7bbd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dcabb39b553c79891cdf588ece25fa178464b2db41043be628ab8646bf922b6d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6ce69ffe7568ca71bd937e1518bc2d6cc3374f093022222539fa8ff87c2668fc"
    sha256 cellar: :any_skip_relocation, sonoma:        "7e1fd16246d57dfa5f1c5c7e5ec576058cb0b30ea1e6dedfc90de2366386992d"
    sha256 cellar: :any,                 arm64_linux:   "1baeb2217a59e0cc5cedc8cd131c7fd8961308107e6e8155a297cf2a7891a43a"
    sha256 cellar: :any,                 x86_64_linux:  "f8deb7deb9470a3afa068a478227d79b2ad83db0a8b1bd8f0b9475c44c93a536"
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
