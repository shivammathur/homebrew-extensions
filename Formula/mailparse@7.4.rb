# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.5.tgz"
  sha256 "34c685c102a6b57a3f516e9d8fc8ef786bd191c321d0f5d1d3764c1f1ee20620"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a5791a876eb84b2303dfb6f918ae2449b988ed1a5f65ce3675355e1c5adb77b7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b7ecab267e87c681775a3b00e807e836a3be9ca9be554a7e12f03e9b824aed61"
    sha256 cellar: :any_skip_relocation, ventura:        "1f9fcc31e66c34445953335333e1a52c75052780e8f6d8c0a5d189d50dedf7c2"
    sha256 cellar: :any_skip_relocation, monterey:       "95e2bcf1221907d9a6efae177ca6afe52d30da790324cd4700729fb36bbe9f73"
    sha256 cellar: :any_skip_relocation, big_sur:        "6f67e6112d44d742157d6e4808c00a74e5de2f4438fbfcf6a1e653a02a2a7a32"
    sha256 cellar: :any_skip_relocation, catalina:       "5874dad6dd097cb3cefac8a894d2faf3e725ef97529db461f7e795eb75335e53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9b27161bdc6fe03c5c195040fdbde66042fbcd279d805eb9ca0f127fbbfa5fee"
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
