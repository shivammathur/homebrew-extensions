# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT70 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "2c2767be138c7a67579a31286e4bd6e21b626a5a170471a68b1da155d8660147"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e48a05e3c04dfb8ce7f322da218e537369dbd0457223855f5a9362f803f588b3"
    sha256 cellar: :any_skip_relocation, ventura:       "76106c47ace0f41647a85d90525535b973d5c901cc98ee7042e604252e55f4ed"
    sha256 cellar: :any_skip_relocation, big_sur:       "94ffe12803d3f8c75fdc952d3ee164c6adfbcfe18e7e5955005ab0e17fe75213"
    sha256 cellar: :any_skip_relocation, catalina:      "1f7ce5f5958c373eaa8286811ef5506e32b97671f6dfb99334b213b940f13f93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3ebf5f09f79b2a62f7c81571ce3beed383bba006d2065f1ae40bca531b0661aa"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
