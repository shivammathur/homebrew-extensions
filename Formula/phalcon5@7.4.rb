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
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c7f15a4872435e977ce33f4e82d572d4f820e7c1bf05d03fdf16d7feef414729"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "656e03c52feddaccd4bb503f335289cb412fa79297c08c691a1fbbe8609e10eb"
    sha256 cellar: :any_skip_relocation, monterey:       "2cdccffae34885504dab6f78dd8ab27373a572a1c435dfb1e45c9170a17bbe69"
    sha256 cellar: :any_skip_relocation, big_sur:        "6cab8bbd3937a8774aa695f6256168e9f10bfb5787f14480fdd747ea1d0d7c7b"
    sha256 cellar: :any_skip_relocation, catalina:       "632b0b1ce0036733b29adb31c80856f7babc354650f0268ee077d7ed44df7ba1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "09ad80837251403c16dc789f16edd33111fefbc1d597151c721857036199f3e2"
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
