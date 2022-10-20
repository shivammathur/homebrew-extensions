# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT72 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.9.tar.gz"
  sha256 "45b7e42b379955735c7f9aa2d703181d0036195bc0ce4eb7f27937162792d177"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ca145ac0f7a09383a8125f9a2ddba6ba0d4ba11ef41c40a6ecf0491befed552c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a9249b2e02d31871bd4924d1fe0a5dbf9ee7957bf55540b06e3eb3f560283675"
    sha256 cellar: :any_skip_relocation, monterey:       "ac1b6e36b895834109edc1514a05e9ae1c96f8c4a97b4fc38797de12c3d00e80"
    sha256 cellar: :any_skip_relocation, big_sur:        "cdfc989f19fd47df685ea072c903e128e8f38e269a4495df53f3f4418bc6db91"
    sha256 cellar: :any_skip_relocation, catalina:       "7bcbbbf6bd138ec836c51d0b45631f7661fbb42de6c03e2d34f3189c499e3e23"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d7eb05cc8adaad83e1190d04b95b89790ed30e8ed910074ac25cb96017fd303"
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
