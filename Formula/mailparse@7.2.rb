# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT72 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.2.tgz"
  sha256 "b0647ab07ea480fcc13533368e38fdb4f4bb45d30dce65fc90652a670a4f4010"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a6b55d5d89bf34a4d9bf5a5bca18bfbc33abc9f1c35e61ecb2ed29aeffab61a7"
    sha256 cellar: :any_skip_relocation, big_sur:       "ce3a447a58738f45b3306a42024c3d9ae4e9ade7c1d83706b946e50d9e22fe05"
    sha256 cellar: :any_skip_relocation, catalina:      "a7eefb15564457176b03187249ad0073e2338662451fea6c22b17de6fb27d9d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "db7a6260fc9d09fa60f0fb6dea6ff1275573a8d5a3d951ce99d4ced2bed9a7db"
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
