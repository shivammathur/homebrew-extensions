# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT73 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "79f291eb380a2466f9b62ffb175613a9ae3494414296fa979d6e5c1356cecbd3"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0b8496e0bfe7da4deb7b21f32e930bacb48f358e2a6a9cd8b62b6970beac2d9f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "079459e95d005b789b96f42b6023db8904ad19a57064e083d8bf1fb176ed7349"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1609cfe6a0a1834e55375d0c65d65c3d666dfe625e4a65424d9fb67308154eea"
    sha256 cellar: :any_skip_relocation, ventura:        "d37a903822b3a0dc5ec869687fde5f49237c991c794e9fbe0bb4228627c6d161"
    sha256 cellar: :any_skip_relocation, monterey:       "5f6ac29fa951f798790acaa14363c109f388070c2f9c46d1c2ca1559e72679fd"
    sha256 cellar: :any_skip_relocation, big_sur:        "7e54d837a3eff999a99ff8e7d4f041ab0e87852d499a66856ee3088615557b84"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7bcb89529baef8be3bb2d47f3a64c2011602855646869656661d4ad02adfaeb8"
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
