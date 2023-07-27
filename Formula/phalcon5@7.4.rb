# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.3.tgz"
  sha256 "f624b4557920aae70f2146eec520b441cf28497269ec81e512712fb3ef05364e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "20c0aaf0fa40be11909c529efaf157b7666bdf1fb92aa1b47773c1ec812b26e8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "86be22fb629bc0d54b2dc3618972c911071884f35972fd50ac241bb06a251e95"
    sha256 cellar: :any_skip_relocation, ventura:        "4cdcdfdd6f81f816558aaf9b070590deda461ebbc3e4be6a8e22675ee05a021a"
    sha256 cellar: :any_skip_relocation, monterey:       "3c5b3293856d86606f70da87b3a16971aa08237f2ffee7f7da7cf439592f0792"
    sha256 cellar: :any_skip_relocation, big_sur:        "a366e93c89e2a29c413ae0116836724097378eb7ef2cd4fefa5071acc377658f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a8d51a86349aa2554427a72655a648f8d61b0408df42281dd75a5e29983a77f2"
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
