# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.3.tgz"
  sha256 "f624b4557920aae70f2146eec520b441cf28497269ec81e512712fb3ef05364e"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9faf549b427dba0d8ba0f92a8273052bd693af642a80ff60f5d6fe6a8004378b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "079f7da6f0b05338f93e508e26aaffc9d3b775737447178c329b4ef2bc49b9a6"
    sha256 cellar: :any_skip_relocation, ventura:        "68891dea952db963bdfd6ee95a8a984780eeaca0da0299a68d56a1ff11d3d97f"
    sha256 cellar: :any_skip_relocation, monterey:       "2b26cc9eaf483bd6c8a2537db101fa43bf3d177558e71181e449d29373ada395"
    sha256 cellar: :any_skip_relocation, big_sur:        "754bbf43a85e1db293bc9bf6c5a869b2562195854445f52a953e1601b9795994"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c3cdc462f6324344719ed626b05a62d447a3840f617b30f63d8e2b8c5a37ad16"
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
