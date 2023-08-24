# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT83 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c139923f5c8af19ba59d6c930d285c800c67360c9906e8a60d803285b7493a9f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3a9ee821da0380c1f4ac98a180d04e210bf1da0c13a6fe14bdb92f3c0fd6495b"
    sha256 cellar: :any_skip_relocation, ventura:        "2e832007e4d60e139ec0b9deb3bd11e55780d6c1479804591aa95f6ac99d4b26"
    sha256 cellar: :any_skip_relocation, monterey:       "d7219ab72e833807871301cb4d6e0651f5fb6b823f2e2b921e2e64df547ffcc4"
    sha256 cellar: :any_skip_relocation, big_sur:        "1dc16d6e9233bee6c724280ddad9842d20499dce8473bfbfc2f6e4eb5b9bd851"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "432aae90d0da098ca9894e75952dc061d5ab3cef72d78c086ffc3273d29e3c5f"
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
