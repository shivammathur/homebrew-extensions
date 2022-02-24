# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "8f00e5408d708a26f9fb13ad2ae5e3b2886190918a8cb457875ff10f664dc80d"
    sha256 cellar: :any_skip_relocation, big_sur:       "46d6d406aa681c921a8721b626c61e91a3f975082289109124258eefe2c1fdb4"
    sha256 cellar: :any_skip_relocation, catalina:      "b6b9a8d410a73e9d52d48705ec55ff34bd55add75cfb299328c08f21699c8e96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6c82b94b5f093c0e02b4829ffc906a01b9ecd0eb3a016f19624bce2ed9158e0"
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
