# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "78489bf63ad528456bf6289c503f11fd85ab9d351a8f4bc815e10f3f2f16fd8b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1a2fcaabaa1487c0a87e90e613b287720896fa82655f6bebd7c013b2a2d08922"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "154b263247c515276aba32e95eccf1b85ab40ad2bbad38dfc051cba10ee5b609"
    sha256 cellar: :any_skip_relocation, sonoma:        "f30641585bd09f32366401b0d1e06e7509cacbb1be47d7be3c834cfd5c23e927"
    sha256 cellar: :any,                 arm64_linux:   "c7e3c0e89953e61189ebe1710d7a6a873a389508e24547543ca016d96d469b36"
    sha256 cellar: :any,                 x86_64_linux:  "0a54e62f58bba16e1632f6602d97e9d374715aa0628cff0a8a87f667f5f09826"
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
