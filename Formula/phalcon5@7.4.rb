# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.1.tgz"
  sha256 "5ce7d9be892c8ded97f8ac6009a7e3ca2f95550c615f6735a34d5d7c8b736d74"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "11241d81bbd54dd812fceb838adf20a4cdeb1438cd05dea56e3a332538ae279f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "42e32a095237dfbad2e7a5398d8f115e03046d54da7cc39903d520a55d015af6"
    sha256 cellar: :any_skip_relocation, monterey:       "a52c16cc3d6d0bb1fed8405e62ff05c318a850ebf72ea85da44352d618fc944f"
    sha256 cellar: :any_skip_relocation, big_sur:        "4a22f91931ffb6e6d0fdc5dffcb2ad520eaa3f70f6f16dbb0c4242866f522d59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fbe7f9613ca34460e1d92e858ee4b8da8ffc81c053fc3d945239b78d4896befb"
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
