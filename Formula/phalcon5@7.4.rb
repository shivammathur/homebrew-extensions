# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.0.tgz"
  sha256 "b65c663fa36e2184289cde64d30c5b62b3d94974b9e99258a49a9a3fd338c788"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "000cc9bf1915e6daf70eba845b3fc55653b04ff468488400ae872bab99c84745"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "dd663f721fc6ecd2a7cea0279c860249976599ef13f47f6b76ec6400435a516b"
    sha256 cellar: :any_skip_relocation, monterey:       "0cf87bad5e6d1be6dcaea502b35faaa2cb8f2781a6be77bbbcfb1c50621bf3ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "a520c16f35c7d368b0ff11377e3fe5d5ffa5da7f64164cddd8a89953ea71746b"
    sha256 cellar: :any_skip_relocation, catalina:       "e2666188b1a9b3885797f01dd837096da8ea04139f1514cf2eb7170313a79cfd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a728169059c747e0c50d5b2ae684c02014cd8ba1447757e5f717dc86c8bc95b"
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
