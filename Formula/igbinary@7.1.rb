# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "88687e75e2598a0823201be76ee7aaa0bb6b0657abe3e0c15c6f83c690f0b2c7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "703c08cc3a3745368a72adce2ae2371eef3892a64274f53e581f08d466c0e92b"
    sha256 cellar: :any_skip_relocation, monterey:       "c82196237972d0e72a6f90cc256caf749cb9239ce4ebe52ecc0fdb56146578d4"
    sha256 cellar: :any_skip_relocation, big_sur:        "e5a8061a6237c7a195adc729884ecc2a6ae8c63c7f51191f3f3657c4e0a7fbee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "68dee0c6d62e29b7119d08f5f88867a13efda5451da3b2f1ce8de4a3360bb7ad"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
