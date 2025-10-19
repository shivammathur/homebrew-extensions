# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT71 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "90af7b99fd607218f003c1e98a20dad1a71d14128dc64a4b5d62aad2eff57cdb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d8c21a6bff6167de0835ae02abfb0c217ed6e43eb49de5eabebe973214055ed3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "adb3cd27259b0b79204bc1913dd942f1c78a6f04e8f8cfe605aba9fcfa302c9f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ec140ecb4d0a4f1d7b86d6759de45fc6dba30dfbfe3f806a8d2a29f687374daf"
    sha256 cellar: :any_skip_relocation, sonoma:         "4aafaf8d3c43dc1186c09c3b0f6c68de68506d4fa8f74fc8e5f04e3138eca4ed"
    sha256 cellar: :any_skip_relocation, ventura:        "9e07688ece2c73ccc30a11c0a7dc2f3ef64eb3a23831a6d26cabf15ec29446ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "ba3c58056bfdabe108e8e194192a526b991428adf17ac465eb6e2fbe53a7ddf4"
    sha256 cellar: :any_skip_relocation, catalina:       "9c1aa15e9e894d3bb05c222f1a5a38c2317b1ab27f3c82bd1093b4dd09056d7f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "d8f09277727262f372da722b17c1b7e360d6381ec6dfc7a52aa5810400a9ca96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f90707ad4084b15f144aa2c5c0f0c4babb06669d66dd2230d83456ae11480121"
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
