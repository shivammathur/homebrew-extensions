# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT72 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "169d48ecc42d71789b6dac5cba84987e123f78a0d1d045fe6a61940142bfcdf7"
    sha256 cellar: :any_skip_relocation, big_sur:       "0ce81f531264ad87c584d79c40c8ef7e6dc496b83ae6cba1ff4b0afc72a57158"
    sha256 cellar: :any_skip_relocation, catalina:      "5eedc7a69ea019dbec640d15e13b6a15d3b365a2448b2c48f2c1b1904ab41b7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8ae14dc901e430b5f3e19097747031135d535d6ee00436ffdb4e7195374e2d04"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
