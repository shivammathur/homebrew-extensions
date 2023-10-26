# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.4.0.tgz"
  sha256 "47810a0aaa20c1a3cf0a2d7babccfa1870fa0fc78d30cefd45ed808f89d47619"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e2ed4c768fe552862ebec5a7cca34fbe5bb75171c6d5ef4df2486d82602ef8f4"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "87af253342067f6539a056cc27370683a5b683187070fae7ab2e1df14ed6ac21"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c3d8801d8a06c96794b536828d2f69bd222832f4efc77934e3160d6453c15b37"
    sha256 cellar: :any_skip_relocation, ventura:        "e0762eb1c9c8a6cb4c2da3a7c3e1de7d852bffae3630663163677808e3eb4622"
    sha256 cellar: :any_skip_relocation, monterey:       "19badd15e07b401d08640bb1efdce44a1f6c7bcc326a9dfcea2a7d4dc565578e"
    sha256 cellar: :any_skip_relocation, big_sur:        "9b6c086f3ba58220640e74e911fa630994b4f214c51b8476a9cbced77bd4f63d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3d32cd02834052b99af4f363954a4b94756456ff4ac078b945ebea80bfaf297"
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
