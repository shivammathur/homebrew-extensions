# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "73be7d31bbc9b44cb495582245f4e038574bfae8dea4d9e378217786463e6e30"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c34206449def5d2e16b5ba735f277afecf9fded1e19f21304c6303dd22588f68"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f09b652456bab4e60db2e11ceffd16dbf08c0c82eb0e81cec93b830e056ca98"
    sha256 cellar: :any_skip_relocation, sonoma:        "a626936cf1b71c3e66cd92ce72991803e0334536d8ba4755ed6e68f443cc7abb"
    sha256 cellar: :any,                 arm64_linux:   "30adacf4d1e508018d42196ea0622e675efb10040534d1147da44ce74b897eea"
    sha256 cellar: :any,                 x86_64_linux:  "b385f280ae0c6e89d61c83adc8db9454a84668b409c4a7b5c4df76e107290307"
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
