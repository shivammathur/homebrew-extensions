# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8cb0515bfea7cde7a5e8620a28e793a250a4a56036216f2c28448c1cb90f01e5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "026db5e411b304c18f5d7103de1cec58006c6b5b26cde96e9fca7ff84de10697"
    sha256 cellar: :any_skip_relocation, ventura:        "5b9ed3ec62813c7a475356774eee8eb84d8d13b6fd769b29358a6b219ee69ebe"
    sha256 cellar: :any_skip_relocation, monterey:       "671c535241e3b5e243835d6e05198a9f1df9ee97b6e08b1eafaecae4d7374e5b"
    sha256 cellar: :any_skip_relocation, big_sur:        "c6d5dce0ca2e4d39b373366d8103eaf5aa51a0809305a8d62ca4c36b7742933f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a1b6bd99f741e678d3887be7cf64c00310354d358f0ce2cc4e1a4f3bd9c6d3c2"
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
