# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.4.0.tgz"
  sha256 "a9b930582de8054e2b1a3502bec9d9e064941b5b9b217acc31e4b47f442b93ef"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_monterey: "24ed4020cd40045824b8d65998438cc9b9b2404859ce13fe68ef1b8ece618bf6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "02406c88b74560b615005bd36d5961d45c905f2ceb63832301ea3428b2c0a7b0"
    sha256 cellar: :any_skip_relocation, ventura:        "fe800262fed45932e3250dacc3dc79e91c8b56498b75d8b2ef75b357b13df80f"
    sha256 cellar: :any_skip_relocation, monterey:       "47036c78ba083c2d8351c8b150d618ded991bf1fc13988bb696f2390b87c042d"
    sha256 cellar: :any_skip_relocation, big_sur:        "6e1d050eca03e9246df9fc1d7aa6e9fbdb3505dd6b6555dfe6ec9afcce790dc6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "546d66cf58b5ce3cf258f1b6d8f72aac9c2e42d543e6df09f3d118d811edadc8"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
