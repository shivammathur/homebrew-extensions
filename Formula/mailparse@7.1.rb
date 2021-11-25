# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "9b3afccd474fd0f7cf3c51eb899892976f6dd0cf07de847decd9813a17910dbb"
    sha256 cellar: :any_skip_relocation, big_sur:       "d2c166fc1a31488165fadc5d2062249f3e3a963f28c3c4e9da8c91c632ac8e68"
    sha256 cellar: :any_skip_relocation, catalina:      "f7eafef699871c50e1d6baa7123c73e694c9bbe4e6dd9193dd28a5f4f15c836e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "70c9e66f9392aa9d9d4476a03f4f6c341c34657f03bd66cc1e172a6665f25997"
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
