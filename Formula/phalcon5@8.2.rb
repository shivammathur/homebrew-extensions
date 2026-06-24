# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ff72394e17a25cf7db9926131bc52663df99da083445372362c6a514b9e06f35"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8431aaf952185bebef14b0ecb0716033c13d0edb9ac8b3d64b6fbc8c52a42244"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "aaba224cbeeb9f36e0b5dccf1c33d768f58fcc93352f3345e478ec14e6a21099"
    sha256 cellar: :any_skip_relocation, sonoma:        "4b726b137e00ad28e48e7c5d3c87acf70bdc27f58b4499c81c3ab13e105342c5"
    sha256 cellar: :any,                 arm64_linux:   "75ed09b12fb5ea3434be8c42d0b63e2e835bf2570d9efb7dad743513df498f82"
    sha256 cellar: :any,                 x86_64_linux:  "18c983893ad652ae809928da4f1b968fbbf93d0e87b50b5743ed8ba78c753400"
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
