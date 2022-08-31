# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "80a8f6d6290802d1348997e35a7bb44e19e566f665c60c0d5f6ae922518b6a5f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f2ca2908547744c4a881269acae00eecf6224bef36ed6d8d87a171ab154efd9c"
    sha256 cellar: :any_skip_relocation, monterey:       "9b9393ff722ef9880da64c40a36bb1b26804c8eadf0df2fb10bd0355c83fe406"
    sha256 cellar: :any_skip_relocation, big_sur:        "7ebbfdd67e15b977819c45548736dca2d3007b3d888c54ca1089d4f7d3a5515a"
    sha256 cellar: :any_skip_relocation, catalina:       "b6441e0566f568d854b4930f98fe548b2a032eed9e8312b95a08a6026f671cf2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c527e3f756c458276b87096fe10f47212ee94c6a8103838f0a5a0ef00624c1bd"
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
