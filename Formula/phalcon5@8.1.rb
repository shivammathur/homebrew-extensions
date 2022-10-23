# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.4.tgz"
  sha256 "1d65dec6d5d9be6fe331616615933a455dc008d8d1c132fefbd44a371221347f"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "480d90454a27b022ac513151fc2c9570896beb12dfba2213e0b2f6ab908fa4f2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "859e5f5b8085f1a58639b529837e33eca891fd9f88c49d2a06a4ffd5d3439eaa"
    sha256 cellar: :any_skip_relocation, monterey:       "4dbba9a4b27805ef70ca2f1227aca59cdab7520ed47375e7ec1dcd76a2acfc91"
    sha256 cellar: :any_skip_relocation, big_sur:        "d638ad5dfa03582b7cef0d40c51919ccf363e0f74f2544be0f6ba793c99e0849"
    sha256 cellar: :any_skip_relocation, catalina:       "617791953fc3a76f8559166b352d03d429e612ddeb61e6d52adef73807e72776"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cd5fd02aecdd162cae35bb40617a4b390b448b969a0599fc32bba7e3f5687d88"
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
