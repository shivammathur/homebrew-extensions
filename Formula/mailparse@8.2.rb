# typed: true
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "dd04ff47f91b5d5ffae6bc9191e218541098b89ba9e7d395c0cea5a7ae185628"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1ca9669bea0ff737b4ed6c7843fc9b9f157f97dd6b164c79ed6b8b9ed4e60cf9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c4f4307cbd3c5988a2b9c43f6fbcefaea1bb0ec4e39ef4a67499d442c0b2758c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "e7f85b3cc9f4e69a47c37e4a82555163c55c4f0eb88c0897e9263c3699f00218"
    sha256 cellar: :any_skip_relocation, ventura:        "b0b4cdeadc582699ea573613e82d8f793b1160fe3543f335aa307aa951aec67d"
    sha256 cellar: :any_skip_relocation, monterey:       "ada8ff8b5f27bbd62d06a00677639d02d48bfcb50512ecec002132e5974cda72"
    sha256 cellar: :any_skip_relocation, big_sur:        "c0dafcc4ee269a2916eae67ae809f730e654fb402a46a98116690601df1762cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b94703842f6f04fde317037658210703099c1bccd89d27ad18183e16a2a631e7"
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
