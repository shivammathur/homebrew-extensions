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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b8c3bac2fc01f8a954277a7b1dc82518666f375427bf2db18143021ea1663bf5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a624754bf8e6a1ab787932bf59ab06737c7fb42fd021d5f7d8bf0d76ec0b1902"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5178331297a95e7246da595e8041dab9707aecdbb31456e90e162de3fe9c94c2"
    sha256 cellar: :any_skip_relocation, sonoma:        "779e35c9426fa24a4d8a7c9eea3eec470718e17b5722e7be36ef4b1771725bee"
    sha256 cellar: :any,                 arm64_linux:   "54c4a8698861dbc10a2637e34715fac1f4072156b391c81494687e13968f042d"
    sha256 cellar: :any,                 x86_64_linux:  "450b5657dbf848e8cc9b1691ddd96fe20aba7f33cd82849bf8deea852bccf4df"
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
