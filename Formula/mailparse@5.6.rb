# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT56 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-2.1.6.tgz"
  sha256 "73705197d2b2ee782efa5477eb2a21432f592c2cb05a72c3a037bbe39e02b5cc"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "3502ce17256db8ab5e271861530bbd3533fd853b120c00ff7b4cb43ed4bf2ca4"
    sha256 cellar: :any_skip_relocation, big_sur:       "2cf4ff3f590153e6e3305424b7054e1ea7b6bf111c7acdb48472cf5f17a46a17"
    sha256 cellar: :any_skip_relocation, catalina:      "1f3d1ef9cdb318ea53c9334e285771d3eb594472a938fa95dd51b0d1e5f74ec2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0de6c5ff5a74c3cf410264432b7cdb8a8746cea84fbdc9c13394d8e61fd0c97e"
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
