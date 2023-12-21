# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT80 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2fe70139a34fa26fd117001e6bc1b549f4136ab146f36046ba05560b68b9c823"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "de234faf47e0c5ed06358954cb77e2c5706f7339b5f2f43771fccd258a4fb405"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "db68f551afe0691af5a9bafb4624c427085b7a8b45ee378d933bafc01ef36e8c"
    sha256 cellar: :any_skip_relocation, ventura:        "f62f7b065777cc7867d2663385666c1e14beb7a5bbbf49e3c53c0cdcd63d285b"
    sha256 cellar: :any_skip_relocation, monterey:       "0f049d7c715fe476e788604e9977aa38e5d0af03dc876e24cf68d22ec419d81e"
    sha256 cellar: :any_skip_relocation, big_sur:        "87815c1b3ab628bde71817784a645095c2f6aa4aa4586febd64b817385e52dcb"
    sha256 cellar: :any_skip_relocation, catalina:       "67497bb97007ca6fb2db27f961ccc12886ffcfb09eff7ebff4bb1c9c9cddf239"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3b57cdc8e7834885cf144e093b7ba433b98c81fbf1753b528c680593eec46982"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
