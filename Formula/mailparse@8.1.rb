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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "140bfc594ac94dd32c79802927b8a82cb958a7b668d930a176231a5602ec5c94"
    sha256 cellar: :any_skip_relocation, big_sur:       "40483264d141f0970c4a0a73a6da5836fc98662ea15e40c957323a0c8559f5f5"
    sha256 cellar: :any_skip_relocation, catalina:      "c9abdf59a640e3478af71f9a47196d2854ba564be8348ae445ddb07f5e749b1e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1c588c06ba0a5fef9b0ac202529e2605be26a5db86b3c10341c7b4c3528eb34c"
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
