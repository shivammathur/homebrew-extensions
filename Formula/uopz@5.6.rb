# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT56 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-2.0.7.tgz"
  sha256 "16841e086bb13475438a72b77bb726399476dd04f72b2c63fc0521ef0ec66800"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8e0ba9198ab13a4913cc8e506b539fd6068ff6b0602af70691961e700769d6a3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "94bada52b55b3db9841561100081ab040342ae25354dc219fca080e013d8cef6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4716f4826e617d7ac64b430c02f4cd543cd710e2c9ce2fab20b9e7010a6fb860"
    sha256 cellar: :any_skip_relocation, sonoma:        "e3d98c7ea87102f15ab66043626f479995a69a779a11be9d150f4f6baad660f4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "105df2a6c2c60c2bda7d46feab0c3519ddc0d16e4ce12f8dbc11726581a8b78c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b16dbcb523cb0fe884c057290dd156966464a0f843b157879334755c60db7202"
  end

  conflicts_with "xdebug@5.6", because: "uopz requires Xdebug 2.9.4+"

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
