# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "7d8558f1ff44a989c339dbf52ad7f32ee82d70a4fd4f24f7d6393768fb8d740a"
    sha256 cellar: :any_skip_relocation, big_sur:       "61e6667e28e5c43dc2d36dfcec6736d68812954762c69db347bfc3f58a0bbeeb"
    sha256 cellar: :any_skip_relocation, catalina:      "ca7efa2422a7d204e974ad3fab0295cab1b4c96cf706ee2d9bada756ed60114e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7712b98ba1ad6576d6861ab1b7fd0fd1e1d5b9641ec4628890a50c02fb33e600"
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
