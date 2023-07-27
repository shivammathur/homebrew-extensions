# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.3.tgz"
  sha256 "f624b4557920aae70f2146eec520b441cf28497269ec81e512712fb3ef05364e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dde4749826c0a02c69627ff0545c5e616eaeae4e4eb11ecf54d207d3eb51c903"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5e1dbc90e70830a0cac54403e7a42bc77a40a1199c54b285c51271678278de54"
    sha256 cellar: :any_skip_relocation, ventura:        "bda3dae6acfa29ef7a34fa0af0752874e6d805588d73fd5e6ac86605f6d902c7"
    sha256 cellar: :any_skip_relocation, monterey:       "7cc667832376544672ec206bac1d1259eb6744bcd818ca3cfb3c4b431d4c08ff"
    sha256 cellar: :any_skip_relocation, big_sur:        "95aebc61e38847be8311204a08ea6b4286868e10fef03638a182e71a5e429dae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d1bc1bdf2b77ec5bdb6d7cae382317916cac3065770f8bbe2e406f4358facc3c"
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
