# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b27f20259a791810ec4be786c9092bafd50cc00ed32e37ac23c03b964c28d4e5"
    sha256 cellar: :any_skip_relocation, big_sur:       "cdb208b3c38546cf9638da9a8fa9f4b5175fafdb61b43b8994b42784d26389f2"
    sha256 cellar: :any_skip_relocation, catalina:      "fd645a9205c09936934a122aaaa7fdbc4dfdb5aa087aab93b89ccd795ed0a749"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e48287e46d1b7492f124d89071b4dcb078baa37f11f630d677ad47566d9e466"
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
