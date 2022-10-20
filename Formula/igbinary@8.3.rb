# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "b389ad7d341bc301ccfa8c37716e61154e0d9c7742e2f65717aa843e62ba0ade"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "169942f7547d27629b83208fb3afcab39e00ffbf65ff9b0a9bd5aa6c6acfb421"
    sha256 cellar: :any_skip_relocation, monterey:       "f0033f4633a47a6d4f9124437fe9954e773e8e42dd77cf702da9075c562a6eac"
    sha256 cellar: :any_skip_relocation, big_sur:        "72d8afabe58944052934101df69a51fc47f04a4dfb6e5672dcf64b6028040a59"
    sha256 cellar: :any_skip_relocation, catalina:       "7be7678c79d57444654b2f610ae1305b9dbd89bb99d0f98ebe7e040e6bc45ab6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "260acfe4ac6cda5084038a829513415b70f168819c4bbbcd97cc10d3b61beffe"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
