# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "51b4d35bc235dc4c03ae1eee053212beef8a0ac2cdafc0b811288f1dc5e60510"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a5e1a9819a63647e2e77f1890bef36f1b593cbe3153be9d13ba352800db84bf8"
    sha256 cellar: :any_skip_relocation, ventura:        "899e5c8479c33ec4a5e0782e458c8c573b20cdef42735497030e66d17477d0ba"
    sha256 cellar: :any_skip_relocation, monterey:       "af216452c2d3a70e8ac354ee843840440396a0a1fbae6e3c0ab8ae628d229f4b"
    sha256 cellar: :any_skip_relocation, big_sur:        "10d40aa85a6817d4f53685ca411a6a94e9ffbeccf1f651f962c7ced2bcc415b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bbc944d016fb17a41f2d2c3621751bd7530ec881b02cd3f8dcb9c67598b31380"
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
