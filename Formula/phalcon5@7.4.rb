# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT74 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.0.0RC4.tgz"
  sha256 "31d3c2051dab6ff2cf08957b505bcc34ba4278e3004b335e03b8a2182ee01065"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "621f05761a9d02ecb380e8b3e0685d2b8db89cf599b5efc02dcfc9859b364221"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4d8c7da00668af5e03268f36862dfdd395a5479ac2170b8172e6cbb30393cb2e"
    sha256 cellar: :any_skip_relocation, monterey:       "c1c242e2e55aceb163d832eaa032cdcb19f56424c279de0abd1b7559d60c5830"
    sha256 cellar: :any_skip_relocation, big_sur:        "90f1ff2f50ea0edc12ceb0243b036734be18f6f71b8768d8fabd01a0e801cdbb"
    sha256 cellar: :any_skip_relocation, catalina:       "7855032e24aa7382737f8998398b3c232f10d489ea6a4b3df47360a34804851e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "178a7db7d94f9c03727ca4162c154e4d48577f663575cd2625d00e8f5103247e"
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
