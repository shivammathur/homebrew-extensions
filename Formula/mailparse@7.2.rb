# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT72 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.3.tgz"
  sha256 "8659ca62dc9a4d7d15f07f97a0e2142cb58251c8e772cd36669ec740d2292471"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "7f64dd521b52d973a90b986e4c533078212637b5c87fb5eba43a551084610799"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "71f7ef538b072c8d872e932b97d0ef8b4ab421b08600d3c8230b16bd028e838f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "902a18e74b6888c2e18cf2b999c80f8e183880a5b71603a71e7ef84a90cc30e5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f06e175c966786e514a46a5383c926caa58ea572df9b384a2158a39c942e299d"
    sha256 cellar: :any_skip_relocation, ventura:        "58396970e056c0f755298539d2d3a88833eaa0c11b2126a6c93ab00e73084031"
    sha256 cellar: :any_skip_relocation, big_sur:        "32a5f199a260d8a1f1d78e9e0690cdbbc0f0c917da5e907e867ae42f0edb8ba9"
    sha256 cellar: :any_skip_relocation, catalina:       "cf6f724472d2760e884f8be30df6f0b1fa1832c02adc9f5f91a07be24c7a1048"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b0be4b55a82cb6327da602d719d4e67aa7a1b463cda5ba274c92d731e65259b2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3ba871a50281191fff23a2cb9e5a4d0ab6d5ab528536311767b4917e09c10212"
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
