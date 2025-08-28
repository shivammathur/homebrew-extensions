# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT56 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-4.0.11.tgz"
  sha256 "454f302ec13a6047ca4c39e081217ce5a61bbea815aec9c1091fb849e70b4d00"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6e01cc33c8a8aaf440219072cdc062753e5776e62a098a3ea2a8e7c2e51b21ce"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "97957e483c0a3885a5c5a62600efdbae7625b55061df5a6c630f9c811713e076"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c442d13e5d9cddf989492a274f52e550fe19e336bd31d50f9e1eb9d6ffa6b4f4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2b3e0b3e325becfc38f23b61b6d6971408cf8b0a5cc7abadafbc986d1a0e4227"
    sha256 cellar: :any_skip_relocation, ventura:        "c1bee03d5baf4fd40d5f2379822a612986466a8853a1dcb5b54e074527bd53ac"
    sha256 cellar: :any_skip_relocation, big_sur:        "cbbd4ece1390be2ce37a92e5edcc37b6943922b6a63b8805f3827f1d33145ecc"
    sha256 cellar: :any_skip_relocation, catalina:       "05a2015c696c7af16f78caea49c53d080ab0fd62639bec86f0a6d173d80945e8"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "41886eeb56d84ea861b7d2212565f681d20f8664f27b8cf85dd5bbb0fbc71931"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "18df7209023c77b357e39613b6c1317671425e6ccaf9b57d790a274090e0a3ab"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
